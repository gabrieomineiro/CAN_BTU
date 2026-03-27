# CAN Bit Timing Unit (BTU)

## Visão Geral

Este repositório contém a descrição em hardware (RTL) e o ambiente de verificação de uma Bit Timing Unit (BTU) utilizada em um controlador CAN (Controller Area Network).

A BTU é responsável por gerar os segmentos de tempo necessários para o protocolo CAN, garantindo a sincronização correta e o ponto de amostragem adequado dos bits no barramento.

O projeto foi desenvolvido em Verilog/SystemVerilog e inclui um ambiente de verificação baseado em UVM (Universal Verification Methodology).

## Funcionalidades

- Configuração dos parâmetros de temporização do CAN:
  - Prescaler
  - Propagation Segment (PROP_SEG)
  - Phase Segment 1 (PHASE_SEG1)
  - Phase Segment 2 (PHASE_SEG2)
  - Synchronization Jump Width (SJW)
- Geração de Time Quantum (TQ)
- Máquina de estados para controle do tempo de bit
- Suporte à sincronização (hard sync e resync)
- Arquitetura RTL modular e extensível
- Ambiente de verificação baseado em UVM

## Estrutura do Repositório

CAN_BTU/
├── rtl/                # Implementação RTL (Verilog)
├── uvm/                # Ambiente de verificação UVM
│   ├── tb/             # Testbench top-level
│   ├── env/            # Componentes do ambiente
│   ├── agent/          # Driver, monitor e sequencer
│   ├── seq/            # Sequences e sequence items
│   ├── test/           # Casos de teste
├── sim/                # Scripts de simulação (se aplicável)
└── README.md

## Teoria de Bit Timing (Resumo)

No protocolo CAN, cada bit é dividido em segmentos de tempo:

Sync_Seg | Prop_Seg | Phase_Seg1 | Phase_Seg2

- Sync_Seg: segmento de sincronização (fixo)
- Prop_Seg: compensa atrasos físicos do barramento
- Phase_Seg1: ajusta o ponto de amostragem
- Phase_Seg2: fornece margem para ressincronização

A BTU gera esses segmentos com base nos parâmetros configurados, garantindo o funcionamento correto da comunicação.

## Como Utilizar

### Pré-requisitos

- Simulador com suporte a SystemVerilog e UVM:
  - Cadence Xcelium
  - Synopsys VCS
  - Siemens Questa

- Biblioteca UVM devidamente configurada

### Execução da Simulação (exemplo com Xcelium)

cd uvm/tb

xrun -sv -uvm -access +rwc +UVM_TESTNAME=can_btu_test -f filelist.f

## Verificação

O projeto utiliza UVM para validação funcional da BTU.

Principais componentes:

- Sequence Item: define as transações de configuração
- Driver: aplica estímulos ao DUT
- Monitor: observa os sinais do DUT
- Scoreboard: verifica a corretude do comportamento
- Coverage Collector: mede cobertura funcional

## Parâmetros de Configuração

prescaler  - Divide o clock de entrada em TQ
prop_seg   - Tamanho do segmento de propagação
phase_seg1 - Segmento de fase 1
phase_seg2 - Segmento de fase 2
sjw        - Largura de salto de sincronização

## Melhorias Futuras

- Integração com um controlador CAN completo
- Suporte a CAN FD
- Verificação formal
- Prototipação em FPGA (ex: Tang Nano 20K)
- Otimizações de desempenho da lógica de temporização

## Observações

- Este projeto implementa apenas a Bit Timing Unit, não um controlador CAN completo.
- Para uso em hardware real, é necessário um transceiver CAN externo.

## Autor

Gabriel de Lima Pessoa

## Licença

Este projeto é open-source. A licença pode ser definida conforme necessário.
