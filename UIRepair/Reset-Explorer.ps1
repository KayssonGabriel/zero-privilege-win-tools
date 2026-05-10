# UserSupportToolkit/UIRepair/Reset-Explorer.ps1

<#
.SYNOPSIS
    Reinicia o processo do Windows Explorer (Interface Gráfica) para solucionar travamentos visuais.
#>

$ErrorActionPreference = "Stop"
$BaseDir = Split-Path -Path $PSScriptRoot -Parent
$LogDir = Join-Path -Path $BaseDir -ChildPath "Logs"

if (-not (Test-Path -Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }

$Timestamp = Get-Date -Format 'ddMMyyyy_HHmmss'
$LogFile = Join-Path -Path $LogDir -ChildPath "$($env:USERNAME)_UIReset_${Timestamp}.log"

Clear-Host
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "          REINICIAR INTERFACE DO WINDOWS               " -ForegroundColor White
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "`nO QUE ESTA FERRAMENTA FAZ:" -ForegroundColor Yellow
Write-Host "- Reinicia a Barra de Tarefas, o Menu Iniciar e o Explorador de Arquivos."
Write-Host "- Mantem seus programas e documentos abertos intactos (eles nao serao fechados)."
Write-Host "`nQUANDO DEVE USAR:" -ForegroundColor Yellow
Write-Host "- Quando a Barra de Tarefas travar, congelar ou desaparecer."
Write-Host "- Quando o Menu Iniciar nao responder aos cliques."
Write-Host "- Quando as janelas de pastas estiverem muito lentas ou com a tela branca."
Write-Host "`nNota: A sua tela vai piscar por alguns segundos durante o processo." -ForegroundColor Red
Write-Host "=======================================================" -ForegroundColor Cyan

$Confirmacao = Read-Host "`nDeseja continuar com a execucao? (S/N)"
if ($Confirmacao -notmatch "^[SsYy]$") {
    Write-Host "`nOperacao cancelada." -ForegroundColor Green
    Start-Sleep -Seconds 3
    Exit
}

Start-Transcript -Path $LogFile -Append -NoClobber | Out-Null

try {
    Write-Host "`nReiniciando a interface grafica..." -ForegroundColor Cyan

    Get-Process -Name explorer -ErrorAction SilentlyContinue | Stop-Process -Force

    Start-Sleep -Seconds 2
    $ExplorerAtivo = Get-Process -Name explorer -ErrorAction SilentlyContinue
    
    if (-not $ExplorerAtivo) {
        Write-Host "Iniciando o processo explorer manualmente..." -ForegroundColor Yellow
        Start-Process "explorer.exe"
    }

    Write-Host "`n[SUCESSO] Interface do Windows reiniciada e pronta para uso!" -ForegroundColor Green
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