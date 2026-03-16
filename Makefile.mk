# Makefile para Síntese do CAN_BTU com Cadence Genus
# Autor: Baseado na estrutura do repositório gabrieomineiro/CAN_BTU
# Data: 17/03/2026

# ==================================================
# V A R I Á V E I S   D E   C O N F I G U R A Ç Ã O
# ==================================================
# Defina os caminhos das ferramentas e arquivos principais

# Comando para executar o Genus (verifique se está no PATH ou forneça o caminho completo)
GENUS_CMD   ?= genus

# Arquivos de configuração do projeto
FILELIST_SYNTH  := ./synth.f
CONSTRAINTS_SDC := ./constraints/can_btu_top.sdc

# Script TCL principal que será gerado ou chamado
GENUS_SCRIPT := ./script/run_genus.tcl

# Diretórios de saída para resultados da síntese
REPORTS_DIR   := ./rpt
RESULTS_DIR   := ./results
LOG_DIR       := ./logs
WORK_DIR      := ./work_genus

# Nome do top-level (provavelmente can_btu_top, baseado nos arquivos existentes)
DESIGN_TOP    := can_btu_top

# ==================================================
# T A R G E T S   P R I N C I P A I S
# ==================================================
.PHONY: all clean clean_all run_genus setup_dirs help

# Target padrão: executa a síntese
all: setup_dirs run_genus

# Ajuda: lista os principais comandos disponíveis
help:
	@echo "Comandos disponíveis no Makefile:"
	@echo "  make all         : (Padrão) Prepara diretórios e executa a síntese no Genus."
	@echo "  make run_genus   : Executa apenas o script de síntese (assume que os diretórios existem)."
	@echo "  make setup_dirs  : Cria os diretórios necessários para os resultados e logs."
	@echo "  make clean       : Remove diretórios e arquivos temporários da síntese (work, logs)."
	@echo "  make clean_all   : Remove diretórios temporários e resultados (work, logs, rpt, results)."
	@echo "  make help        : Mostra esta mensagem."

# ==================================================
# T A R G E T S   D E   P R E P A R A Ç Ã O
# ==================================================
# Cria os diretórios necessários se não existirem
setup_dirs:
	@echo "Criando diretórios de trabalho..."
	mkdir -p $(REPORTS_DIR) $(RESULTS_DIR) $(LOG_DIR) $(WORK_DIR)

# ==================================================
# T A R G E T S   D E   L I M P E Z A
# ==================================================
clean:
	@echo "Limpando diretórios temporários..."
	rm -rf $(WORK_DIR) $(LOG_DIR) *.log *.key *.history *~

clean_all: clean
	@echo "Limpando todos os resultados de síntese..."
	rm -rf $(REPORTS_DIR) $(RESULTS_DIR)

# ==================================================
# T A R G E T   P R I N C I P A L :  S Í N T E S E
# ==================================================
# Esta target executa o script TCL no Genus
run_genus: $(GENUS_SCRIPT) $(FILELIST_SYNTH) $(CONSTRAINTS_SDC)
	@echo "Iniciando síntese com Genus para o design $(DESIGN_TOP)..."
	@echo "Usando filelist: $(FILELIST_SYNTH)"
	@echo "Usando constraints: $(CONSTRAINTS_SDC)"
	@echo "Logs e resultados serão salvos em $(LOG_DIR) e $(REPORTS_DIR)"
	cd $(WORK_DIR) && \
	$(GENUS_CMD) -legacy_ui -files ../$(GENUS_SCRIPT) -log ../$(LOG_DIR)/genus_run
	@echo "Síntese concluída. Verifique os logs em $(LOG_DIR) e relatórios em $(REPORTS_DIR)."

# ==================================================
# G E R A Ç Ã O   D O   S C R I P T   T C L
# ==================================================
# Regra para criar o script TCL dinamicamente, baseado nos arquivos do projeto
$(GENUS_SCRIPT):
	@echo "Gerando script TCL para Genus: $(GENUS_SCRIPT)"
	@echo "# Script TCL gerado pelo Makefile para síntese do CAN_BTU" > $@
	@echo "# Data: $(shell date)" >> $@
	@echo "" >> $@
	@echo "# Define bibliotecas (USUÁRIO DEVE AJUSTAR ESTE CAMINHO)" >> $@
	@echo "# Altere as variáveis abaixo para os caminhos das suas bibliotecas alvo." >> $@
	@echo "set init_lib_search_path {caminho/para/suas/bibliotecas}" >> $@
	@echo "set target_library {sua_biblioteca_alvo.db}" >> $@
	@echo "set link_library [concat * $$target_library]" >> $@
	@echo "" >> $@
	@echo "# Lê a lista de fontes do arquivo synth.f" >> $@
	@echo "set filelist [open \"../$(FILELIST_SYNTH)\" r]" >> $@
	@echo "set rtl_files [read $$filelist]" >> $@
	@echo "close $$filelist" >> $@
	@echo "read_hdl -v2001 $$rtl_files" >> $@
	@echo "" >> $@
	@echo "# Define o design top-level" >> $@
	@echo "elaborate $(DESIGN_TOP)" >> $@
	@echo "" >> $@
	@echo "# Lê as constraints de tempo" >> $@
	@echo "read_sdc ../$(CONSTRAINTS_SDC)" >> $@
	@echo "" >> $@
	@echo "# Configuração e síntese" >> $@
	@echo "set_db syn_generic_effort high" >> $@
	@echo "set_db syn_map_effort high" >> $@
	@echo "set_db syn_opt_effort high" >> $@
	@echo "syn_generic" >> $@
	@echo "syn_map" >> $@
	@echo "syn_opt" >> $@
	@echo "" >> $@
	@echo "# Gera relatórios" >> $@
	@echo "report_area > ../$(REPORTS_DIR)/area.rpt" >> $@
	@echo "report_gates > ../$(REPORTS_DIR)/gates.rpt" >> $@
	@echo "report_power > ../$(REPORTS_DIR)/power.rpt" >> $@
	@echo "report_timing > ../$(REPORTS_DIR)/timing.rpt" >> $@
	@echo "" >> $@
	@echo "# Escreve a netlist e constraints pós-síntese" >> $@
	@echo "write_hdl > ../$(RESULTS_DIR)/$(DESIGN_TOP)_netlist.v" >> $@
	@echo "write_sdc > ../$(RESULTS_DIR)/$(DESIGN_TOP)_post_synth.sdc" >> $@
	@echo "" >> $@
	@echo "# Sai do Genus" >> $@
	@echo "exit" >> $@
	@echo "Script $(GENUS_SCRIPT) gerado com sucesso."

# Indica que as targets 'run_genus' e '$(GENUS_SCRIPT)' são arquivos a serem considerados
# (evita conflitos se existirem diretórios com esses nomes)
.PHONY: run_genus $(GENUS_SCRIPT)