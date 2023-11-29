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

`ifndef SKY130_FD_IO__TOP_SIO_PP_BLACKBOX_V
`define SKY130_FD_IO__TOP_SIO_PP_BLACKBOX_V

/**
 * top_sio: Special I/O PAD that provides additionally a
 *          regulated output buffer and a differential input buffer.
 *          SIO cells are ONLY available IN pairs (see top_sio_macro).
 *
 * Verilog stub definition (black box with power pins).
 *
 * WARNING: This file is autogenerated, do not modify directly!
 */

`timescale 1ns / 1ps
`default_nettype none

(* blackbox *)
module sky130_fd_io__top_sio (
           IN_H         ,
           PAD_A_NOESD_H,
           PAD          ,
           DM           ,
           HLD_H_N      ,
           INP_DIS      ,
           IN           ,
           ENABLE_H     ,
           OE_N         ,
           SLOW         ,
           VTRIP_SEL    ,
           VINREF       ,
           VOUTREF      ,
           VREG_EN      ,
           IBUF_SEL     ,
           REFLEAK_BIAS ,
           PAD_A_ESD_0_H,
           TIE_LO_ESD   ,
           HLD_OVR      ,
           OUT          ,
           PAD_A_ESD_1_H,
           VSSIO        ,
           VSSIO_Q      ,
           VSSD         ,
           VCCD         ,
           VDDIO        ,
           VCCHIB       ,
           VDDIO_Q
       );

output       IN_H         ;
inout        PAD_A_NOESD_H;
inout        PAD          ;
input  [2:0] DM           ;
input        HLD_H_N      ;
input        INP_DIS      ;
output       IN           ;
input        ENABLE_H     ;
input        OE_N         ;
input        SLOW         ;
input        VTRIP_SEL    ;
input        VINREF       ;
input        VOUTREF      ;
input        VREG_EN      ;
input        IBUF_SEL     ;
input        REFLEAK_BIAS ;
inout        PAD_A_ESD_0_H;
output       TIE_LO_ESD   ;
input        HLD_OVR      ;
input        OUT          ;
inout        PAD_A_ESD_1_H;
inout        VSSIO        ;
inout        VSSIO_Q      ;
inout        VSSD         ;
inout        VCCD         ;
inout        VDDIO        ;
inout        VCCHIB       ;
inout        VDDIO_Q      ;
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_SIO_PP_BLACKBOX_V
