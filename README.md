# Projeto CAN_BTU (Bit Timing Unit)

## Visão Geral do Projeto

Este projeto implementa uma **Unit de Temporização de Bits (BTU)** para o barramento CAN (Controller Area Network), um protocolo de comunicação amplamente utilizado em aplicações automotivas e industriais. O projeto foi desenvolvido em linguagem **SystemVerilog** utilizando a metodologia **UVM (Universal Verification Methodology)** para a verificação funcional.

O módulo CAN_BTU é responsável por:
- Gerar a temporização correta para a transmissão e recepção de bits no barramento CAN
- Implementar a segmentação do tempo de bit em diferentes segmentos (Sync_Seg, Prop_Seg, Phase_Seg1, Phase_Seg2)
- Suportar diferentes taxas de comunicação (baud rates)
- Sincronizar as bordas de amostragem dos bits recebidos

---

## Estrutura de Diretórios

```
├── rtl/                    # Código RTL do projeto (design)
│   ├── can_btu_defines.svh # Definições e parâmetros do projeto
│   ├── can_btu_top.sv      # Módulo top em SystemVerilog
│   └── can_btu_top.v       # Módulo top em Verilog
│
├── uvm/                    # Ambiente de verificação UVM
│   ├── tb_can_btu.sv       # Testbench top
│   ├── can_btu_test.sv     # Testes UVM
│   ├── can_btu_env.sv      # Ambiente UVM
│   ├── can_btu_agent.sv    # Agente UVM
│   ├── can_btu_driver.sv   # Driver do agente
│   ├── can_btu_monitor.sv  # Monitor do agente
│   ├── can_btu_sequence.sv # Sequências de estímulo
│   ├── can_btu_seq_item.sv # Item de sequência
│   ├── can_btu_scoreboard.sv # Scoreboard para comparação
│   ├── can_btu_coverage.sv # Covergroups para coverage
│   └── can_btu_if.sv       # Interface UVM
│
├── script/                 # Scripts e listas de arquivos
│   ├── simlist.f           # Lista de arquivos para simulação RTL
│   ├── cellist.f           # Lista para simulação Gate-Level
│   ├── synth.f             # Lista para síntese
│   ├── can_btu_gpt.tcl     # Script de configuração
│   └── setup_1.tcl         # Script de setup
│
├── constraints/            # Arquivos de constraints
│   ├── can_btu_top.sdc     # Arquivo SDC (Synopsys Design Constraints)
│   └── can_btu_top.sdf     # Arquivo SDF (Standard Delay Format)
│
├── rpt/                    # Relatórios de síntese e timing
│   ├── rpt_rtl_lvl-*/      # Relatórios nível RTL
│   └── rpt_gt_lvl-*/       # Relatórios nível Gate-Level
│       ├── can_btu_top_area.rpt      # Relatório de área
│       ├── can_btu_top_power.rpt     # Relatório de potência
│       ├── can_btu_top_time.rpt      # Relatório de timing
│       ├── can_btu_top_timing.rpt    # Análise de timing
│       ├── can_btu_top_qor.rpt       # Relatório QoR
│       └── can_btu_top_summary.rpt   # Resumo
│
├── cov_reports/            # Relatórios de coverage em HTML
│   ├── index.html          # Página principal
│   ├── biN_report/         # Relatório de coverage binário
│   ├── extended_report/    # Relatório estendido
│   └── metrics_report/     # Relatório de métricas
│
├── Genus Log/              # Logs da ferramenta de síntese Genus
│
├── fv/                     # Arquivos de Formal Verification
│   └── can_btu_top/        # Mapeamento e configurações FV
│
├── Relatórios/             # Relatórios em PDF
│   ├── gabriel_pessoa_spec_Entrega1.pdf    # Especificação
│   └── gabriel_pessoa_vplan_Entrega1.pdf   # Plano de verificação
│
├── img/                    # Imagens e screenshots
│   ├── *.png               # Screenshots de simulações
│   ├── *.jpeg              # Fotos de simulações
│   └── Schematic/          # Esquemáticos do design
│
├── other code/             # Código adicional
│   ├── can_btu_coverage_collector.sv
│   └── CAN_BTU_GPT.sdc
│
├── Make.mk                 # Makefile principal do projeto
├── BTU.gitignore           # Arquivo .gitignore
└── README.md               # Este arquivo
```

---

## Como Rodar as Simulações

### Pré-requisitos

- **Cadence Xcelium** (ou outro simulador SystemVerilog/UVM compatível)
- **Make** instalado
- Acesso às bibliotecas UVM

### Comandos de Simulação

O projeto utiliza o **Makefile** para executar as simulações. Execute os comandos abaixo no diretório raiz do projeto:

#### 1. Simulação RTL Level (com GUI)
```bash
make rtl
```
Executa a simulação no nível RTL com interface gráfica.

