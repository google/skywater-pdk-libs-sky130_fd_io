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

`ifndef SKY130_FD_IO__TOP_GPIOVREFV2_V
`define SKY130_FD_IO__TOP_GPIOVREFV2_V

/**
 * top_gpiovrefv2: Voltage Reference generator for GPIO_OVTV2 block
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_gpiovrefv2 ( amuxbus_a, amuxbus_b, 
`ifdef USE_POWER_PINS
    vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch, 
`endif    
    enable_h, hld_h_n, ref_sel, vrefgen_en, vinref );

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
  wire pwr_good_active_mode = (vddio_q===1) && (vssd===0) && (vcchib===1);
  wire pwr_good_hold_mode   = (vddio_q===1) && (vssd===0);

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
  
  wire pwr_good_active_mode = 1;
  wire pwr_good_hold_mode   = 1;
  
`endif  
  
  inout amuxbus_a;
  inout amuxbus_b;
  input vrefgen_en;
  input  [4:0] ref_sel;
  input enable_h;
  input hld_h_n;
  inout vinref;


reg notifier_ref_sel,  notifier_vrefgen_en;
reg notifier_enable_h;

wire [4:0] ref_sel_buf;
wire vrefgen_en_buf, hld_h_n_buf;

wire [4:0] ref_sel_del;
wire vrefgen_en_del, hld_h_n_del;


`ifdef S8IOM0S8_TOP_GPIOVREFV2_DISABLE_STARTUP_DELAY
	parameter STARTUP_DELAY = 0;
`else
	parameter STARTUP_DELAY = 24000;
`endif
// AC_SPEC # FOR STARTUP_DELAY from BROS :  (in 001-70428_0N_HardIP_Tables -> HardIP_AC_Specs_ProdTest -> AC.VREFV2.1)


integer startup_delay;

initial startup_delay = STARTUP_DELAY;

//===================================================================================================================================

// Timing section

`ifdef FUNCTIONAL
	assign ref_sel_buf	= ref_sel;
	assign vrefgen_en_buf	= vrefgen_en;
	assign hld_h_n_buf	= hld_h_n;
`else
	assign ref_sel_buf	= ref_sel_del;
	assign vrefgen_en_buf	= vrefgen_en_del;	
	assign hld_h_n_buf	= hld_h_n_del;

specify
 
       
    $width  (negedge hld_h_n,	      (15.500:0:15.500));
    $width  (posedge hld_h_n,	      (15.500:0:15.500));
   
    specparam tsetup = 5;
    specparam thold = 5;

    $setuphold (posedge enable_h,    negedge hld_h_n,    tsetup, thold,  notifier_enable_h); 
      
    $setuphold (negedge hld_h_n, posedge ref_sel[4],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[4]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[4],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[4]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[3],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[3]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[3],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[3]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[2],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[2]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[2],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[2]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[1],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[1]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[1],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[1]); 
    $setuphold (negedge hld_h_n, posedge ref_sel[0],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[0]); 
    $setuphold (negedge hld_h_n, negedge ref_sel[0],   tsetup, thold,  notifier_ref_sel,   enable_h==1'b1, enable_h==1'b1, hld_h_n_del, ref_sel_del[0]); 
    $setuphold (negedge hld_h_n, posedge vrefgen_en,   tsetup, thold,  notifier_vrefgen_en,enable_h==1'b1, enable_h==1'b1, hld_h_n_del, vrefgen_en_del); 
    $setuphold (negedge hld_h_n, negedge vrefgen_en,   tsetup, thold,  notifier_vrefgen_en,enable_h==1'b1, enable_h==1'b1, hld_h_n_del, vrefgen_en_del); 
 endspecify

`endif

//===================================================================================================================================

// Level-shifted latchin of ref_sel[4:0], vrefgen_en

  
reg [4:0] ref_sel_final; 
always @(*)
begin : LATCH_ref_sel
	
	
		
	if (^enable_h===1'bx || !pwr_good_hold_mode || (enable_h===1 && ^hld_h_n_buf===1'bx))
	begin	
		ref_sel_final 	<= 5'bxxxxx;
	end
	else if (enable_h===0)
	begin
		ref_sel_final 	<= 5'b00000;
	end
	else if (hld_h_n_buf===1)
	begin
		ref_sel_final 	<= (^ref_sel_buf[4:0]	=== 1'bx	|| !pwr_good_active_mode) ? 5'bxxxxx : ref_sel_buf;
	end
end

always @(notifier_enable_h or notifier_ref_sel)
begin
     disable LATCH_ref_sel; ref_sel_final <= 5'bxxxxx;
end


reg vrefgen_en_final;
always @(*)
begin : LATCH_vrefgen_en	
	
	
	
	if (^enable_h===1'bx || !pwr_good_hold_mode || (enable_h===1 && ^hld_h_n_buf===1'bx))
	begin
		vrefgen_en_final 	<= 1'bx;
	end
	else if (enable_h===0)
	begin
		vrefgen_en_final 	<= 1'b0;
	end
	else if (hld_h_n_buf===1)
	begin
		vrefgen_en_final 	<= (^vrefgen_en_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vrefgen_en_buf;
	end
end

always @(notifier_enable_h or notifier_vrefgen_en)
begin
     disable LATCH_vrefgen_en; vrefgen_en_final <= 1'bx;
end


//===================================================================================================================================

// Output functionality

// pwr_good check is already contained in *_final (latched) signals

wire x_on_vinref =   	 vrefgen_en_final === 1'bx
			
			 || (vrefgen_en_final === 1'b1 && ^ref_sel_final === 1'bx);
			
			 
assign #(startup_delay,0) vinref = x_on_vinref === 1'b1 ? 1'bx : vrefgen_en_final;


//===================================================================================================================================



endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_GPIOVREFV2_V
