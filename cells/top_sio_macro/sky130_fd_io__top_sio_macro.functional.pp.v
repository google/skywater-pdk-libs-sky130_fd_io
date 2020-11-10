/*
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

module sky130_fd_io__top_sio_macro (
           VCCD,
           VCCHIB,
           VDDA,
           VDDIO,
           VDDIO_Q,
           VSSD,
           VSSIO,
           VSSIO_Q,
           VSWITCH,
           VSSA,
           IN,
           IN_H,
           TIE_LO_ESD,
           AMUXBUS_A,
           AMUXBUS_B,
           PAD,
           PAD_A_ESD_0_H,
           PAD_A_ESD_1_H,
           PAD_A_NOESD_H,
           VINREF_DFT,
           VOUTREF_DFT,
           DFT_REFGEN,
           DM0,
           DM1,
           HLD_H_N,
           HLD_H_N_REFGEN,
           HLD_OVR,
           IBUF_SEL,
           IBUF_SEL_REFGEN,
           INP_DIS,
           ENABLE_H,
           ENABLE_VDDA_H,
           OE_N,
           OUT,
           SLOW,
           VOH_SEL,
           VOHREF,
           VREF_SEL,
           VREG_EN,
           VREG_EN_REFGEN,
           VTRIP_SEL,
           VTRIP_SEL_REFGEN
       );
wire VOUTREF;
wire VINREF;
wire REFLEAK_BIAS;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
inout VSWITCH;
inout VSSA;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout VINREF_DFT;
inout VOUTREF_DFT;
input DFT_REFGEN;
input HLD_H_N_REFGEN;
input IBUF_SEL_REFGEN;
input ENABLE_VDDA_H;
input ENABLE_H;
input VOHREF;
input VREG_EN_REFGEN;
input VTRIP_SEL_REFGEN;
output [1:0]  TIE_LO_ESD;
output [1:0]  IN_H;
output [1:0]  IN;
inout [1:0]  PAD_A_NOESD_H;
inout [1:0]  PAD;
inout [1:0]  PAD_A_ESD_1_H;
inout [1:0]  PAD_A_ESD_0_H;
input [1:0]  SLOW;
input [1:0]  VTRIP_SEL;
input [1:0]  HLD_H_N;
input [1:0]  VREG_EN;
input [2:0]  VOH_SEL;
input [1:0]  INP_DIS;
input [1:0]  HLD_OVR;
input [1:0]  OE_N;
input [1:0]  VREF_SEL;
input [1:0]  IBUF_SEL;
input [2:0]  DM0;
input [2:0]  DM1;
input [1:0]  OUT;
reg 	notifier_enable_h_refgen,
     notifier_vtrip_sel_refgen,
     notifier_vreg_en_refgen,
     notifier_ibuf_sel_refgen,
     notifier_vref_sel,
     notifier_vref_sel_int,
     notifier_voh_sel,
     notifier_dft_refgen;
reg	 notifier_enable_h_0;
reg	 notifier_hld_ovr_0;
reg	 notifier_dm_0;
reg	 notifier_inp_dis_0;
reg	 notifier_vtrip_sel_0;
reg	 notifier_slow_0;
reg	 notifier_oe_n_0;
reg	 notifier_out_0;
reg	 notifier_vreg_en_0;
reg	 notifier_ibuf_sel_0;
reg	 notifier_enable_h_1;
reg	 notifier_hld_ovr_1;
reg	 notifier_dm_1;
reg	 notifier_inp_dis_1;
reg	 notifier_vtrip_sel_1;
reg	 notifier_slow_1;
reg	 notifier_oe_n_1;
reg	 notifier_out_1;
reg	 notifier_vreg_en_1;
reg	 notifier_ibuf_sel_1;
wire enable_vdda_h_and_enable_h = ENABLE_VDDA_H==1'b1 && ENABLE_H==1'b1;
sky130_fd_io__top_refgen_new REFGEN (
                                 .VSWITCH                                      (VSWITCH),
                                 .VSSIO_Q                                      (VSSIO_Q),
                                 .VDDIO_Q                                      (VDDIO_Q),
                                 .VSSIO                                        (VSSIO),
                                 .VSSD                                         (VSSD),
                                 .VCCHIB                                       (VCCHIB),
                                 .VDDIO                                        (VDDIO),
                                 .VCCD                                         (VCCD),
                                 .VDDA                                         (VDDA),
                                 .VSSA					  (VSSA),
                                 .VOH_SEL                                      (VOH_SEL[2:0]),
                                 .VREF_SEL                                     (VREF_SEL[1:0]),
                                 .VOHREF                                       (VOHREF),
                                 .VINREF_DFT                                   (VINREF_DFT),
                                 .VOUTREF_DFT                                  (VOUTREF_DFT),
                                 .DFT_REFGEN                                   (DFT_REFGEN),
                                 .AMUXBUS_A                                    (AMUXBUS_A),
                                 .AMUXBUS_B                                    (AMUXBUS_B),
                                 .VOUTREF                                      (VOUTREF),
                                 .VREG_EN                                      (VREG_EN_REFGEN),
                                 .IBUF_SEL                                     (IBUF_SEL_REFGEN),
                                 .VINREF                                       (VINREF),
                                 .VTRIP_SEL                                    (VTRIP_SEL_REFGEN),
                                 .ENABLE_H					  (ENABLE_H),
                                 .ENABLE_VDDA_H				  (ENABLE_VDDA_H),
                                 .HLD_H_N                                      (HLD_H_N_REFGEN),
                                 .REFLEAK_BIAS                                 (REFLEAK_BIAS)
                             );
sky130_fd_io__top_sio SIO_PAIR_1_ (
                          .VDDIO                                        (VDDIO),
                          .VCCD                                         (VCCD),
                          .VDDIO_Q                                      (VDDIO_Q),
                          .VCCHIB                                       (VCCHIB),
                          .VSSIO                                        (VSSIO),
                          .VSSIO_Q                                      (VSSIO_Q),
                          .VSSD                                         (VSSD),
                          .PAD                                          (PAD[1]),
                          .IN_H                                         (IN_H[1]),
                          .DM                                           (DM1[2:0]),
                          .HLD_H_N                                      (HLD_H_N[1]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[1]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[1]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[1]),
                          .OE_N                                         (OE_N[1]),
                          .SLOW                                         (SLOW[1]),
                          .VTRIP_SEL                                    (VTRIP_SEL[1]),
                          .INP_DIS                                      (INP_DIS[1]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[1]),
                          .IN                                           (IN[1]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[1]),
                          .VREG_EN                                      (VREG_EN[1]),
                          .IBUF_SEL                                     (IBUF_SEL[1]),
                          .HLD_OVR                                      (HLD_OVR[1])
                      );
sky130_fd_io__top_sio SIO_PAIR_0_ (
                          .VDDIO                                        (VDDIO),
                          .VCCD                                         (VCCD),
                          .VDDIO_Q                                      (VDDIO_Q),
                          .VCCHIB                                       (VCCHIB),
                          .VSSIO                                        (VSSIO),
                          .VSSIO_Q                                      (VSSIO_Q),
                          .VSSD                                         (VSSD),
                          .PAD                                          (PAD[0]),
                          .IN_H                                         (IN_H[0]),
                          .DM                                           (DM0[2:0]),
                          .HLD_H_N                                      (HLD_H_N[0]),
                          .PAD_A_ESD_1_H                                (PAD_A_ESD_1_H[0]),
                          .PAD_A_ESD_0_H                                (PAD_A_ESD_0_H[0]),
                          .ENABLE_H                                     (ENABLE_H),
                          .OUT                                          (OUT[0]),
                          .OE_N                                         (OE_N[0]),
                          .SLOW                                         (SLOW[0]),
                          .VTRIP_SEL                                    (VTRIP_SEL[0]),
                          .INP_DIS                                      (INP_DIS[0]),
                          .TIE_LO_ESD                                   (TIE_LO_ESD[0]),
                          .IN                                           (IN[0]),
                          .VINREF                                       (VINREF),
                          .VOUTREF                                      (VOUTREF),
                          .REFLEAK_BIAS                                 (REFLEAK_BIAS),
                          .PAD_A_NOESD_H                                (PAD_A_NOESD_H[0]),
                          .VREG_EN                                      (VREG_EN[0]),
                          .IBUF_SEL                                     (IBUF_SEL[0]),
                          .HLD_OVR                                      (HLD_OVR[0])
                      );
endmodule
