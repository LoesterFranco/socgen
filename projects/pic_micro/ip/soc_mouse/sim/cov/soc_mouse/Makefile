SHELL=/bin/sh
MAKE=make

VPP_NAME=vppreproc


################################################################################
# set up coverage
################################################################################



.PHONY build_cdd:
build_cdd:  
	echo "################################################################################"; \
	echo; \
	$(VPP_NAME) --noline --noblank  -DSYNTHESIS     ../../bench/verilog/TestBench.cov  > soc_mouse.v ;\
	covered score -i TB.dut.pic  -t pic16c5x  -I ./ -v ./soc_mouse.v -o soc_mouse_cpu.cdd 2> soc_mouse_cpu_cov.log | tee >> soc_mouse_cpu_cov.log ;\
	covered score -i TB.dut.io_module  -t io_module_mouse  -I ./ -v ./soc_mouse.v -o io_module.cdd 2> io_module_cov.log | tee >> io_module_cov.log ;\
	echo "################################################################################"; \


################################################################################
# score coverage from vcd
################################################################################



.PHONY score_cov:
score_cov:  
	echo "################################################################################"; \
	echo " Scoring ${$TEST}     ";\
	covered score  -cdd pic16c5x_cpu.cdd -vcd ../../out/$(TEST).vcd  2>> cpu_sco_cov.log | tee >> cpu_sco_cov.log ;\
	covered score  -cdd io_module.cdd -vcd ../../out/$(TEST).vcd  2>> io_sco_cov.log | tee >> io_sco_cov.log ;\




################################################################################
# run coverage report
################################################################################



.PHONY report_cov:
report_cov:  
	echo "################################################################################"; \
	covered report    -cdd soc_mouse_cpu.cdd 2> cpu_rep_cov.log | tee >> cpu_rep_cov.log ;\
	covered report    -cdd io_module.cdd 2>  io_rep_cov.log | tee >>  io_rep_cov.log ;\