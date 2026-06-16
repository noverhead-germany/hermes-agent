param(
    [Parameter(Mandatory = $true)]
    [string]$SetupPath,

    [string]$Version,

    [string]$Channel,

    [string]$OutputPath
)

$ErrorActionPreference = "Stop"

$resolvedSetupPath = (Resolve-Path -LiteralPath $SetupPath).Path

if (-not $OutputPath) {
    $OutputPath = Join-Path -Path (Split-Path -Parent $resolvedSetupPath) -ChildPath "setup-metadata.json"
}

if (-not $Version) {
    $describedVersion = (git describe --tags --always --dirty 2>$null)
    if ([string]::IsNullOrWhiteSpace($describedVersion)) {
        $describedVersion = (git rev-parse --short=9 HEAD).Trim()
    }
    $Version = $describedVersion.Trim()
}

$commit = (git rev-parse --short=9 HEAD).Trim()
$builtAt = [DateTimeOffset]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")
$fileHash = Get-FileHash -LiteralPath $resolvedSetupPath -Algorithm SHA256

$metadata = [ordered]@{
    version = $Version
    commit = $commit
    builtAt = $builtAt
    fileName = [System.IO.Path]::GetFileName($resolvedSetupPath)
    sha256 = $fileHash.Hash.ToLowerInvariant()
}

if (-not [string]::IsNullOrWhiteSpace($Channel)) {
    $metadata.channel = $Channel
}

$metadata | ConvertTo-Json | Set-Content -LiteralPath $OutputPath -Encoding utf8

Write-Host "Wrote setup metadata to $OutputPath"
