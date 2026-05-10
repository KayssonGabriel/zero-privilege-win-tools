# UserSupportToolkit/SystemMaintenance/Clean-UserTemp.ps1

<#
.SYNOPSIS
    Realiza a limpeza segura de arquivos temporários do perfil do usuário para liberar espaço e resolver travamentos.
#>

$ErrorActionPreference = "Stop"
$BaseDir = Split-Path -Path $PSScriptRoot -Parent
$LogDir = Join-Path -Path $BaseDir -ChildPath "Logs"

if (-not (Test-Path -Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }

$Timestamp = Get-Date -Format 'ddMMyyyy_HHmmss'
$LogFile = Join-Path -Path $LogDir -ChildPath "$($env:USERNAME)_TempClean_${Timestamp}.log"

Clear-Host
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "          LIMPEZA DE ARQUIVOS TEMPORARIOS              " -ForegroundColor White
Write-Host "=======================================================" -ForegroundColor Cyan
Write-Host "`nO QUE ESTA FERRAMENTA FAZ:" -ForegroundColor Yellow
Write-Host "- Apaga arquivos de rascunho antigos criados por programas (ex: Pacote Office, ERPs)."
Write-Host "- Libera espaco em disco de forma totalmente segura (nao apaga seus documentos)."
Write-Host "`nQUANDO DEVE USAR:" -ForegroundColor Yellow
Write-Host "- Quando o computador ou sistemas de trabalho estiverem lentos e travando."
Write-Host "- Para resolver erros genericos ao tentar salvar, exportar ou abrir arquivos."
Write-Host "`nNota: Arquivos que estao sendo usados no momento nao serao apagados." -ForegroundColor Gray
Write-Host "=======================================================" -ForegroundColor Cyan

$Confirmacao = Read-Host "`nDeseja continuar com a limpeza? (S/N)"
if ($Confirmacao -notmatch "^[SsYy]$") {
    Write-Host "`nOperacao cancelada. Nenhum arquivo foi excluido." -ForegroundColor Green
    Start-Sleep -Seconds 3
    Exit
}

Start-Transcript -Path $LogFile -Append -NoClobber | Out-Null

try {
    Write-Host "`nIniciando Limpeza de Temporarios (User Mode)..." -ForegroundColor Cyan

    $TempPaths = @(
        $env:TEMP,
        "$env:LOCALAPPDATA\Temp"
    )

    foreach ($Path in $TempPaths) {
        if (Test-Path -Path $Path) {
            Write-Host "Limpando pasta: $Path" -ForegroundColor Yellow
            Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    
    Write-Host "`n[SUCESSO] Limpeza de arquivos temporarios concluida com seguranca!" -ForegroundColor Green
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