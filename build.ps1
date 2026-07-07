$srcDir = "$PSScriptRoot/src"
$outputFile = "$PSScriptRoot/NovaLib.lua"

Write-Host "Bundling NovaLib modular files..." -ForegroundColor Cyan

# Files in dependency order (subdirectory paths relative to src/)
$files = @(
    "init.lua",
    "Themes/init.lua",
    "Themes/Dark.lua",
    "Themes/Darker.lua",
    "Themes/Light.lua",
    "Themes/Amethyst.lua",
    "Themes/Aqua.lua",
    "Themes/Rose.lua",
    "Icons.lua",
    "FontMaps.lua",
    "Utility.lua",
    "Managers/SaveManager.lua",
    "Managers/InterfaceManager.lua",
    "Intro.lua",
    "Components/Element.lua",
    "Components/Notification.lua",
    "Components/Section.lua",
    "Elements/init.lua",
    "Elements/Button.lua",
    "Elements/Paragraph.lua",
    "Elements/Toggle.lua",
    "Elements/Slider.lua",
    "Elements/Dropdown.lua",
    "Elements/Input.lua",
    "Elements/Keybind.lua",
    "Elements/Colorpicker.lua",
    "Components/Tab.lua",
    "Components/Window.lua"
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
