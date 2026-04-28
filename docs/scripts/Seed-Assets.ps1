# Seed-Assets.ps1
# Seeds 20 asset records into the crc13_asset Dataverse table

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

# Fetch some aadusers for assignment
Write-Host "Fetching AAD users..." -ForegroundColor Cyan
$users = Invoke-RestMethod -Uri "$baseUrl/aadusers?`$select=aaduserid,displayname&`$top=10" -Headers $headers
$userIds = $users.value | Select-Object -ExpandProperty aaduserid
Write-Host "Found $($userIds.Count) users" -ForegroundColor Green

$typeMap = @{
    "Laptop" = 100000000
    "Monitor" = 100000001
    "Accessory" = 100000002
    "Tablet" = 100000003
}

$statusMap = @{
    "Available" = 100000000
    "In use" = 100000001
    "Maintenance" = 100000002
    "Retired" = 100000003
}

$assets = @(
    @{ name = 'MacBook Pro 14" M4'; serial = 'C02ZW1YJMD6R'; type = 'Laptop'; status = 'In use'; location = 'London HQ · Floor 3'; purchased = '2024-03-15'; warranty = '2027-03-15'; value = 2499; supplier = 'Apple Business'; po = 'PO-2024-0012'; notes = ''; assignIndex = 0 }
    @{ name = 'Dell UltraSharp U2723QE'; serial = 'CN0JH3XG8LG001'; type = 'Monitor'; status = 'In use'; location = 'London HQ · Floor 3'; purchased = '2023-09-10'; warranty = '2026-09-10'; value = 649; supplier = 'Dell Direct'; po = 'PO-2023-0089'; notes = ''; assignIndex = 1 }
    @{ name = 'Logitech MX Keys'; serial = 'MXK-884721-A'; type = 'Accessory'; status = 'Available'; location = 'London HQ · Store room'; purchased = '2024-01-20'; warranty = '2026-01-20'; value = 109; supplier = 'Amazon Business'; po = 'PO-2024-0021'; notes = ''; assignIndex = $null }
    @{ name = 'iPad Pro 12.9" M2'; serial = 'ABC123456789'; type = 'Tablet'; status = 'In use'; location = 'London HQ · Floor 2'; purchased = '2023-06-05'; warranty = '2025-06-05'; value = 1299; supplier = 'Apple Business'; po = 'PO-2023-0045'; notes = 'Used for client presentations'; assignIndex = 2 }
    @{ name = 'MacBook Air 13" M3'; serial = 'C02XY2ZKMD7T'; type = 'Laptop'; status = 'Maintenance'; location = 'London HQ · IT Bench'; purchased = '2023-11-12'; warranty = '2026-11-12'; value = 1599; supplier = 'Apple Business'; po = 'PO-2023-0067'; notes = 'Keyboard fault — sent to supplier 2026-04-25'; assignIndex = 3 }
    @{ name = 'Dell Latitude 5540'; serial = '5CG1234ABCD'; type = 'Laptop'; status = 'Available'; location = 'London HQ · Store room'; purchased = '2024-08-01'; warranty = '2027-08-01'; value = 1399; supplier = 'Dell Direct'; po = 'PO-2024-0056'; notes = ''; assignIndex = $null }
    @{ name = 'Sony WH-1000XM5'; serial = 'SNY-998877-A'; type = 'Accessory'; status = 'In use'; location = 'Remote'; purchased = '2024-02-14'; warranty = '2026-02-14'; value = 349; supplier = 'Amazon Business'; po = 'PO-2024-0030'; notes = ''; assignIndex = 4 }
    @{ name = 'LG 27" UltraFine 5K'; serial = 'LG27UK850-W901'; type = 'Monitor'; status = 'Retired'; location = 'London HQ · Disposals'; purchased = '2020-04-20'; warranty = '2023-04-20'; value = 1299; supplier = 'LG Business'; po = 'PO-2020-0015'; notes = 'Screen discolouration; replaced under warranty then retired'; assignIndex = $null }
    @{ name = 'Microsoft Surface Pro 9'; serial = 'MS-SFP9-77421'; type = 'Tablet'; status = 'In use'; location = 'Manchester Office'; purchased = '2024-05-18'; warranty = '2027-05-18'; value = 1599; supplier = 'Microsoft Store'; po = 'PO-2024-0041'; notes = ''; assignIndex = 5 }
    @{ name = 'Lenovo ThinkPad X1 Carbon'; serial = 'PF1A2B3C4D5E'; type = 'Laptop'; status = 'Available'; location = 'London HQ · Store room'; purchased = '2024-10-03'; warranty = '2027-10-03'; value = 1899; supplier = 'Lenovo Direct'; po = 'PO-2024-0078'; notes = ''; assignIndex = $null }
    @{ name = 'Anker 737 Power Bank'; serial = 'ANK-737-1122'; type = 'Accessory'; status = 'In use'; location = 'Remote'; purchased = '2024-06-12'; warranty = '2026-06-12'; value = 149; supplier = 'Amazon Business'; po = 'PO-2024-0048'; notes = ''; assignIndex = 6 }
    @{ name = 'Samsung Galaxy Tab S9'; serial = 'SM-X910NZAAEUA'; type = 'Tablet'; status = 'Maintenance'; location = 'London HQ · IT Bench'; purchased = '2023-12-01'; warranty = '2025-12-01'; value = 899; supplier = 'Samsung Business'; po = 'PO-2023-0091'; notes = 'Battery swelling; awaiting replacement part'; assignIndex = $null }
    @{ name = 'HP EliteBook 840 G10'; serial = '5CD2345EFGH'; type = 'Laptop'; status = 'In use'; location = 'London HQ · Floor 2'; purchased = '2024-02-28'; warranty = '2027-02-28'; value = 1699; supplier = 'HP Direct'; po = 'PO-2024-0033'; notes = ''; assignIndex = 7 }
    @{ name = 'Dell P2723QE Monitor'; serial = 'CN0KH4YH9MH002'; type = 'Monitor'; status = 'Available'; location = 'London HQ · Store room'; purchased = '2024-07-15'; warranty = '2027-07-15'; value = 499; supplier = 'Dell Direct'; po = 'PO-2024-0062'; notes = ''; assignIndex = $null }
    @{ name = 'Apple Magic Mouse'; serial = 'MM-224466-B'; type = 'Accessory'; status = 'In use'; location = 'London HQ · Floor 3'; purchased = '2024-04-10'; warranty = '2026-04-10'; value = 79; supplier = 'Apple Business'; po = 'PO-2024-0029'; notes = ''; assignIndex = 0 }
    @{ name = 'iPad Air 11" M2'; serial = 'DEF987654321'; type = 'Tablet'; status = 'Available'; location = 'London HQ · Store room'; purchased = '2024-09-20'; warranty = '2027-09-20'; value = 799; supplier = 'Apple Business'; po = 'PO-2024-0072'; notes = ''; assignIndex = $null }
    @{ name = 'Asus ZenBook 14'; serial = 'NX1234ABCD'; type = 'Laptop'; status = 'Retired'; location = 'London HQ · Disposals'; purchased = '2019-05-12'; warranty = '2022-05-12'; value = 1199; supplier = 'Asus Business'; po = 'PO-2019-0008'; notes = 'Motherboard failure; uneconomical to repair'; assignIndex = $null }
    @{ name = 'Logitech MX Master 3S'; serial = 'MXM-556677-C'; type = 'Accessory'; status = 'In use'; location = 'Manchester Office'; purchased = '2024-03-08'; warranty = '2026-03-08'; value = 99; supplier = 'Amazon Business'; po = 'PO-2024-0018'; notes = ''; assignIndex = 1 }
    @{ name = 'BenQ PD3220U 32"'; serial = 'BNQ-889900-D'; type = 'Monitor'; status = 'In use'; location = 'London HQ · Floor 3'; purchased = '2024-01-15'; warranty = '2027-01-15'; value = 899; supplier = 'BenQ Direct'; po = 'PO-2024-0015'; notes = 'Design team primary display'; assignIndex = 2 }
    @{ name = 'Microsoft Surface Laptop 6'; serial = 'MS-SL6-99551'; type = 'Laptop'; status = 'Maintenance'; location = 'London HQ · IT Bench'; purchased = '2024-06-01'; warranty = '2027-06-01'; value = 1999; supplier = 'Microsoft Store'; po = 'PO-2024-0051'; notes = 'Trackpad unresponsive; replacement part ordered'; assignIndex = $null }
)

