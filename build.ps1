$srcDir = "$PSScriptRoot/src"
$outputFile = "$PSScriptRoot/NovaLib.lua"

Write-Host "Bundling NovaLib modular files..." -ForegroundColor Cyan

# Files in dependency order
$files = @(
    "init.lua",
    "Themes.lua",
    "Icons.lua",
    "Utility.lua",
    "Intro.lua",
    "Notifications.lua",
    "ElementsBase.lua",
    "ElementsInput.lua",
    "ElementsSelect.lua",
    "Window.lua"
)

$bundleContent = "--[[`n`tNovaLib UI Library`n`tBUNDLED PRODUCTION BUILD`n`tGenerated at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n]]`n"

foreach ($file in $files) {
    $filePath = "$srcDir/$file"
    if (Test-Path $filePath) {
        $content = Get-Content -Raw -Path $filePath -Encoding utf8
        $bundleContent += "`n--// File: src/$file //--`n" + $content + "`n"
    } else {
        Write-Error "Required file not found: $filePath"
        exit 1
    }
}

# Append return statement
$bundleContent += "`nreturn NovaLib`n"

# Write to output file with UTF-8 encoding (without BOM)
[System.IO.File]::WriteAllText($outputFile, $bundleContent, (New-Object System.Text.UTF8Encoding($false)))

$lineCount = (Get-Content $outputFile).Count
Write-Host "Successfully bundled $($files.Count) files into $outputFile ($lineCount lines)!" -ForegroundColor Green
