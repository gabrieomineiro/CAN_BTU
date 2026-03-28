# Makefile para simulação do projeto CAN_BTU
# Repositório: https://github.com/gabrieomineiro/CAN_BTU

# Variáveis
SIMULATOR = xrun
UVMHOME = CDNS-1.2
TIMESCALE = 1ns/1ps
TOP = tb_can_btu

# Diretórios
SCRIPT_DIR = script
CONSTRAINTS_DIR = constraints
RTL_LIST = $(SCRIPT_DIR)/simlist.f
GATE_LIST = $(SCRIPT_DIR)/cellist.f
SDC_FILE = $(CONSTRAINTS_DIR)/can_btu_top.sdc

# Opções comuns
COMMON_OPTS = -64bit -sv -uvm -access +rwc
GUI_OPTS = -gui

# Cores para output (opcional)
GREEN = \033[0;32m
RED = \033[0;31m
NC = \033[0m # No Color

# Targets principais
.PHONY: all clean rtl gate coverage coverage_report help

all: help

# Simulação RTL Level
rtl:
	@echo "$(GREEN)Executando simulação RTL Level...$(NC)"
	$(SIMULATOR) -sv -uvm -64bit -access +rwc -f $(RTL_LIST) -top $(TOP) $(GUI_OPTS)
	@echo "$(GREEN)Simulação RTL finalizada$(NC)"

# Simulação Gate Level
gate:
	@echo "$(GREEN)Executando simulação Gate Level...$(NC)"
	$(SIMULATOR) -64bit -timescale $(TIMESCALE) -sv -uvm +access+rwc $(GUI_OPTS) -f $(GATE_LIST) -top $(TOP) -sdc $(SDC_FILE) +define+GATE_LEVEL
	@echo "$(GREEN)Simulação Gate Level finalizada$(NC)"

# Simulação com coleta de coverage
coverage:
	@echo "$(GREEN)Executando simulação com cobertura...$(NC)"
	$(SIMULATOR) -sv_ms -uvm -uvmhome $(UVMHOME) -f $(RTL_LIST) $(GUI_OPTS) -coverage all -access +rwc
	@echo "$(GREEN)Simulação com cobertura finalizada$(NC)"

# Simulação com coverage e geração de relatórios
coverage_report:
	@echo "$(GREEN)Executando simulação com cobertura e geração de relatórios...$(NC)"
	$(SIMULATOR) -sv_ms -uvm -uvmhome $(UVMHOME) -f $(RTL_LIST) -coverage all -access +rwc -covoverwrite
	@echo "$(GREEN)Simulação com cobertura e relatórios finalizada$(NC)"

# Simulação RTL sem GUI (para batch)
rtl_batch:
	@echo "$(GREEN)Executando simulação RTL Level (batch mode)...$(NC)"
	$(SIMULATOR) -sv -uvm -64bit -access +rwc -f $(RTL_LIST) -top $(TOP)
	@echo "$(GREEN)Simulação RTL batch finalizada$(NC)"

# Simulação Gate Level sem GUI (para batch)
gate_batch:
	@echo "$(GREEN)Executando simulação Gate Level (batch mode)...$(NC)"
	$(SIMULATOR) -64bit -timescale $(TIMESCALE) -sv -uvm +access+rwc -f $(GATE_LIST) -top $(TOP) -sdc $(SDC_FILE) +define+GATE_LEVEL
	@echo "$(GREEN)Simulação Gate Level batch finalizada$(NC)"

# Verificar estrutura de diretórios
check_dirs:
	@echo "$(GREEN)Verificando estrutura de diretórios...$(NC)"
	@if [ ! -d "$(SCRIPT_DIR)" ]; then echo "$(RED)Erro: Diretório $(SCRIPT_DIR) não encontrado$(NC)"; exit 1; fi
	@if [ ! -d "$(CONSTRAINTS_DIR)" ]; then echo "$(RED)Erro: Diretório $(CONSTRAINTS_DIR) não encontrado$(NC)"; exit 1; fi
	@if [ ! -f "$(RTL_LIST)" ]; then echo "$(RED)Erro: Arquivo $(RTL_LIST) não encontrado$(NC)"; exit 1; fi
	@if [ ! -f "$(GATE_LIST)" ]; then echo "$(RED)Erro: Arquivo $(GATE_LIST) não encontrado$(NC)"; exit 1; fi
	@if [ ! -f "$(SDC_FILE)" ]; then echo "$(RED)Erro: Arquivo $(SDC_FILE) não encontrado$(NC)"; exit 1; fi
	@echo "$(GREEN)Todos os arquivos e diretórios necessários foram encontrados$(NC)"

# Limpar arquivos gerados
clean:
	@echo "$(RED)Limpando arquivos de simulação...$(NC)"
	rm -rf xcelium.d
	rm -rf waves.shm
	rm -rf cov_work
	rm -rf *.log
	rm -rf *.key
	rm -rf *.trn
	rm -rf *.shm
	rm -rf *.vcd
	@echo "$(GREEN)Limpeza concluída$(NC)"

# Limpar apenas coverage
clean_cov:
	@echo "$(RED)Limpando arquivos de cobertura...$(NC)"
	rm -rf cov_work
	rm -rf *.cov
	@echo "$(GREEN)Limpeza de coverage concluída$(NC)"

# Ajuda
help:
	@echo "Uso: make [target]"
	@echo ""
	@echo "Targets disponíveis:"
	@echo "  $(GREEN)rtl$(NC)              - Executa simulação RTL Level com GUI"
	@echo "  $(GREEN)gate$(NC)             - Executa simulação Gate Level com GUI"
	@echo "  $(GREEN)coverage$(NC)         - Executa simulação com cobertura e GUI"
	@echo "  $(GREEN)coverage_report$(NC)  - Executa simulação com cobertura e gera relatórios"
	@echo "  $(GREEN)rtl_batch$(NC)        - Executa simulação RTL Level sem GUI"
	@echo "  $(GREEN)gate_batch$(NC)       - Executa simulação Gate Level sem GUI"
	@echo "  $(GREEN)check_dirs$(NC)       - Verifica se todos os arquivos e diretórios existem"
	@echo "  $(GREEN)clean$(NC)            - Remove todos os arquivos gerados"
	@echo "  $(GREEN)clean_cov$(NC)        - Remove apenas arquivos de cobertura"
	@echo "  $(GREEN)help$(NC)             - Mostra esta mensagem de ajuda"
	@echo ""
	@echo "Estrutura esperada:"
	@echo "  ./"
	@echo "  ├── script/"
	@echo "  │   ├── simlist.f"
	@echo "  │   └── cellist.f"
	@echo "  ├── constraints/"
	@echo "  │   └── can_btu_top.sdc"
	@echo "  └── Makefile"
	@echo ""
	@echo "Exemplos:"
	@echo "  make check_dirs        # Verifica estrutura antes de simular"
	@echo "  make rtl              # Executa simulação RTL"
	@echo "  make coverage         # Executa simulação com cobertura"
	@echo "  make clean            # Limpa todos os arquivos"