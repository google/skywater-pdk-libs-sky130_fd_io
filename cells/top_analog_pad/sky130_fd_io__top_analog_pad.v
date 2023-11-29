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

`ifndef SKY130_FD_IO__TOP_ANALOG_PAD_V
`define SKY130_FD_IO__TOP_ANALOG_PAD_V

/**
 * top_analog_pad:  Analog Pad.
 *
 * Verilog top module.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_analog_pad (amuxbus_a, amuxbus_b, pad, pad_core 
`ifdef USE_POWER_PINS
		   	   ,vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch
`endif	
    );	

    inout amuxbus_a;
    inout amuxbus_b;
    inout pad;
    inout pad_core;
    
`ifdef USE_POWER_PINS    
    
    inout vccd;
    inout vcchib;
    inout vdda;
    inout vddio;
    inout vddio_q;
    inout vssa;
    inout vssd;
    inout vssio;
    inout vssio_q;
    inout vswitch;
    wire pwr_good = vddio===1 && vssio===0;

`else
    
    supply1 vccd;
    supply1 vcchib;
    supply1 vdda;
    supply1 vddio;
    supply1 vddio_q;
    supply0 vssa;
    supply0 vssd;
    supply0 vssio;
    supply0 vssio_q;
    supply1 vswitch;
    wire pwr_good = 1;

`endif    
   
    wire pad_sw = pwr_good===1 ? 1'b1 : 1'bx;
    
    tranif1 x_pad (pad, pad_core, pad_sw); 
    

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_ANALOG_PAD_V
