/**
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`ifndef SKY130_FD_IO__TOP_VREFCAPV2_V
`define SKY130_FD_IO__TOP_VREFCAPV2_V

/**
 * top_vrefcapv2: External capacitor to be connected to vrefgen block output.
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_vrefcapv2 ( amuxbus_a, amuxbus_b, cneg, cpos 
`ifdef USE_POWER_PINS
	, vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch
`endif	
	 );

`ifdef USE_POWER_PINS
  inout vssio_q;
  inout vcchib;
  inout vdda;
  inout vssa;
  inout vccd;
  inout vddio_q;
  inout vddio;
  inout vswitch;
  inout vssio;
  inout vssd;
`else 
  supply0 vssio_q;
  supply1 vcchib;
  supply1 vdda;
  supply0 vssa;
  supply1 vccd;
  supply1 vddio_q;
  supply1 vddio;
  supply1 vswitch;
  supply0 vssio;
  supply0 vssd;
`endif
  
  inout cneg;
  inout cpos;
  inout amuxbus_a;
  inout amuxbus_b;
  
//======================================================================================================================================================   

// WARNING message if cpos / cneg terminals of the capacitor are not connected externally. 

reg dis_err_msgs;
integer warning_flag_cpos, warning_flag_cneg;

event event_warning_flag_cpos, event_warning_flag_cneg;

initial
begin
  
  dis_err_msgs = 1'b1;
  warning_flag_cpos = 0;
  warning_flag_cneg = 0;
  
  `ifdef S8IOM0S8_TOP_VREFCAPV2_DIS_ERR_MSGS
  `else
    #1;
    dis_err_msgs = 1'b0;
  `endif
end

wire #100 cpos_floating = cpos===1'bz;
wire #100 cneg_floating = cneg===1'bz;

always @(cpos_floating) 
begin
  	if (!dis_err_msgs && cpos_floating===1) 
  	begin
		 $display("\n ===ERROR=== sky130_fd_io__top_vrefcapv2 :  cpos terminal is unconnected %m\n",$stime);
		 ->event_warning_flag_cpos;
	end
end

always @(cneg_floating) 
begin
  	if (!dis_err_msgs && cneg_floating===1) 
  	begin
		 $display("\n ===ERROR=== sky130_fd_io__top_vrefcapv2 :  cneg terminal is unconnected %m\n",$stime);
		 ->event_warning_flag_cneg;
	end
end


//======================================================================================================================================   
  
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_VREFCAPV2_V
