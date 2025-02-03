 #---------------------------------------------------------------------------------
 #                Copyright (c) 2022 
 #                ALL RIGHTS RESERVED
 #---------------------------------------------------------------------------------
 #Filename      : Makefile
 #Author        : AiF
 #Created On    : 2022-05-14 16:11
 #Last Modified : 
 #---------------------------------------------------------------------------------
 #Description   : 


 #---------------------------------------------------------------------------------
#TESTNAME = write_reset_test
#TESTNAME = read_reset_test
#TESTNAME = write_read_test
#TESTNAME = unusual_test
#TESTNAME = reset_test

#TESTNAME = wr_with_reset_test
#TESTNAME = write_fast_test
TESTNAME = read_fast_test
TIME = `date +%y%m%d%H`
SEED = $(TIME)
run : com sim
com :  
	$(shell if [-d $(TESTNAME)]; then echo "$(TESTNAME) exists"; else mkdir -p $(TESTNAME);fi) \
	vcs -sverilog -ntb_opts uvm-1.2 \
	-cm assert \
	+nospecify +notimingcheck -debug_access+all \
	-timescale=1ns/1ns +vcs+lic+wait -full64    \
	+vcsd +memcbk +vpi -kdb \
	-o top_lib/$(TESTNAME)$(SEED)_simv \
	-l ./$(TESTNAME)/vcs_compile_$(TESTNAME)$(SEED).log \
	+fsdb+region \
	-f ./filelist/rtl.f \
	-f ./filelist/agents.f \
	-f ./filelist/uvm_tb.f \
	-f ./filelist/tb.f 
sim:
	./top_lib/$(TESTNAME)$(SEED)_simv +fsdb+delta +UVM_TESTNAME=$(TESTNAME) +fsdb+sva_success -l ./$(TESTNAME)/$(TESTNAME)$(SEED)_sim.log 

nWave:
	nWave -ssf $(TESTNAME).fsdb -sswr fifo_signal.rc &
clean:
	rm -rf csrc *compile* *.h \
		novas*.* nWaveLog \
		verdiLog ucli.* DVEfile*
dve:
	dve -full64 &

cov:
	urg -dir ./top_lib/*.vdb -dbname cover/merge.vdb -full64 -report cover

verdi:
	verdi -full64 -nologo \
	-ssf $(TESTNAME).fsdb \
	-sswr fifo_signal.rc \
	#-dbdir top_lib/unusual_test22051715_simv.daidir
	-dbdir top_lib/wr_with_reset_test22051919_simv.daidir

view:
	cd $(TESTNAME) \ ls *.log
