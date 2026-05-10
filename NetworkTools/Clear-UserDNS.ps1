# UserSupportToolkit/NetworkTools/Clear-UserDNS.ps1

<#
.SYNOPSIS
    Limpa o cache de resolução DNS da máquina para o usuário atual, sem exigir elevação de privilégios.
#>

$ErrorActionPreference = "Stop"
$BaseDir = Split-Path -Path $PSScriptRoot -Parent
$LogDir = Join-Path -Path $BaseDir -ChildPath "Logs"

if (-not (Test-Path -Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }

$Timestamp = Get-Date -Format 'ddMMyyyy_HHmmss'
$LogFile = Join-Path -Path $LogDir -ChildPath "$($env:USERNAME)_DNSClear_${Timestamp}.log"

Clear-Host
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "             FERRAMENTA DE REPARO DE REDE              " -ForegroundColor White
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "`nO QUE ESTA FERRAMENTA FAZ:" -ForegroundColor Yellow
Write-Host "- Apaga o historico de enderecos de internet salvos no seu computador."
Write-Host "- Obriga o sistema a buscar a rota mais nova e correta para os sites."
Write-Host "`nQUANDO DEVE USAR:" -ForegroundColor Yellow
Write-Host "- Quando um site ou sistema interno especifico nao carregar ou apresentar erro."
Write-Host "- Quando a equipe de suporte solicitar apos a atualizacao de um sistema web."
Write-Host "`n=======================================================" -ForegroundColor Cyan

$Confirmacao = Read-Host "`nDeseja continuar com a execucao? (S/N)"
if ($Confirmacao -notmatch "^[SsYy]$") {
    Write-Host "`nOperacao cancelada. Nenhuma alteracao foi feita na rede." -ForegroundColor Green
    Start-Sleep -Seconds 3
    Exit
}

Start-Transcript -Path $LogFile -Append -NoClobber | Out-Null

try {
    Write-Host "`nIniciando Manutencao de Rede (User Mode)..." -ForegroundColor Cyan

    Write-Host "[1/1] Limpando Cache DNS do Windows..." -ForegroundColor Yellow
    ipconfig /flushdns | Out-Null
    
    Write-Host "`n[SUCESSO] Cache de rede limpo! Por favor, feche e abra o seu navegador novamente." -ForegroundColor Green
}
catch {
    Write-Error "Ocorreu uma falha: $_"
}
finally {
    Stop-Transcript | Out-Null
    Write-Host "`nAuditoria salva em: $LogFile" -ForegroundColor DarkGray
    Write-Host "Pressione qualquer tecla para encerrar..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}