Write-Host "`nSeeding $($assets.Count) assets..." -ForegroundColor Cyan

foreach ($asset in $assets) {
    $body = @{
        crc13_name = $asset.name
        crc13_serialnumber = $asset.serial
        crc13_type = $typeMap[$asset.type]
        crc13_status = $statusMap[$asset.status]
        crc13_location = $asset.location
        crc13_purchased = $asset.purchased
        crc13_warrantyuntil = $asset.warranty
        crc13_value = $asset.value
        crc13_supplier = $asset.supplier
        crc13_purchaseorder = $asset.po
        crc13_notes = $asset.notes
    }

    if ($null -ne $asset.assignIndex -and $userIds.Count -gt $asset.assignIndex) {
        $userId = $userIds[$asset.assignIndex]
        $body["crc13_assignedto@odata.bind"] = "/aadusers($userId)"
    }

    $json = $body | ConvertTo-Json -Depth 5
    try {
        Invoke-RestMethod -Uri "$baseUrl/crc13_assets" -Method Post -Headers $headers -Body $json
        Write-Host "  [OK] Created: $($asset.name)" -ForegroundColor Green
    } catch {
        $err = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
        Write-Host "  [FAIL] $($asset.name): $($err.error.message)" -ForegroundColor Red
    }
}

Write-Host "`nSeed complete." -ForegroundColor Green
