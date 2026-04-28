# Create-AssetTable.ps1
# Creates the Asset table in Dataverse based on the Meridian Asset Register ERD

# Replace with your environment URL if different
$envUrl = "https://code-apps-dev.crm.dynamics.com/"
$token = (az account get-access-token --resource $envUrl --query accessToken -o tsv)

if (-not $token) {
    throw "Failed to get access token. Make sure you're logged in with 'az login'"
}

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
    "OData-MaxVersion" = "4.0"
    "OData-Version" = "4.0"
    "Prefer" = "return=representation"
}
$baseUrl = "$envUrl/api/data/v9.2"

# Verify connection
try {
    $whoami = Invoke-RestMethod -Uri "$baseUrl/WhoAmI" -Headers $headers
    Write-Host "Connected as user: $($whoami.UserId)" -ForegroundColor Green
} catch {
    Write-Host "Connection failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Replace with your publisher prefix (lowercase, no spaces)
$publisherPrefix = "crc13"
$tableSchemaName = "${publisherPrefix}_asset"
$tableLogicalName = $tableSchemaName.ToLower()

function Test-TableExists {
    param([string]$TableLogicalName)
    try {
        Invoke-RestMethod -Uri "$baseUrl/EntityDefinitions(LogicalName='$TableLogicalName')?`$select=LogicalName" -Headers $headers -ErrorAction Stop
        return $true
    } catch {
        if ($_.Exception.Response.StatusCode -eq 404) { return $false }
        throw
    }
}

function Test-ColumnExists {
    param([string]$TableLogicalName, [string]$ColumnLogicalName)
    try {
        Invoke-RestMethod -Uri "$baseUrl/EntityDefinitions(LogicalName='$TableLogicalName')/Attributes(LogicalName='$ColumnLogicalName')?`$select=LogicalName" -Headers $headers -ErrorAction Stop
        return $true
    } catch {
        if ($_.Exception.Response.StatusCode -eq 404) { return $false }
        throw
    }
}

# 1. Create Asset table if not exists
if (Test-TableExists -TableLogicalName $tableLogicalName) {
    Write-Host "[SKIP] Table '$tableSchemaName' already exists" -ForegroundColor Yellow
} else {
    Write-Host "[CREATE] Creating table '$tableSchemaName'..." -ForegroundColor Cyan

    $tableDefinition = @{
        "@odata.type" = "Microsoft.Dynamics.CRM.EntityMetadata"
        "SchemaName" = $tableSchemaName
        "DisplayName" = @{
            "@odata.type" = "Microsoft.Dynamics.CRM.Label"
            "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = "Asset"; "LanguageCode" = 1033 })
        }
        "DisplayCollectionName" = @{
            "@odata.type" = "Microsoft.Dynamics.CRM.Label"
            "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = "Assets"; "LanguageCode" = 1033 })
        }
        "Description" = @{
            "@odata.type" = "Microsoft.Dynamics.CRM.Label"
            "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = "Meridian Asset Register hardware items"; "LanguageCode" = 1033 })
        }
        "OwnershipType" = "UserOwned"
        "HasNotes" = $false
        "HasActivities" = $false
        "PrimaryNameAttribute" = "${publisherPrefix}_name"
        "Attributes" = @(
            @{
                "@odata.type" = "Microsoft.Dynamics.CRM.StringAttributeMetadata"
                "SchemaName" = "${publisherPrefix}_name"
                "AttributeType" = "String"
                "FormatName" = @{ "Value" = "Text" }
                "MaxLength" = 200
                "DisplayName" = @{
                    "@odata.type" = "Microsoft.Dynamics.CRM.Label"
                    "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = "Name"; "LanguageCode" = 1033 })
                }
                "IsPrimaryName" = $true
            }
        )
    }

    $body = $tableDefinition | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri "$baseUrl/EntityDefinitions" -Method Post -Headers $headers -Body $body
    Write-Host "[OK] Table '$tableSchemaName' created" -ForegroundColor Green
}

# 2. Add columns
function Add-ColumnIfNotExists {
    param(
        [string]$ColumnLogicalName,
        [string]$SchemaName,
        [string]$DisplayName,
        [string]$Type,  # String, Memo, Integer, Money, DateTime, Boolean
        [int]$MaxLength = 100,
        [string]$Format = "Text"
    )

    if (Test-ColumnExists -TableLogicalName $tableLogicalName -ColumnLogicalName $ColumnLogicalName) {
        Write-Host "  [SKIP] Column '$SchemaName' already exists" -ForegroundColor Yellow
        return
    }

    Write-Host "  [CREATE] Adding column '$SchemaName'..." -ForegroundColor Cyan

    $columnTypes = @{
        "String" = @{ "@odata.type" = "Microsoft.Dynamics.CRM.StringAttributeMetadata"; "AttributeType" = "String"; "FormatName" = @{ "Value" = $Format }; "MaxLength" = $MaxLength }
        "Memo" = @{ "@odata.type" = "Microsoft.Dynamics.CRM.MemoAttributeMetadata"; "AttributeType" = "Memo"; "MaxLength" = $MaxLength }
        "Integer" = @{ "@odata.type" = "Microsoft.Dynamics.CRM.IntegerAttributeMetadata"; "AttributeType" = "Integer"; "MinValue" = -2147483648; "MaxValue" = 2147483647 }
        "Money" = @{ "@odata.type" = "Microsoft.Dynamics.CRM.MoneyAttributeMetadata"; "AttributeType" = "Money"; "PrecisionSource" = 2 }
        "DateTime" = @{ "@odata.type" = "Microsoft.Dynamics.CRM.DateTimeAttributeMetadata"; "AttributeType" = "DateTime"; "Format" = $Format }
        "Boolean" = @{ "@odata.type" = "Microsoft.Dynamics.CRM.BooleanAttributeMetadata"; "AttributeType" = "Boolean" }
    }

    $column = $columnTypes[$Type].Clone()
    $column["SchemaName"] = $SchemaName
    $column["DisplayName"] = @{
        "@odata.type" = "Microsoft.Dynamics.CRM.Label"
        "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = $DisplayName; "LanguageCode" = 1033 })
    }

    $body = $column | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri "$baseUrl/EntityDefinitions(LogicalName='$tableLogicalName')/Attributes" -Method Post -Headers $headers -Body $body
    Write-Host "  [OK] Column '$SchemaName' added" -ForegroundColor Green
}

# Serial Number
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_serialnumber" -SchemaName "${publisherPrefix}_serialnumber" -DisplayName "Serial Number" -Type "String" -MaxLength 100

# Location
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_location" -SchemaName "${publisherPrefix}_location" -DisplayName "Location" -Type "String" -MaxLength 200

# Purchased (Date Only)
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_purchased" -SchemaName "${publisherPrefix}_purchased" -DisplayName "Purchased" -Type "DateTime" -Format "DateOnly"

# Warranty Until (Date Only)
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_warrantyuntil" -SchemaName "${publisherPrefix}_warrantyuntil" -DisplayName "Warranty Until" -Type "DateTime" -Format "DateOnly"

# Value (Currency)
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_value" -SchemaName "${publisherPrefix}_value" -DisplayName "Value" -Type "Money"

# Supplier
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_supplier" -SchemaName "${publisherPrefix}_supplier" -DisplayName "Supplier" -Type "String" -MaxLength 200

# Purchase Order
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_purchaseorder" -SchemaName "${publisherPrefix}_purchaseorder" -DisplayName "Purchase Order" -Type "String" -MaxLength 100

# Notes
Add-ColumnIfNotExists -ColumnLogicalName "${publisherPrefix}_notes" -SchemaName "${publisherPrefix}_notes" -DisplayName "Notes" -Type "Memo" -MaxLength 2000

# 3. Add Choice columns (Type and Status)
function Add-PicklistIfNotExists {
    param(
        [string]$ColumnLogicalName,
        [string]$SchemaName,
        [string]$DisplayName,
        [hashtable[]]$Options
    )

    if (Test-ColumnExists -TableLogicalName $tableLogicalName -ColumnLogicalName $ColumnLogicalName) {
        Write-Host "  [SKIP] Picklist '$SchemaName' already exists" -ForegroundColor Yellow
        return
    }

    Write-Host "  [CREATE] Adding picklist '$SchemaName'..." -ForegroundColor Cyan

    $optionMetadata = $Options | ForEach-Object {
        @{
            "Value" = $_.Value
            "Label" = @{
                "@odata.type" = "Microsoft.Dynamics.CRM.Label"
                "LocalizedLabels" = @(@{
                    "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"
                    "Label" = $_.Label
                    "LanguageCode" = 1033
                })
            }
        }
    }

    $column = @{
        "@odata.type" = "Microsoft.Dynamics.CRM.PicklistAttributeMetadata"
        "SchemaName" = $SchemaName
        "AttributeType" = "Picklist"
        "DisplayName" = @{
            "@odata.type" = "Microsoft.Dynamics.CRM.Label"
            "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = $DisplayName; "LanguageCode" = 1033 })
        }
        "OptionSet" = @{
            "@odata.type" = "Microsoft.Dynamics.CRM.OptionSetMetadata"
            "IsGlobal" = $false
            "OptionSetType" = "Picklist"
            "Options" = $optionMetadata
        }
    }

    $body = $column | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri "$baseUrl/EntityDefinitions(LogicalName='$tableLogicalName')/Attributes" -Method Post -Headers $headers -Body $body
    Write-Host "  [OK] Picklist '$SchemaName' added" -ForegroundColor Green
}

# Asset Type choice
Add-PicklistIfNotExists -ColumnLogicalName "${publisherPrefix}_type" -SchemaName "${publisherPrefix}_type" -DisplayName "Type" -Options @(
    @{ Value = 100000000; Label = "Laptop" }
    @{ Value = 100000001; Label = "Monitor" }
    @{ Value = 100000002; Label = "Accessory" }
    @{ Value = 100000003; Label = "Tablet" }
)

# Asset Status choice
Add-PicklistIfNotExists -ColumnLogicalName "${publisherPrefix}_status" -SchemaName "${publisherPrefix}_status" -DisplayName "Status" -Options @(
    @{ Value = 100000000; Label = "Available" }
    @{ Value = 100000001; Label = "In use" }
    @{ Value = 100000002; Label = "Maintenance" }
    @{ Value = 100000003; Label = "Retired" }
)

# 4. Add Lookup to aaduser (Assigned To)
$lookupLogicalName = "${publisherPrefix}_assignedto"
if (Test-ColumnExists -TableLogicalName $tableLogicalName -ColumnLogicalName $lookupLogicalName) {
    Write-Host "  [SKIP] Lookup '${publisherPrefix}_assignedto' already exists" -ForegroundColor Yellow
} else {
    Write-Host "  [CREATE] Adding lookup '${publisherPrefix}_assignedto'..." -ForegroundColor Cyan

    $lookupColumn = @{
        "@odata.type" = "Microsoft.Dynamics.CRM.LookupAttributeMetadata"
        "SchemaName" = "${publisherPrefix}_assignedto"
        "AttributeType" = "Lookup"
        "DisplayName" = @{
            "@odata.type" = "Microsoft.Dynamics.CRM.Label"
            "LocalizedLabels" = @(@{ "@odata.type" = "Microsoft.Dynamics.CRM.LocalizedLabel"; "Label" = "Assigned To"; "LanguageCode" = 1033 })
        }
        "Targets" = @("aaduser")
    }

    $body = $lookupColumn | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri "$baseUrl/EntityDefinitions(LogicalName='$tableLogicalName')/Attributes" -Method Post -Headers $headers -Body $body
    Write-Host "  [OK] Lookup '${publisherPrefix}_assignedto' added" -ForegroundColor Green
}

# 5. Create unique index on Serial Number
Write-Host "`n[INFO] Table schema creation complete. Note: Unique index on Serial Number should be configured via Dataverse Maker Portal (Settings > Indexes & Keys) as the Web API does not support creating alternate keys directly via simple OData calls." -ForegroundColor Cyan

Write-Host "`n[COMPLETE] Asset table '$tableSchemaName' is ready." -ForegroundColor Green