#### 2. Simulação RTL Level (batch/sem GUI)
```bash
make rtl_batch
```
Executa a simulação RTL sem interface gráfica (modo batch).

#### 3. Simulação Gate Level (com GUI)
```bash
make gate
```
Executa a simulação após a síntese (netlist gate-level) com interface gráfica.

#### 4. Simulação Gate Level (batch)
```bash
make gate_batch
```
Executa a simulação Gate-Level sem GUI.

#### 5. Simulação com Coverage (com GUI)
```bash
make coverage
```
Executa a simulação com coleta de coverage e interface gráfica.

#### 6. Simulação com Coverage e Relatório
```bash
make coverage_report
```
Executa a simulação com coverage e gera os relatórios HTML.

#### 7. Verificar Estrutura de Diretórios
```bash
make check_dirs
```
Verifica se todos os arquivos e diretórios necessários existem.

#### 8. Limpar Arquivos Gerados
```bash
make clean       # Limpa todos os arquivos de simulação
make clean_cov   # Limpa apenas arquivos de coverage
```

#### 9. Ajuda
```bash
make help
```
Mostra a lista de todos os comandos disponíveis.

---

## Como Ver os Relatórios

### Relatórios de Coverage (HTML)

Os relatórios de coverage são gerados automaticamente após a execução de simulações com coverage.

1. **Executar a simulação com coverage:**
   ```bash
   make coverage_report
   ```

2. **Abrir os relatórios:**
   
   Os relatórios HTML podem ser abertos em qualquer navegador web moderno.
   
   - **Relatório principal:** Abra o arquivo `cov_reports/index.html`
   - **Relatório de métricas:** Abra `cov_reports/metrics_report/index.html`
   - **Relatório estendido:** Abra `cov_reports/extended_report/index.html`
   
   No Windows, você pode usar:
   ```cmd
   start cov_reports\index.html
   ```
   
   Ou simplesmente navegar até a pasta `cov_reports/` e clicar no arquivo `index.html`.

### Relatórios de Síntese (Texto)

Os relatórios de síntese estão localizados na pasta `rpt/`:

- **Nível RTL:** Pasta `rpt_rtl_lvl-*/`
- **Nível Gate-Level:** Pasta `rpt_gt_lvl-*/`

Para visualizar um relatório, basta abrir o arquivo `.rpt` correspondente em qualquer editor de texto:

```cmd
type rpt\rpt_gt_lvl-26-03-26\can_btu_top_summary.rpt
```

Principais relatórios:
| Arquivo | Descrição |
|---------|-----------|
| `can_btu_top_summary.rpt` | Resumo da síntese |
| `can_btu_top_area.rpt` | Relatório de área (gates) |
| `can_btu_top_power.rpt` | Relatório de potência |
| `can_btu_top_time.rpt` | Relatório de timing |
| `can_btu_top_qor.rpt` | Quality of Results |
| `can_btu_top_slack.rpt` | Análise de slack |

### Relatórios em PDF

Os documentos PDF estão localizados na pasta `Relatórios/`:

- `gabriel_pessoa_spec_Entrega1.pdf` - Documento de especificação do projeto
- `gabriel_pessoa_vplan_Entrega1.pdf` - Plano de verificação (Verification Plan)

Para abrir os PDFs no Windows:
```cmd
start Relatórios\gabriel_pessoa_spec_Entrega1.pdf
```

---

## Ondas e Simulação

### Visualizando Ondas (Waveforms)

Após executar uma simulação, as ondas são salvas no diretório `waves.shm/`. Para visualizar:

1. Execute uma simulação com GUI:
   ```bash
   make rtl
   ```

2. No simulador (SimVision), abra o arquivo de onda:
   - Navegue até `waves.shm/`
   - Selecione o arquivo de waveform

### Arquivos de Onda Gerados

- **Formato SIMVISION:** Diretório `waves.shm/`
- **Formato VCD:** Arquivos `.vcd` nos diretórios `rpt_*/`

---

## Ferramentas Utilizadas

| Ferramenta | Finalidade |
|------------|------------|
| **Cadence Xcelium** | Simulador SystemVerilog/UVM |
| **Genus** | Síntese lógica |
| **Voltus** | Análise de potência |
| **Tempus** | Análise de timing |
| **JasperGold** | Formal verification |
| **SimVision** | Visualização de ondas e debug |

---
```

---

## Contato e Suporte

Este projeto foi desenvolvido como parte de avaliação acadêmica.

Para dúvidas sobre o projeto, verifique:
1. A especificação em `Relatórios/gabriel_pessoa_spec_Entrega1.pdf`
2. O plano de verificação em `Relatórios/gabriel_pessoa_vplan_Entrega1.pdf`
3. Os logs de simulação em `xrun.log`
4. Os logs de síntese em `Genus Log/`

---

**Data de Criação:** Março 2026
**Versão:** 1.0
