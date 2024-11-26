# Gets list of matching videos and subs
$videos = Get-ChildItem -Filter *.mkv
$subs = Get-ChildItem -Filter *.ass

$v_choice = 0
$s_choice = 0

if ($videos.Count -gt 1) {
    $videos | ForEach-Object { Write-Host "$($videos.IndexOf($_)) - $($_.Name)" }
    $v_choice = Read-Host "Enter the index of the video file"
}
if ($subs.Count -gt 1) {
    $subs | ForEach-Object { Write-Host "$($subs.IndexOf($_)) - $($_.Name)" }
    $s_choice = Read-Host "Enter the index of the sub file"
}
$video = $videos[$v_choice].Name
$sub = $subs[$s_choice].Name

Write-Host "Video File: $($video)"
Write-Host "Sub File:   $($sub)"

# Run ffprobe and get information about subtitle streams
$ffprobeOutput = ffprobe -v quiet -print_format json -show_streams $video

# Filter out the subtitle streams
$subtitleStreams = $ffprobeOutput | Select-String -Pattern '"codec_type": "subtitle"'

# Get the number of subtitle tracks
$subtitleTrackCount = $subtitleStreams.Count
Write-Host "Number of subtitle tracks: $($subtitleTrackCount)"
$subtitleTrackCount += 1

$cmd = 'mpv --sub-files="' + $sub + '" --sid=' + $subtitleTrackCount + ' --secondary-sid=1 "' + $video + '"'
Write-Host "Running command: $($cmd)"
Invoke-Expression $cmd
