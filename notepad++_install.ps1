# This script downloads the latest 64-bit version of Notepad++ available to the user's desktop.

# URL for the Notepad++ downloads page
$url = "https://notepad-plus-plus.org/downloads/"
$homeurl="https://notepad-plus-plus.org"

# Retrieve the HTML content from the URL
$html = Invoke-RestMethod -Uri $url

# Find the link based on the pattern "v" followed by a number and a period in href
$regexPattern = 'href="(.*?v\d+\..*?)"'

# Extract the first match based on the updated pattern
$match = [regex]::Match($html, $regexPattern)
$fullURL = $homeurl+$match

# Extract the captured value and remove "href="
if ($match.Success) {
    $downloadLink = $match.Groups[1].Value
    $matchValue = $downloadLink -replace 'href=', ''  # Remove "href="
    $fullURL = $homeurl + $matchValue  # Construct the full URL
} else {
    Write-Output "Download link not found."
}

# Get the HTML of the second (true) download page.
$html2 = Invoke-RestMethod -Uri $fullURL

$regexPattern2 = 'https:\/\/github\.com\/notepad-plus-plus\/notepad-plus-plus\/releases\/download\/([^\/]+\/[^\/]+\.x64\.exe)'

# Get the download link for the desired version of Notepad++ using regex.
$match2 = [regex]::Match($html2, $regexPattern2)

if ($match2.Success) {
    $downloadLink = $match2.Value
    
    # Download the file.
    Invoke-WebRequest -Uri $downloadLink -OutFile "$env:USERPROFILE\Desktop\notepadpp-x64.exe"
} else {
    Write-Host "No match found for the download link."
}