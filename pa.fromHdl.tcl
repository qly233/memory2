
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name cuncuqi1 -dir "D:/zuchengyuanli/cuncuqi_s/planAhead_run_1" -part xc7a100tfgg484-2L
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "top_RAM_B.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/RAMB.ngc}]
set hdlfile [add_files [list {ipcore_dir/RAMB.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top top_RAM_B $srcset
add_files [list {top_RAM_B.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/RAMB.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tfgg484-2L
