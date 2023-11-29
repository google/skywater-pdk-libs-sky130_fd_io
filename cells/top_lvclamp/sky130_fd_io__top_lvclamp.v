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

`ifndef SKY130_FD_IO__TOP_LVCLAMP_V
`define SKY130_FD_IO__TOP_LVCLAMP_V

/**
 * top_lvclamp:  Standalone low-voltage ESD clamp circuit.
 *
 * Verilog top module.
 */

`timescale 1ns / 1ps
`default_nettype none


module sky130_fd_io__top_lvclamp (
`ifdef USE_POWER_PINS
 drn_lvc, ogc_lvc, src_bdy_lvc
`endif 
 );

`ifdef USE_POWER_PINS
    inout drn_lvc;
    inout ogc_lvc;
    inout src_bdy_lvc;
`else
  supply1 ogc_lvc;
  supply1 drn_lvc;
  supply0 src_bdy_lvc;
`endif

endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_LVCLAMP_V
