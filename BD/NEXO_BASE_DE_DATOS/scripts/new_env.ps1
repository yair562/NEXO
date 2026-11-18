<#
.SYNOPSIS
    Crea .env con contraseñas aleatorias para PostgreSQL, PostgREST y el backend Flask.

.DESCRIPTION
    Nunca sobrescribe archivos existentes. No muestra ninguna contraseña.
    Códigos de salida: 0 creado o ya existía · 1 error.
#>
[CmdletBinding()]
param()

. "$PSScriptRoot\_comun.ps1"
$ErrorActionPreference = 'Stop'

function New-Secreto([int]$Largo) {
    $letras = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789'
    $bytes = New-Object byte[] $Largo
    $generador = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $generador.GetBytes($bytes)
    $generador.Dispose()
    return -join ($bytes | ForEach-Object { $letras[$_ % $letras.Length] })
}

$archivoEnv = Join-Path $script:RaizRepo '.env'
if (Test-Path -LiteralPath $archivoEnv) {
    Write-Ok '.env ya existe; no se modificó.'
} else {
    $plantilla = [IO.File]::ReadAllText((Join-Path $script:RaizRepo '.env.example'), $script:Utf8SinBom)
    $secretos = @{
        'POSTGRES_SUPERUSER_PASSWORD' = New-Secreto 32
        'NEXO_MIGRATOR_PASSWORD' = New-Secreto 32
        'NEXO_APP_PASSWORD' = New-Secreto 32
        'PGRST_AUTHENTICATOR_PASSWORD' = New-Secreto 32
        'PGRST_JWT_SECRET' = New-Secreto 48
        'NEXO_FLASK_SECRET_KEY' = New-Secreto 48
    }
    foreach ($clave in $secretos.Keys) {
        $plantilla = [regex]::Replace($plantilla, "(?m)^$clave=.*$", "$clave=$($secretos[$clave])")
    }
    [IO.File]::WriteAllText($archivoEnv, $plantilla, $script:Utf8SinBom)
    Write-Ok '.env creado con contraseñas aleatorias (no se muestran).'
}
exit 0
