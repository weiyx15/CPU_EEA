@echo off
set xv_path=D:\\Vivado2017\\Vivado\\2017.1\\bin
call %xv_path%/xsim PC_tb_behav -key {Behavioral:sim_1:Functional:PC_tb} -tclbatch PC_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0