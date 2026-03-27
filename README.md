# CAN_BTU - Bit Timing Unit

Este projeto implementa uma **Bit Timing Unit (BTU)** para protocolo CAN (Controller Area Network), desenvolvida em Verilog/SystemVerilog. Inclui simulação RTL, síntese lógica (Genus), ambiente de verificação UVM, cobertura funcional e scripts de automação.

## Estrutura do Projeto

A organização dos diretórios é a seguinte:
CAN_BTU/
├── constraints/ # Arquivos de restrições para síntese (SDC, clock, etc.)
├── cov_reports/ # Relatórios de cobertura funcional gerados pelas simulações
├── cov_work/ # Dados de trabalho da ferramenta de cobertura (ex: Incisive/Xcelium)
├── fv/ # Arquivos de verificação formal (formal verification)
│ └── can_btu_top/ # Pasta específica para o topo da verificação formal
├── Genus Log/ # Logs e relatórios gerados pelo Cadence Genus durante a síntese
├── img/ # Imagens utilizadas no projeto (diagramas, etc.)
├── other code/ # Códigos adicionais ou experimentais
├── Relatórios/ # Relatórios finais do projeto em formato PDF
├── rpt/ # Relatórios diversos gerados por ferramentas (simulação, síntese)
├── rtl/ # Código fonte RTL (Verilog/SystemVerilog) da BTU
├── script/ # Scripts de automação (para simulação, síntese, etc.)
├── uvm/ # Ambiente de verificação UVM (testbenches, sequências, etc.)
├── waves.shm/ # Arquivos de formas de onda (Shm) para visualização
├── xcelium.d/ # Diretório de trabalho do simulador Xcelium
├── .simvision/ # Configurações do SimVision (visualizador de波形)
├── Make.mk # Makefile com regras para compilar e simular
└── *.log, *.key, etc. # Arquivos de log e configuração do simulador

text

## Requisitos de Software

Para rodar as simulações e síntese, você precisará das seguintes ferramentas (típicas de um ambiente de design digital):

- **Simulador**: Cadence Xcelium (ou Incisive)
- **Síntese**: Cadence Genus
- **Visualização de Formas de Onda**: SimVision
- **Ferramentas de Cobertura**: imc (Integrated Metric Center)

## Como Rodar as Simulações

O projeto utiliza um Makefile (`Make.mk`) para simplificar os comandos de simulação.

### 1. Configurar o Ambiente

Certifique-se de que as ferramentas Cadence (Xcelium, Genus) estão configuradas corretamente no seu ambiente (source dos arquivos de setup).

### 2. Rodar Simulação RTL

Para executar a simulação do código RTL com o testbench UVM, utilize o comando:

```bash
make -f Make.mk run_sim
Este comando deve compilar os arquivos RTL, o ambiente UVM e executar a simulação.

3. Rodar Simulação Gate-Level (Pós-Síntese)
Após a síntese, é comum simular a netlist gate-level para verificação de timing:

bash
make -f Make.mk run_gate_sim
4. Gerar e Visualizar Formas de Onda
As formas de onda são geradas durante a simulação e armazenadas no diretório waves.shm/. Para visualizá-las com SimVision:

bash
simvision waves.shm/ &
Ou, após uma simulação, o SimVision pode abrir automaticamente se configurado no script.

Onde Verificar Cada Relatório
Os resultados e relatórios gerados estão organizados nas seguintes pastas:

Relatório / Saída	Localização	Descrição
Relatório Final do Projeto	Relatórios/	PDF com a documentação completa do projeto, resultados e análises.
Relatórios de Síntese	Genus Log/ e rpt/	Logs de síntese, relatórios de área, timing, potência e power.
Relatórios de Cobertura Funcional	cov_reports/	Relatórios gerados em formato HTML. Abra o arquivo index.html para navegar pelos resultados de cobertura.
Logs de Simulação	xrun.log (raiz) e xcelium.d/	Log principal da simulação com mensagens de erro, aviso e resultados de testes.
Formas de Onda	waves.shm/	Banco de dados de formas de onda para análise detalhada no SimVision.
Arquivos de Cobertura (dados brutos)	cov_work/	Dados intermediários da ferramenta de cobertura.
Como Visualizar os Relatórios
Relatório Final (PDF): Utilize qualquer leitor de PDF (ex: evince Relatórios/nome_do_arquivo.pdf).

Relatórios de Síntese (Genus): São arquivos de texto. Use cat, less ou um editor de texto.

Relatórios de Cobertura Funcional: Acesse a pasta cov_reports/ e abra o arquivo index.html em um navegador web:

bash
firefox cov_reports/index.html
ou

bash
google-chrome cov_reports/index.html
Formas de Onda: Abra o SimVision:

bash
simvision waves.shm/ &
Notas Adicionais
O projeto foi desenvolvido e testado em ambiente Linux com ferramentas Cadence.

Os arquivos de log (xrun.log, imc.log, etc.) são essenciais para depuração.

Para limpar os diretórios de simulação e síntese, o Makefile pode conter um alvo clean.

Autor
Gabriel de Lima Pessoa (gabrieomineiro)

text

Este arquivo README.md agora está formatado corretamente e inclui a instrução específica para abrir o `index.html` na pasta `cov_reports` para visualizar os relatórios de cobertura funcional.