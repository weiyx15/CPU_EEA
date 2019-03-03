@echo off
set xv_path=D:\\Vivado2017\\Vivado\\2017.1\\bin
call %xv_path%/xsim CPU_BB_tb_behav -key {Behavioral:sim_1:Functional:CPU_BB_tb} -tclbatch CPU_BB_tb.tcl -view E:/VivadoProjects/Ex1/CPU_C/CPU_BB_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
