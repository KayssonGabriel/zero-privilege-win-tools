# UserSupportToolkit/ADPolicySync/Sync-ADUserPolicy.ps1

<#
.SYNOPSIS
    Sincroniza as políticas de grupo (GPO) e limpa o cache de tickets Kerberos do usuário atual.
#>

$ErrorActionPreference = "Stop"
$BaseDir = Split-Path -Path $PSScriptRoot -Parent
$LogDir = Join-Path -Path $BaseDir -ChildPath "Logs"

if (-not (Test-Path -Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }

$Timestamp = Get-Date -Format 'ddMMyyyy_HHmmss'
$LogFile = Join-Path -Path $LogDir -ChildPath "$($env:USERNAME)_ADSync_${Timestamp}.log"

Clear-Host
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "      FERRAMENTA DE SINCRONIZACAO DE ACESSOS           " -ForegroundColor White
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "`nO QUE ESTA FERRAMENTA FAZ:" -ForegroundColor Yellow
Write-Host "- Limpa a memoria de senhas e acessos da sua sessao atual."
Write-Host "- Forca o computador a buscar as permissoes mais recentes no servidor da empresa."
Write-Host "`nQUANDO DEVE USAR:" -ForegroundColor Yellow
Write-Host "- Quando voce perder o acesso a uma pasta de rede repentinamente."
Write-Host "- Quando a equipe de TI liberar um novo acesso e ele ainda nao estiver funcionando."
Write-Host "`n=======================================================" -ForegroundColor Cyan

$Confirmacao = Read-Host "`nDeseja continuar com a execucao? (S/N)"
if ($Confirmacao -notmatch "^[SsYy]$") {
    Write-Host "`nOperacao cancelada. Nenhuma alteracao foi feita no sistema." -ForegroundColor Green
    Start-Sleep -Seconds 3
    Exit
}

Start-Transcript -Path $LogFile -Append -NoClobber | Out-Null

try {
    Write-Host "`nIniciando sincronizacao de identidade (User Mode)..." -ForegroundColor Cyan

    Write-Host "[1/2] Limpando Tickets Kerberos em cache..." -ForegroundColor Yellow
    klist purge | Out-Null
    Write-Host "Acessos antigos removidos com sucesso." -ForegroundColor DarkGray

    Write-Host "`n[2/2] Atualizando Politicas de Grupo do Usuario..." -ForegroundColor Yellow
    gpupdate /target:user /force | Out-Null
    Write-Host "Novas permissoes aplicadas com sucesso." -ForegroundColor DarkGray

    Write-Host "`n[SUCESSO] Sincronizacao concluida! Tente acessar a pasta ou sistema novamente." -ForegroundColor Green
}
catch {
    Write-Error "Ocorreu uma falha durante a execucao: $_"
}
finally {
    Stop-Transcript | Out-Null
    Write-Host "`nAuditoria salva em: $LogFile" -ForegroundColor DarkGray
    Write-Host "Pressione qualquer tecla para encerrar..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}