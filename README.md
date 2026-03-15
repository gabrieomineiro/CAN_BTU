# CAN_BTU: Controller Area Network Bit Timing Unit

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

## Sobre o Projeto

O **CAN_BTU** (Bit Timing Unit) é um módulo de hardware digital dedicado, implementado em Verilog, responsável pelo gerenciamento de temporização de bits para um controlador CAN (Controller Area Network) compatível com o protocolo CAN 2.0B.

A unidade de temporização de bits é um componente crítico em qualquer controlador CAN, pois é responsável por:
*   **Gerar o tempo de bit:** Dividindo o clock do sistema (geralmente relacionado ao clock do processador ou do barramento) em segmentos de tempo discretos (Time Quanta - Tq).
*   **Amostragem correta:** Determinar o ponto exato dentro de cada bit para amostrar o valor do barramento, garantindo uma comunicação confiável mesmo em altas velocidades ou na presença de osciladores com baixa precisão.
*   **Compensação de atrasos:** Sincronizar os nós da rede através de mecanismos de sincronização dura (hard sync) e ressincronização (soft sync), compensando desvios de fase entre os diferentes osciladores dos nós da rede.
*   **Definir pontos de amostragem e jump-width de sincronização (SJW):** Parâmetros configuráveis que determinam a robustez e a taxa de dados da rede.

Este repositório contém o desenvolvimento completo da BTU, desde sua especificação RTL (Register Transfer Level) até a verificação funcional e síntese lógica.

## Status do Desenvolvimento e Estrutura do Repositório

O repositório reflete um projeto de hardware concluído em sua fase de design e verificação. Abaixo está uma visão geral do que foi feito até agora, organizado pelas pastas e arquivos presentes:

### 📁 `src/` - Código Fonte RTL
*   **O quê:** Contém os arquivos Verilog com a implementação da BTU.
*   **Feito até agora:** A lógica principal da Unidade de Temporização de Bits foi implementada e sintetizável. Os módulos provavelmente incluem a máquina de estados para geração de bits, os contadores para divisão de clock e a lógica de sincronização.

### 📁 `uvm/` - Verificação Funcional
*   **O quê:** Ambiente de verificação completo utilizando a metodologia Universal Verification Methodology (UVM).
*   **Feito até agora:** Uma suíte de testes foi desenvolvida para validar exaustivamente o comportamento da BTU. Isso inclui a criação de drivers, monitores, sequências e scoreboards para garantir que o módulo atenda a todas as especificações do protocolo CAN.

### 📁 `constraints/` - Restrições de Síntese
*   **O quê:** Arquivos de constraints (`.sdc` ou `.xdc`) para ferramentas de síntese lógica.
*   **Feito até agora:** As restrições de tempo (clock, entradas/saídas) foram definidas para guiar a ferramenta de síntese e garantir que o design atinja a frequência de operação desejada na tecnologia alvo.

### 📁 `script/` - Scripts de Automação
*   **O quê:** Scripts para executar as ferramentas de simulação, síntese e fluxo de design.
*   **Feito até agora:** Scripts foram criados para automatizar a compilação do código, a execução das simulações (com Xcelium, por exemplo) e o fluxo de síntese (com Genus, por exemplo).

### 📁 `rpt/` - Relatórios
*   **O quê:** Relatórios gerados pelas ferramentas EDA.
*   **Feito até agora:** Contém relatórios de área, potência e timing da síntese, bem como logs de simulação, documentando os resultados e a qualidade do design.

### 📁 `fv/` - Verificação Formal
*   **O quê:** Arquivos relacionados à verificação formal do design.
*   **Feito até agora:** Propriedades e assertions foram escritas para provar matematicamente certas características do design, complementando a verificação funcional dinâmica (UVM).

### 📁 `img/` e `waves.shm/` - Visualização
*   **O quê:** Imagens e banco de dados de formas de onda.
*   **Feito até agora:** Capturas de tela da estrutura do design e bancos de dados de simulação (waves.shm) que permitem a visualização detalhada dos sinais durante os testes, auxiliando na depuração.

### 📁 `.simvision/`, `xcelium.d/` e arquivos de log (`xrun.log`)
*   **O quê:** Arquivos gerados pelas ferramentas de simulação da Cadence (Simvision, Xcelium).
*   **Feito até agora:** Evidenciam que as simulações foram executadas com sucesso. Os logs e bancos de dados estão disponíveis para consulta.

### 📁 `synth.f`, `filelist.f`
*   **O quê:** Arquivos de filelist para as ferramentas.
*   **Feito até agora:** Listam todos os arquivos de origem necessários para a síntese (`synth.f`) e simulação (`filelist.f`), facilitando a execução dos fluxos.

### 📄 `can_btu_tb.vcd` e `can_btu_top.sdf`
*   **O quê:** `can_btu_tb.vcd` é um dump de simulação no formato Value Change Dump. `can_btu_top.sdf` (Standard Delay Format) contém os atrasos calculados para a netlist pós-síntese.
*   **Feito até agora:** A existência do arquivo `.sdf` indica que a simulação pós-síntese (gate-level simulation) foi realizada para verificar o funcionamento do design com os atrasos reais da célula padrão.

## Conclusão do Escopo Atual

Com base nos arquivos presentes, o projeto **CAN_BTU** atingiu um marco importante de desenvolvimento. As principais etapas concluídas são:

1.  **Implementação RTL** do módulo Bit Timing Unit.
2.  **Verificação funcional robusta** utilizando UVM.
3.  **Verificação formal** para checagem de propriedades.
4.  **Síntese lógica** guiada por constraints de tempo.
5.  **Simulação pós-síntese**, confirmando o funcionamento com atrasos.
6.  **Geração de relatórios** de área, potência e timing.

Este repositório serve como um entregável completo de um bloco de propriedade intelectual (IP) para um controlador CAN, pronto para ser integrado em um System-on-Chip (SoC) maior.

## Como Utilizar (Resumo)

Para reproduzir os resultados ou utilizar o módulo:

1.  **Simulação RTL:** Utilize um simulador Verilog (como Xcelium, VCS, Modelsim) com a filelist `filelist.f`.
2.  **Síntese:** Utilize uma ferramenta de síntese lógica (como Genus, Design Compiler) com o script em `script/` e as constraints em `constraints/`, referenciando a filelist `synth.f`.
3.  **Visualização:** Carregue o banco de dados `waves.shm` no Simvision ou o arquivo `can_btu_tb.vcd` em qualquer visualizador de formas de onda compatível com VCD.

## Licença

Este projeto está licenciado sob a licença Apache 2.0 - veja o arquivo [LICENSE](LICENSE) para mais detalhes.