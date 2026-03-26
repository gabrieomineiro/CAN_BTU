# CAN_BTU: Controller Area Network Bit Timing Unit

## Sobre o Projeto

O **CAN_BTU** (Bit Timing Unit) é um módulo de hardware digital dedicado, implementado em Verilog, responsável pelo gerenciamento de temporização de bits para um controlador CAN (Controller Area Network) compatível com o protocolo **CAN 2.0B**.

A unidade de temporização de bits é um componente crítico em qualquer controlador CAN, pois é responsável por:

- **Gerar o tempo de bit**: Dividindo o clock do sistema em segmentos de tempo discretos (Time Quanta - Tq).
- **Amostragem correta**: Determinar o ponto exato dentro de cada bit para amostrar o valor do barramento, garantindo comunicação confiável mesmo em altas velocidades ou com osciladores de baixa precisão.
- **Compensação de atrasos**: Sincronizar os nós da rede através de mecanismos de sincronização forte (Hard Sync) e ressincronização (Soft Sync), compensando desvios de fase entre diferentes osciladores.
- **Configuração flexível**: Permitir a programação de parâmetros como *prescaler*, segmentos de bit (TSEG1, TSEG2) e *Synchronization Jump Width* (SJW) para suportar diversas taxas de transmissão e otimizar a robustez da rede.

## Status do Desenvolvimento e Estrutura do Repositório

O repositório reflete a conclusão bem-sucedida da fase de design e verificação do módulo. A estratégia de verificação combinou três metodologias complementares: **UVM** para verificação funcional randômica, **Verificação Formal** para prova de propriedades críticas e **Testbench Direcionado** para validação rápida e pós-síntese.

Abaixo está uma visão geral do conteúdo do repositório:

### `rtl/` - Código Fonte RTL
- **O quê**: Arquivos Verilog com a implementação sintetizável da BTU.
- **Feito**: A lógica principal da Unidade de Temporização de Bits, incluindo a máquina de estados, contadores de Time Quanta (Tq) e a lógica de sincronização (Hard e Soft Sync).

### `uvm/` - Verificação Funcional com UVM
- **O quê**: Ambiente de verificação completo utilizando a metodologia Universal Verification Methodology (UVM).
- **Feito**: Uma suíte de testes foi desenvolvida para validar exaustivamente o comportamento da BTU. Inclui drivers, monitores, scoreboard (com modelo de referência em SystemVerilog) e sequências randomizadas que cobrem todos os cenários descritos no plano de verificação.

### `fv/` - Verificação Formal
- **O quê**: Arquivos relacionados à verificação formal, incluindo *assertions* em SystemVerilog (SVA).
- **Feito**: Propriedades críticas foram definidas e provadas matematicamente, garantindo invariantes de temporização (ex: ponto de amostragem dentro da janela válida, limites do SJW) e ausência de *deadlock* na máquina de estados, complementando a verificação funcional dinâmica.

### `constraints/` - Restrições de Síntese
- **O quê**: Arquivos de constraints (`.sdc` ou `.xdc`) para ferramentas de síntese lógica.
- **Feito**: As restrições de tempo (clock, entradas/saídas) foram definidas para guiar a síntese e garantir que o design atinja a frequência de operação desejada na tecnologia alvo.

### `script/` - Scripts de Automação
- **O quê**: Scripts para executar as ferramentas de simulação, síntese e fluxo de design.
- **Feito**: Scripts para automatizar a compilação do código, a execução das simulações (Xcelium) e o fluxo de síntese (Genus).

### `rpt/` e `rpt_gt_lvl/` - Relatórios
- **O quê**: Relatórios gerados pelas ferramentas EDA.
- **Feito**: Contém relatórios de área, potência e *timing* da síntese lógica, além de logs de simulação. A pasta `rpt_gt_lvl` armazena os relatórios da simulação pós-síntese (*gate-level*) com anotação de atrasos (SDF).

### Outros Arquivos Importantes
- **`can_btu_top.sdf`**: Arquivo Standard Delay Format utilizado na simulação pós-síntese para verificar o funcionamento com atrasos reais da célula.
- **`can_btu_tb.vcd`**: *Value Change Dump* da simulação, permitindo a visualização detalhada das formas de onda.
- **`filelist.f` e `synth.f`**: Arquivos de lista que especificam todos os arquivos de origem para simulação e síntese, respectivamente.
- **`xrun.log`, `xcelium.d/`**: Arquivos gerados pelas ferramentas de simulação da Cadence (Xcelium), evidenciando a execução bem-sucedida das simulações.

## Conclusão do Escopo Atual

Com base nos arquivos presentes e nos documentos de especificação (`spec`) e plano de verificação (`vplan`), o projeto **CAN_BTU** atingiu um marco importante de desenvolvimento. As principais etapas concluídas são:

1.  **Implementação RTL** do módulo Bit Timing Unit conforme a especificação CAN 2.0B.
2.  **Verificação funcional robusta** utilizando UVM, com cobertura funcional e de código planejada e mensurada.
3.  **Verificação formal** para checagem de propriedades e invariantes críticos.
4.  **Síntese lógica** guiada por constraints de tempo, com relatórios de área e potência.
5.  **Simulação pós-síntese** (gate-level), confirmando o funcionamento do design com atrasos reais.
6.  **Documentação completa**, incluindo especificação técnica e plano de verificação, que definem os critérios de sucesso e a estratégia de testes.

Este repositório serve como um entregável completo de um bloco de propriedade intelectual (IP) para um controlador CAN, pronto para ser integrado em um System-on-Chip (SoC) maior.

## Como Utilizar (Resumo)

Para reproduzir os resultados ou utilizar o módulo:

1.  **Simulação RTL**: Utilize um simulador Verilog compatível com UVM (como Xcelium, VCS) e a filelist `filelist.f`.
2.  **Síntese**: Utilize uma ferramenta de síntese lógica (como Genus, Design Compiler) com o script em `script/` e as constraints em `constraints/`, referenciando a filelist `synth.f`.
3.  **Visualização**: Carregue o banco de dados `waves.shm` no Simvision ou o arquivo `can_btu_tb.vcd` em qualquer visualizador de formas de onda compatível com VCD.

## Licença

Este projeto está licenciado sob a licença Apache 2.0 - veja o arquivo LICENSE para mais detalhes.

## Sobre o Autor

**Gabriel de Lima Pessoa**  
*Especificação Técnica e Plano de Verificação - Março de 2026*

---
*Para mais detalhes sobre a arquitetura, interface, protocolo e estratégia de verificação, consulte os documentos `gabriel_pessoa_spec_Entrega1.pdf` e `gabriel_pessoa_vplan_Entrega1.pdf` incluídos neste repositório.*