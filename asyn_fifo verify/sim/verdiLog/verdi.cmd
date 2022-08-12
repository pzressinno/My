simSetSimulator "-vcssv" -exec \
           "/home/ICer/mine/proj/asyn_fifo/sim/top_lib/read_fast_test22051919_simv" \
           -args "+UVM_TESTNAME=read_fast_test"
debImport "-full64" "-dbdir" \
          "/home/ICer/mine/proj/asyn_fifo/sim/top_lib/read_fast_test22051919_simv.daidir"
debLoadSimResult /home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb
wvCreateWindow
wvRestoreSignal -win $_nWave2 "fifo_signal.rc" -overWriteAutoAlias on \
           -appendSignals on
verdiWindowWorkMode -win $_Verdi_1 -assertionDebug
AssertStatistics -waveformStatistics -selectCell \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} Assert WaveformFile 
AssertStatistics -options -filterAll on
AssertStatistics -waveformStatistics -addSignal
propRstSetTab -propStat
propRstSetTab -waveformStat
propRstSetTab -propStat
verdiDockWidgetHide -dock widgetDock_Analyzer
verdiDockWidgetHide -dock windowDock_OneSearch
verdiDockWidgetHide -dock widgetDock_<Message>
propRstSetTab -waveformStat
AssertStatistics -waveformStatistics -selectCell \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} Cover WaveformFile 
AssertStatistics -options -filterAll on
AssertStatistics -waveformStatistics -addSignal
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
AssertStatistics -propDetails -expand \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} {asyn_fifo_tb.FIFO.CONTINUOUS_16_WRITE}  
wvGoToTime -win $_nWave2 1300
AssertStatistics -propDetails -collapse \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} {asyn_fifo_tb.FIFO.CONTINUOUS_16_WRITE}  
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
AssertStatistics -propDetails -expand \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} {asyn_fifo_tb.FIFO.CONTINUOUS_16_WRITE}  
wvGoToTime -win $_nWave2 1300
AssertStatistics -propDetails -collapse \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} {asyn_fifo_tb.FIFO.CONTINUOUS_16_WRITE}  
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
AssertStatistics -propDetails -expand \
           {/home/ICer/mine/proj/asyn_fifo/sim/read_fast_test.fsdb} {asyn_fifo_tb.FIFO.CONTINUOUS_16_WRITE}  
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
wvGoToTime -win $_nWave2 1300
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvGoToTime -win $_nWave2 1300
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
debExit
