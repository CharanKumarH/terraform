# add variable to environment


# Get-Content ".env" | ForEach-Object {
#     if ($_ -match "^\s*([^#][^=]*)=(.*)$") {
#         $key = $matches[1].Trim()
#         $value = $matches[2].Trim()
#         [System.Environment]::SetEnvironmentVariable($key, $value, "Process")
#         # Use Set-Item to set $Env: variables dynamically
#         Set-Item -Path "Env:\$key" -Value $value
#     }
# }

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$envFile = Join-Path $scriptDir ".env"

Get-Content $envFile | ForEach-Object {
    if ($_ -match "^\s*([^#][^=]*)=(.*)$") {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()
        [System.Environment]::SetEnvironmentVariable($key, $value, "Process")
        Set-Item -Path "Env:\$key" -Value $value
    }
}
# use in poewrshell . ../load-env.ps1



# remove variable from environment


# Get-Content ".env" | ForEach-Object {
#     if ($_ -match "^\s*([^#][^=]*)=(.*)$") {
#         $key = $matches[1].Trim()
#         Remove-Item -Path "Env:\$key" -ErrorAction SilentlyContinue
#     }
# }
