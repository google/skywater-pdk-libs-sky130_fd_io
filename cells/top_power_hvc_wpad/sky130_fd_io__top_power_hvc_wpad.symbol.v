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

`ifndef SKY130_FD_IO__TOP_POWER_HVC_WPAD_SYMBOL_V
`define SKY130_FD_IO__TOP_POWER_HVC_WPAD_SYMBOL_V

/**
 * top_power_hvc_wpad: A power pad with an ESD high-voltage clamp.
 *
 * Verilog stub (without power pins) for graphical symbol definition
 * generation.
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

(* blackbox *)
module sky130_fd_io__top_power_hvc_wpad (
           //# {{data|Data Signals}}
           inout P_PAD    ,

           //# {{control|Control Signals}}
           inout AMUXBUS_A,
           inout AMUXBUS_B
       );

// Voltage supply signals
supply1 OGC_HVC    ;
supply1 DRN_HVC    ;
supply0 SRC_BDY_HVC;
supply1 P_CORE     ;
supply1 VDDIO      ;
supply1 VDDIO_Q    ;
supply1 VDDA       ;
supply1 VCCD       ;
supply1 VSWITCH    ;
supply1 VCCHIB     ;
supply0 VSSA       ;
supply0 VSSD       ;
supply0 VSSIO_Q    ;
supply0 VSSIO      ;

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_POWER_HVC_WPAD_SYMBOL_V