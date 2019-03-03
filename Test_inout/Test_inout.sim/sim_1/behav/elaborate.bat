@echo off
set xv_path=D:\\Vivado2017\\Vivado\\2017.1\\bin
call %xv_path%/xelab  -wto 033c45c23cab449ca584dd8a411a912e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot DRAM_tb_behav xil_defaultlib.DRAM_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0