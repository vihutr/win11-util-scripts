$files = Get-ChildItem -Filter *.mp4

Write-Output $MyInvocation.MyCommand.Path
Set-Content playlist.m3u "#EXTM3U"
foreach ($file in $files) {
    if ($file.Name -match '\.mp4$') {
        Add-Content playlist.m3u $file.Name -Encoding UTF8
        Write-Output "File found $($file.Name)" -Encoding UTF8
    }
}