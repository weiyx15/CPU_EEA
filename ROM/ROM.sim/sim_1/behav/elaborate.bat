@echo off
set xv_path=D:\\Vivado2017\\Vivado\\2017.1\\bin
call %xv_path%/xelab  -wto b757a567a4b847f3a25e92e10798a600 -m64 --debug typical --relax --mt 2 -L blk_mem_gen_v8_3_6 -L xil_defaultlib -L xlconstant_v1_1_3 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot ROM_tb_behav xil_defaultlib.ROM_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
