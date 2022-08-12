PIC_LD=ld

ARCHIVE_OBJS=
ARCHIVE_OBJS += _15117_archive_1.so
_15117_archive_1.so : archive.0/_15117_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic  -o .//../top_lib/read_fast_test22051919_simv.daidir//_15117_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../top_lib/read_fast_test22051919_simv.daidir//_15117_archive_1.so $@





O0_OBJS =

$(O0_OBJS) : %.o: %.c
	$(CC_CG) $(CFLAGS_O0) -c -o $@ $<
 

%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<
CU_UDP_OBJS = \


CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \
objs/amcQw_d.o 

CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

