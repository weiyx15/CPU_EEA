@echo off
set xv_path=G:\\Vivado2017\\Vivado\\2017.1\\bin
call %xv_path%/xelab  -wto 0ebde9ff7c4c456aa315c0b92ef9a383 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L secureip --snapshot ALU_tb_func_synth xil_defaultlib.ALU_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
