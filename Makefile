all:
REF_DESIGN_DIR?=icicle-kit-reference-design
TOP_LEVEL=MPFS_ICICLE_eMMC
REF_DESIGN=$(REF_DESIGN_DIR)/ICICLE_KIT_eMMC.tcl
PRJX=$(REF_DESIGN_DIR)/$(TOP_LEVEL)/$(TOP_LEVEL).prjx
PROJ_CREATE=$(REF_DESIGN_DIR)/$(TOP_LEVEL)/smartgen/$(TOP_LEVEL)_work.ixf
SYNTH_FILE=$(REF_DESIGN_DIR)/$(TOP_LEVEL)/synthesis/$(TOP_LEVEL).srr
PR_FILE=$(REF_DESIGN_DIR)/$(TOP_LEVEL)/designer/$(TOP_LEVEL)/$(TOP_LEVEL).map
$(PROJ_CREATE): icicle_kit.tcl $(REF_DESIGN)
	rm -rf $(REF_DESIGN_DIR)/$(TOP_LEVEL)
	libero "script:icicle_kit.tcl" "script_args:$(REF_DESIGN_DIR)"
	test -f $@
$(REF_DESIGN):
	git clone -b2020.12  "https://github.com/polarfire-soc/icicle-kit-reference-design.git" $(REF_DESIGN_DIR)

RUN_COMMAND=bash -c "libero script:<(echo 'open_project -file $(1);$(2)') | grep -v 'Reading file'"


synthesis:$(SYNTH_FILE)
placeroute:$(PR_FILE)

$(SYNTH_FILE):$(PROJ_CREATE)
	$(call RUN_COMMAND, $(PRJX), \
	 derive_constraints_sdc; \
	 run_tool -name SYNTHESIZE;)
	test -f $@
$(PR_FILE):$(SYNTH_FILE)
	$(call RUN_COMMAND, $(PRJX), \
	  run_tool -name PLACEROUTE;\
	  run_tool -name VERIFYTIMING; \
	  run_tool -name GENERATEPROGRAMMINGDATA)	  
	test -f $@

bitstream:$(PR_FILE)
	$(call RUN_COMMAND, \
	$(PRJX), \
	run_tool -name GENERATEPROGRAMMINGFILE)
all:bitstream

.PHONY:gui

gui:$(PROJ_CREATE)
	libero $(PRJX)
