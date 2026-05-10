<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=28&duration=3000&pause=1000&color=28A745&center=true&vCenter=true&width=700&lines=%F0%9F%9B%A0%EF%B8%8F+User+Support+Toolkit;Autoatendimento+para+Usu%C3%A1rios;Sem+Privil%C3%A9gios+de+Administrador" alt="User Support Toolkit" />

<br/>

[![Windows](https://img.shields.io/badge/Windows-0078D7?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://microsoft.com/powershell)
[![No Admin Required](https://img.shields.io/badge/N%C3%A3o_Requer_Administrador-28A745?style=for-the-badge&logo=shield&logoColor=white)]()

<br/>

> **Portal de Autoatendimento para Usuários Finais.** <br/> Soluções modulares e seguras para resolver problemas cotidianos do Windows sem precisar acionar o Suporte Técnico de TI (N1).

<br/>

[🚀 Como Usar](#-como-usar) · [📂 Estrutura](#-arquitetura) · [🌐 Módulos de Reparo](#%EF%B8%8F-resumo-de-módulos-de-reparo) · [🛡️ Segurança](#-segurança-e-auditoria)

</div>

---

## 📖 Sobre o Projeto

O **User Support Toolkit** é um conjunto de ferramentas projetado para empoderar o usuário final. Diferente de scripts tradicionais de Sysadmin, este projeto foi arquitetado seguindo o **Princípio do Menor Privilégio (User Space)**.

Ele resolve chamados básicos de TI (como lentidão, travamentos de interface e problemas de acesso) utilizando um padrão de *Wrapper* em Batch (`.bat`) que contorna políticas de execução do PowerShell localmente, garantindo que o usuário **nunca** veja uma tela pedindo senha de Administrador (UAC).

---

## 📐 Arquitetura

A estrutura foi desenhada para isolamento de contexto e segurança corporativa:

    /
    ├── Logs/                    (Gerada automaticamente: salva o histórico de uso)
    ├── ADPolicySync/            (Atualização de acessos de rede e limpeza Kerberos)
    ├── NetworkTools/            (Limpeza segura de Cache DNS da máquina)
    ├── SystemMaintenance/       (Limpeza de arquivos temporários do usuário)
    └── UIRepair/                (Reinicialização gráfica do Windows Explorer)

---

## 🚀 Como Usar

### ⚙️ Passo 1: Implantação
1. A equipe de TI copia a pasta do Toolkit para a Área de Trabalho ou Documentos do usuário.
2. *(Opcional)* Atalhos podem ser criados na Área de Trabalho apontando para os arquivos `.bat`.

### 🛠️ Passo 2: Execução pelo Usuário
1. O usuário clica no módulo desejado (ex: `Run-TempClean.bat`).
2. Uma tela explicativa interativa (UX) aparecerá perguntando se ele deseja continuar.
3. O script é executado em segundo plano de forma silenciosa e segura.
4. **Nenhuma senha de administrador será solicitada.**

---

## 🛠️ Resumo de Módulos de Reparo

| Módulo | O que faz? | Quando o usuário deve usar? | Impacto |
| :--- | :--- | :--- | :--- |
| **UIRepair** | Reinicia o `explorer.exe` | Barra de tarefas sumiu ou Menu Iniciar travou. | **Seguro** (Não fecha programas) |
| **SystemMaintenance** | Limpa `%TEMP%` | Computador lento ou ERP/Office apresentando erros. | **Seguro** (Não exclui documentos) |
| **NetworkTools** | Limpa Cache DNS | Site interno parou de carregar após atualização. | **Seguro** (Apenas nível usuário) |
| **ADPolicySync** | `gpupdate` e `klist purge` | Perdeu acesso a uma pasta de rede ou portal. | **Seguro** |

---

## 🔒 Segurança e Auditoria

Mesmo sendo uma ferramenta de usuário, o toolkit mantém o controle para a equipe de TI. Toda execução gera um arquivo de log na pasta `/Logs`.

**Padrão do Log:** `[Usuario]_[Modulo]_[Data_Hora].log`

Se o toolkit não resolver o problema, o usuário é instruído a abrir um chamado normalmente, e o analista de Suporte de Nível 1 poderá verificar o log gerado para entender o que já foi tentado, otimizando o *Troubleshooting*.

<div align="center">

<br/>

**Reduzindo tickets de suporte através da autonomia do usuário.**

</div>
