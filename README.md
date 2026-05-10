# Ferramentas de autoatendimento para Windows

Conjunto de scripts em PowerShell para tarefas comuns de suporte ao usuário. Cada módulo apresenta a ação, solicita confirmação no terminal e tenta registrar a execução em um arquivo de log.

| Módulo | Ação | Quando usar |
| --- | --- | --- |
| [UIRepair](UIRepair/) | Reinicia o Windows Explorer, responsável pela área de trabalho e pela barra de tarefas | Travamento do Explorador ou da interface do Windows |
| [SystemMaintenance](SystemMaintenance/) | Tenta remover arquivos temporários nas pastas temporárias da conta | Limpeza de temporários ou investigação de falhas em aplicativos |
| [NetworkTools](NetworkTools/) | Solicita a limpeza do cache do resolvedor DNS do Windows | Investigação de problemas de resolução de nomes |
| [ADPolicySync](ADPolicySync/) | Limpa os tíquetes Kerberos da sessão e solicita atualização das políticas de usuário | Diagnóstico de acesso em um ambiente de domínio |

## Como usar

Em um computador Windows, extraia o projeto para uma pasta gravável. Abra o módulo indicado pela equipe de TI e leia a confirmação antes de continuar. O script principal de cada módulo é o arquivo `.ps1` na pasta correspondente. Execute-o no Windows PowerShell conforme as políticas da máquina.

A execução depende das permissões da conta e das políticas do ambiente. Arquivos em uso e operações restritas podem permanecer pendentes. O reinício do Explorer pode fechar suas janelas. O módulo de políticas de usuário depende da conectividade com o domínio.

## Logs

Após a confirmação, os scripts iniciam uma transcrição na pasta `Logs/` da raiz. O nome segue o formato `<usuário>_<módulo>_<data-hora>.log`. Use o arquivo correspondente ao chamado para conferir a operação executada.
