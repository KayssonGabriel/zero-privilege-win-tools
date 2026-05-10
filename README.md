<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=28&duration=3000&pause=1000&color=28A745&center=true&vCenter=true&width=700&lines=%F0%9F%9B%A0%EF%B8%8F+User+Support+Toolkit;Autoatendimento+para+Usu%C3%A1rios;Sem+Privil%C3%A9gios+de+Administrador" alt="User Support Toolkit" />

<br/>

[![Windows](https://img.shields.io/badge/Windows-0078D7?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://microsoft.com/powershell)
![Contexto do usuário](https://img.shields.io/badge/Contexto_do_Usu%C3%A1rio-28A745?style=for-the-badge&logo=shield&logoColor=white)

<br/>

> **Kit de autoatendimento para usuários Windows.** <br/> Soluções modulares e seguras para resolver problemas cotidianos do Windows sem precisar acionar o Suporte Técnico de TI (N1).

<br/>

[🚀 Como usar](#como-usar) · [📂 Estrutura](#arquitetura) · [🛠️ Módulos de reparo](#modulos-de-reparo) · [🔒 Logs e auditoria](#logs-e-auditoria)

</div>

---

## 📖 Sobre o Projeto

O **User Support Toolkit** reúne scripts PowerShell para tarefas comuns de suporte. Cada módulo explica a ação, solicita confirmação e registra a execução em log.

Os scripts usam o contexto da conta que os executa e seguem o princípio do menor privilégio. As permissões e políticas da máquina determinam quais operações podem ser concluídas.

<a name="arquitetura"></a>

## 📐 Arquitetura

Cada pasta contém um módulo independente e seu atalho em Batch.

    /
    ├── Logs/                    (Gerada automaticamente: salva o histórico de uso)
    ├── ADPolicySync/            (Atualização de acessos de rede e limpeza Kerberos)
    ├── NetworkTools/            (Limpeza do cache DNS do Windows)
    ├── SystemMaintenance/       (Limpeza de arquivos temporários do usuário)
    └── UIRepair/                (Reinicialização gráfica do Windows Explorer)

---

<a name="como-usar"></a>

## 🚀 Como usar

### ⚙️ Passo 1: Preparar a pasta

Em um computador Windows, extraia o projeto para uma pasta em que a conta possa gravar a pasta `Logs/`. A equipe de TI pode criar atalhos para os módulos que forem adequados ao ambiente.

### 🛠️ Passo 2: Executar o módulo

1. Abra a pasta do módulo indicado na tabela.
2. Execute o atalho `.bat` ou o script `.ps1` no Windows PowerShell, conforme as políticas da máquina.
3. Leia a ação apresentada e confirme para prosseguir. Confira a mensagem final e o log caso alguma etapa fique pendente.

<a name="modulos-de-reparo"></a>

## 🛠️ Módulos de reparo

| Módulo | O que faz | Quando usar | Impacto |
| --- | --- | --- | --- |
| [**UIRepair**](UIRepair/) | Reinicia o Windows Explorer | A barra de tarefas ou a área de trabalho travou | Pode fechar janelas do Explorador |
| [**SystemMaintenance**](SystemMaintenance/) | Limpa arquivos temporários da conta | Diagnóstico de lentidão ou falhas de aplicativos | Pode deixar arquivos em uso pendentes |
| [**NetworkTools**](NetworkTools/) | Solicita a limpeza do cache do resolvedor DNS | Um endereço deixou de resolver após uma mudança | Depende das permissões locais |
| [**ADPolicySync**](ADPolicySync/) | Limpa os tíquetes Kerberos da sessão e atualiza políticas de usuário | Diagnóstico de acesso a recursos de domínio | Depende da conexão com o domínio |

<a name="logs-e-auditoria"></a>

## 🔒 Logs e auditoria

Após a confirmação, os módulos iniciam uma transcrição na pasta `Logs/` da raiz do kit. O arquivo segue o formato `<usuário>_<módulo>_<data-hora>.log`.

Se a operação não resolver o chamado, informe ao suporte o módulo usado e envie o log correspondente pelo canal de atendimento da equipe.

<div align="center">

<br/>

**Reduzindo tickets de suporte através da autonomia do usuário.**

</div>
