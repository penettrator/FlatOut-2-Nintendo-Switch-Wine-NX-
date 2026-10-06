# FlatOut 2 (GOG 1.2) — подготовка к Wine-NX / preparing for Wine-NX
# Автор / author: https://github.com/penettrator
#  1. патчит FlatOut2.exe / patches FlatOut2.exe
#  2. кладёт рядом d3dx9_30.dll из Windows / puts d3dx9_30.dll from Windows next to it
$ErrorActionPreference = 'Stop'
trap {
    Write-Host ''
    if ($_.Exception -is [System.UnauthorizedAccessException]) {
        Write-Host 'Нет доступа к папке игры. Нажмите на patch-flatout2.bat правой кнопкой мыши и'
        Write-Host 'выберите «Запуск от имени администратора».'
        Write-Host 'No write access to the game folder. Right-click patch-flatout2.bat and choose'
        Write-Host '"Run as administrator".'
    } else {
        Write-Host "Ошибка / Error: $($_.Exception.Message)"
    }
    exit 1
}
$exe = Join-Path $PSScriptRoot 'FlatOut2.exe'
$orig = '40078C35DE1366488D7C3DC761008CD4'
$done = '27E421EF3B04E51FED0D259A33279811'
$ok = $true

if (-not (Test-Path $exe)) {
    Write-Host 'FlatOut2.exe не найден рядом со скриптом / FlatOut2.exe not found next to the script'
    exit 1
}

# 1. FlatOut2.exe
$md5 = (Get-FileHash $exe -Algorithm MD5).Hash
if ($md5 -eq $done) {
    Write-Host 'FlatOut2.exe уже пропатчен / FlatOut2.exe is already patched'
} elseif ($md5 -ne $orig) {
    Write-Host 'Это не FlatOut2.exe из GOG 1.2, патч не применён / not the GOG 1.2 FlatOut2.exe, nothing changed'
    exit 1
} else {
    Copy-Item $exe "$exe.original" -Force
    $bytes = [IO.File]::ReadAllBytes($exe)
    $patches = @(
        @{ Offset = 0x230; Hex = '160E' }
        @{ Offset = 0x514D5; Hex = 'E8060920009090' }
        @{ Offset = 0x15A823; Hex = 'EB' }
        @{ Offset = 0x1614C0; Hex = '33C0C2' }
        @{ Offset = 0x1614C4; Hex = '00' }
        @{ Offset = 0x251DE0; Hex = '8B4424182D' }
        @{ Offset = 0x251DE6; Hex = '01' }
        @{ Offset = 0x251DE9; Hex = 'A9FAFFFFFF751EE8' }
        @{ Offset = 0x251DF5; Hex = '5983B9438928' }
        @{ Offset = 0x251DFD; Hex = '750FFF742420FF7424206A' }
        @{ Offset = 0x251E09; Hex = 'E8C28CF0FF8D54241452FFD5C3' }
    )
    foreach ($p in $patches) {
        for ($k = 0; $k -lt $p.Hex.Length / 2; $k++) {
            $bytes[$p.Offset + $k] = [Convert]::ToByte($p.Hex.Substring($k * 2, 2), 16)
        }
    }
    [IO.File]::WriteAllBytes($exe, $bytes)
    if ((Get-FileHash $exe -Algorithm MD5).Hash -ne $done) {
        Copy-Item "$exe.original" $exe -Force
        Write-Host 'Ошибка патча, exe восстановлен / patch error, exe restored'
        exit 1
    }
    Write-Host 'FlatOut2.exe пропатчен, оригинал: FlatOut2.exe.original / FlatOut2.exe patched, original: FlatOut2.exe.original'
}

# 2. d3dx9_30.dll
$dll = Join-Path $PSScriptRoot 'd3dx9_30.dll'
$sys = Join-Path $env:WINDIR 'SysWOW64\d3dx9_30.dll'
if (-not (Test-Path $sys)) { $sys = Join-Path $env:WINDIR 'System32\d3dx9_30.dll' }
if (Test-Path $dll) {
    Write-Host 'd3dx9_30.dll уже на месте / d3dx9_30.dll is already there'
} elseif (Test-Path $sys) {
    Copy-Item $sys $dll
    Write-Host 'd3dx9_30.dll скопирован из Windows / d3dx9_30.dll copied from Windows'
} else {
    $ok = $false
    Write-Host ''
    Write-Host 'd3dx9_30.dll не найден в Windows. Установите DirectX End-User Runtime с сайта Microsoft'
    Write-Host 'и запустите этот файл ещё раз:'
    Write-Host 'd3dx9_30.dll not found in Windows. Install the DirectX End-User Runtime from Microsoft'
    Write-Host 'and run this file again:'
    Write-Host '  https://www.microsoft.com/en-us/download/details.aspx?id=8109'
}

Write-Host ''
if ($ok) { Write-Host 'Готово / Done' } else { exit 1 }
