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

`ifndef SKY130_FD_IO__TOP_LVC_B2B_V
`define SKY130_FD_IO__TOP_LVC_B2B_V

/**
 * top_lvc_b2b:  Back-to-back ground domain joining diodes, standalone
 *
 * Verilog top module.
 */

`timescale 1ns / 1ps
`default_nettype none

module sky130_fd_io__top_lvc_b2b ( 
`ifdef USE_POWER_PINS
bdy2_b2b, drn_lvc1, drn_lvc2, ogc_lvc, src_bdy_lvc1, src_bdy_lvc2, vssd
`endif	// USE_POWER_PINS
 );

`ifdef USE_POWER_PINS
  inout src_bdy_lvc1;
  inout src_bdy_lvc2;
  inout ogc_lvc;
  inout drn_lvc1;
  inout bdy2_b2b;
  inout drn_lvc2;
  inout vssd;
`else	// USE_POWER_PINS
  supply0 src_bdy_lvc1;
  supply0 src_bdy_lvc2;
  supply1 ogc_lvc;
  supply1 drn_lvc1;
  supply0 bdy2_b2b;
  supply0 vssd;
  supply1 drn_lvc2;
`endif	// USE_POWER_PINS


endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_LVC_B2B_V
