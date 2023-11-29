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

`ifndef SKY130_FD_IO__TOP_PWRDETV2_V
`define SKY130_FD_IO__TOP_PWRDETV2_V

/**
 * top_pwrdetv2: vddd and vddio power detectors.
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_pwrdetv2 (out1_vddd_hv, out1_vddio_hv, out2_vddd_hv, 
           out2_vddio_hv, out3_vddd_hv, out3_vddio_hv, tie_lo_esd, 
           vddd_present_vddio_hv, vddio_present_vddd_hv, 
`ifdef USE_POWER_PINS	   
	   vccd, vddd1, vddd2, vddio_q, vssa, vssd, vssio_q, 
`endif
           in1_vddd_hv, in1_vddio_hv, in2_vddd_hv, in2_vddio_hv, in3_vddd_hv, in3_vddio_hv ,rst_por_hv_n);
    output out1_vddd_hv;
    output out1_vddio_hv;
    output out2_vddd_hv;
    output out2_vddio_hv;
    output out3_vddd_hv;
    output out3_vddio_hv;
    output tie_lo_esd;
    output vddd_present_vddio_hv;
    output vddio_present_vddd_hv;
    
`ifdef USE_POWER_PINS
    inout vccd;
    inout vddd1;
    inout vddd2;
    inout vddio_q;
    inout vssa;
    inout vssd;
    inout vssio_q;
`else
    supply1 vccd;
    supply1 vddd1;
    supply1 vddd2;
    supply1 vddio_q;
    supply0 vssa;
    supply0 vssd;
    supply0 vssio_q;
`endif
    input in1_vddd_hv;
    input in1_vddio_hv;
    input in2_vddd_hv;
    input in2_vddio_hv;
    input in3_vddd_hv;
    input in3_vddio_hv;
    input rst_por_hv_n;



`ifdef S8IOM0S8_TOP_PWRDETV2_DISABLE_STARTUP_DELAY
	parameter STARTUP_DELAY = 0;
`else
	parameter STARTUP_DELAY = 2000;
`endif

// AC_SPEC # FOR DELAY from BROS : AC.DET.3 and AC.DET.4  (in 001-70428_0J_HardIP_Tables -> HardIP_AC_Specs_ProdTest)


integer startup_delay;

initial startup_delay = STARTUP_DELAY;

//===================================================================================================================================================================

// 1. VDDIO_PRESENT_VDDD_HV

`ifdef USE_POWER_PINS
	wire pwr_good_vddio_present_vddd_hv    	=  (vddd1===1) && (vssa===0) && (vssd===0);
						   
	wire x_on_vddio_present_vddd_hv	=  pwr_good_vddio_present_vddd_hv===0 || ^rst_por_hv_n===1'bx || ^vddio_q===1'bx; 
	
	assign vddio_present_vddd_hv 	= x_on_vddio_present_vddd_hv===1 ? 1'bx : ((rst_por_hv_n===0 && vccd===0 && vddio_q===0) ? 1'b0 : vddio_q); 

`else

	assign vddio_present_vddd_hv = ^rst_por_hv_n===1'bx ? 1'bx : 1'b1;

`endif


				
// 2. OUT1_VDDD_HV, OUT2_VDDD_HV, OUT3_VDDD_HV


assign  out1_vddd_hv	=   vddio_present_vddd_hv && in1_vddio_hv;


assign  out2_vddd_hv	=   vddio_present_vddd_hv && in2_vddio_hv;


assign  out3_vddd_hv	=   vddio_present_vddd_hv && in3_vddio_hv;


//===================================================================================================================================================================

// 3. VDDD_PRESENT_VDDIO_HV

`ifdef USE_POWER_PINS
	wire pwr_good_vddd_present_vddio_hv    	=  (vddio_q===1) && (vssa===0) && (vssio_q===0);
	
	wire x_on_vddd_present_vddio_hv 	=  (pwr_good_vddd_present_vddio_hv===0) || (^vddd2===1'bx);
	
	wire vddd_present_vddio_hv_buf		=   x_on_vddd_present_vddio_hv===1 ? 1'bx : vddd2;
	
	assign #(startup_delay,startup_delay,0) vddd_present_vddio_hv	=   vddd_present_vddio_hv_buf;

`else
	assign vddd_present_vddio_hv  	=  1;
`endif



// 4. OUT1_VDDIO_HV, OUT2_VDDIO_HV, OUT3_VDDIO_HV


assign  out1_vddio_hv	=    (vddd_present_vddio_hv && in1_vddd_hv);


assign  out2_vddio_hv	=    (vddd_present_vddio_hv && in2_vddd_hv);


assign  out3_vddio_hv	=    (vddd_present_vddio_hv && in3_vddd_hv);

//===================================================================================================================================================================

// 5. TIE_LO_ESD

assign tie_lo_esd = vssd;

//===================================================================================================================================================================
// WARNING CONDITIONS


reg dis_err_msgs;

initial
begin
  dis_err_msgs = 1'b1;
  `ifdef S8IOM0S8_TOP_PWRDETV2_DIS_ERR_MSGS
  `else
    #1;
    dis_err_msgs = 1'b0;
  `endif
end

event event_warning_unreliable_output;

wire #(100) warning_unreliable_output = rst_por_hv_n===1 && vccd!==1 && vddio_q===0;

always @(warning_unreliable_output) 
begin
  if (!dis_err_msgs) 
  begin
    	if (warning_unreliable_output===1)
	begin
		$display("\n ===WARNING=== sky130_fd_io__top_pwrdetv2 :  rst_por_hv_n===1 && vccd!==1 && vddio_q===0 : In this state, the vddio detector output may be unreliable: %m\n",$stime);
		->event_warning_unreliable_output;		
	end
  end
end

//=========================================================================================================================================

`ifdef FUNCTIONAL 

`else	// FUNCTIONAL

 specify
 	(in1_vddio_hv	=> out1_vddd_hv) =  (0:0:0 , 0:0:0);
 	(in2_vddio_hv	=> out2_vddd_hv) =  (0:0:0 , 0:0:0);
 	(in3_vddio_hv	=> out3_vddd_hv) =  (0:0:0 , 0:0:0);

	(in1_vddd_hv	=> out1_vddio_hv) =  (0:0:0 , 0:0:0);
 	(in2_vddd_hv	=> out2_vddio_hv) =  (0:0:0 , 0:0:0);
 	(in3_vddd_hv	=> out3_vddio_hv) =  (0:0:0 , 0:0:0);

	$width  (negedge rst_por_hv_n,	      (0:0:0));
 endspecify
 
`endif	// FUNCTIONAL

 
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_PWRDETV2_V
