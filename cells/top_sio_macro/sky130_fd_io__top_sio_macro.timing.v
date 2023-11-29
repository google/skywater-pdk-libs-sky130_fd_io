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
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
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
specify
    if ( VTRIP_SEL[1]==1'b1)  ( INP_DIS[1]    => IN[1] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[1]==1'b1)  ( INP_DIS[1]    => IN_H[1] )    =  (3.271:0:3.271 , 2.210:0:2.210);
    if ( VTRIP_SEL[1]==1'b1)  ( PAD[1]        => IN[1] )      =  (0.798:0:0.798 , 0.959:0:0.959);
    if ( VTRIP_SEL[1]==1'b1)  ( PAD[1]        => IN_H[1] )    =  (0.931:0:0.931 , 0.935:0:0.935);
    if ( VTRIP_SEL[0]==1'b1)  ( INP_DIS[0]    => IN[0]  )     =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[0]==1'b1)  ( INP_DIS[0]    => IN_H[0] )    =  (3.271:0:3.271 , 2.210:0:2.210);
    if ( VTRIP_SEL[0]==1'b1)  ( PAD[0]        => IN[0] )      =  (0.798:0:0.798 , 0.959:0:0.959);
    if ( VTRIP_SEL[0]==1'b1)  ( PAD[0]        => IN_H[0] )    =  (0.931:0:0.931 , 0.935:0:0.935);
    if ( VTRIP_SEL[1]==1'b0)  ( INP_DIS[1]    => IN[1] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[1]==1'b0)  ( INP_DIS[1]    => IN_H[1] )    =  (3.271:0:3.271 , 2.209:0:2.209);
    if ( VTRIP_SEL[1]==1'b0)  ( PAD[1]        => IN[1] )      =  (0.816:0:0.816 , 0.866:0:0.866);
    if ( VTRIP_SEL[1]==1'b0)  ( PAD[1]        => IN_H[1] )    =  (0.950:0:0.950 , 0.841:0:0.841);
    if ( VTRIP_SEL[0]==1'b0)  ( INP_DIS[0]    => IN[0] )      =  (3.422:0:3.422 , 2.337:0:2.337);
    if ( VTRIP_SEL[0]==1'b0)  ( INP_DIS[0]    => IN_H[0] )    =  (3.271:0:3.271 , 2.209:0:2.209);
    if ( VTRIP_SEL[0]==1'b0)  ( PAD[0]        => IN[0] )      =  (0.816:0:0.816 , 0.866:0:0.866);
    if ( VTRIP_SEL[0]==1'b0)  ( PAD[0]        => IN_H[0] )    =  (0.950:0:0.950 , 0.841:0:0.841);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 ) 				( OE_N[0]	=> PAD[0] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b0 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b0 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b0 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b0 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM0[2] == 1'b1 & DM0[1] == 1'b1 & DM0[0] == 1'b1 & SLOW[0] == 1'b1 & OE_N[0] == 1'b0 ) 	( OUT[0]	=> PAD[0] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 ) 				( OE_N[1]	=> PAD[1] ) 	=  (0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0 , 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b0 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b0 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b0 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b0 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    if ( DM1[2] == 1'b1 & DM1[1] == 1'b1 & DM1[0] == 1'b1 & SLOW[1] == 1'b1 & OE_N[1] == 1'b0 ) 	( OUT[1]	=> PAD[1] ) 	=  (0:0:0, 0:0:0);
    specparam t_setup=5;
    specparam t_hold=5;
    $width  (posedge HLD_H_N[1], 	(15.500:0:15.500));
    $width  (negedge HLD_H_N[1], 	(15.500:0:15.500));
    $width  (negedge HLD_H_N[0], 	(15.500:0:15.500));
    $width  (posedge HLD_H_N[0], 	(15.500:0:15.500));
    $width  (posedge HLD_H_N_REFGEN, 	(15.500:0:15.500));
    $width  (negedge HLD_H_N_REFGEN, 	(15.500:0:15.500));
    $width  (negedge HLD_OVR[1], 	(15.500:0:15.500));
    $width  (posedge HLD_OVR[1], 	(15.500:0:15.500));
    $width  (negedge HLD_OVR[0], 	(15.500:0:15.500));
    $width  (posedge HLD_OVR[0], 	(15.500:0:15.500));
    $setuphold (negedge ENABLE_H,    posedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (negedge ENABLE_H,    negedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (posedge ENABLE_H,    posedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (posedge ENABLE_H,    negedge HLD_H_N_REFGEN,	t_setup, t_hold,  notifier_enable_h_refgen);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[0],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[1],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[0],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[1],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, posedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge HLD_H_N_REFGEN, negedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VTRIP_SEL_REFGEN,  	t_setup, t_hold,  notifier_vtrip_sel_refgen, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREG_EN_REFGEN,    	t_setup, t_hold,  notifier_vreg_en_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge IBUF_SEL_REFGEN,   	t_setup, t_hold,  notifier_ibuf_sel_refgen,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel,	   	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[0],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VREF_SEL[1],   		t_setup, t_hold,  notifier_vref_sel_int, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[0],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[1],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[0],  		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[1],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge VOH_SEL[2],   		t_setup, t_hold,  notifier_voh_sel,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, posedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (posedge HLD_H_N_REFGEN, negedge DFT_REFGEN,   		t_setup, t_hold,  notifier_dft_refgen,	 	enable_vdda_h_and_enable_h==1'b1, enable_vdda_h_and_enable_h==1'b1);
    $setuphold (negedge ENABLE_H,   posedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (negedge ENABLE_H,   negedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (posedge ENABLE_H,   posedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (posedge ENABLE_H,   negedge HLD_H_N[0],    t_setup, t_hold,  	notifier_enable_h_0);
    $setuphold (negedge HLD_H_N[0], posedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[1],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[1],        t_setup, t_hold,  	notifier_dm_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], posedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[0], negedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge HLD_OVR[0],    t_setup, t_hold,	notifier_hld_ovr_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[2],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[1],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[1],        t_setup, t_hold,  	notifier_dm_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge DM0[0],        t_setup, t_hold,  	notifier_dm_0, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge INP_DIS[0],    t_setup, t_hold,	notifier_inp_dis_0,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge VTRIP_SEL[0],  t_setup, t_hold,	notifier_vtrip_sel_0, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge SLOW[0],       t_setup, t_hold,	notifier_slow_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge OE_N[0],       t_setup, t_hold,	notifier_oe_n_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge OUT[0],        t_setup, t_hold,	notifier_out_0,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge VREG_EN[0],    t_setup, t_hold,	notifier_vreg_en_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], posedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[0], negedge IBUF_SEL[0],   t_setup, t_hold,	notifier_ibuf_sel_0,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge ENABLE_H,   posedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (negedge ENABLE_H,   negedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (posedge ENABLE_H,   posedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (posedge ENABLE_H,   negedge HLD_H_N[1],    t_setup, t_hold,  	notifier_enable_h_1);
    $setuphold (negedge HLD_H_N[1], posedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[1],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[1],        t_setup, t_hold,  	notifier_dm_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], posedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (negedge HLD_H_N[1], negedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge HLD_OVR[1],    t_setup, t_hold,	notifier_hld_ovr_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[2],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[1],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[1],        t_setup, t_hold,  	notifier_dm_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge DM1[0],        t_setup, t_hold,  	notifier_dm_1, 		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge INP_DIS[1],    t_setup, t_hold,	notifier_inp_dis_1,   	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge VTRIP_SEL[1],  t_setup, t_hold,	notifier_vtrip_sel_1, 	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge SLOW[1],       t_setup, t_hold,	notifier_slow_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge OE_N[1],       t_setup, t_hold,	notifier_oe_n_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge OUT[1],        t_setup, t_hold,	notifier_out_1,		ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge VREG_EN[1],    t_setup, t_hold,	notifier_vreg_en_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], posedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
    $setuphold (posedge HLD_H_N[1], negedge IBUF_SEL[1],   t_setup, t_hold,	notifier_ibuf_sel_1,	ENABLE_H==1'b1, ENABLE_H==1'b1);
endspecify
assign REFGEN.NOTIFIER_ENABLE_H 	= notifier_enable_h_refgen;
assign REFGEN.NOTIFIER_VTRIP_SEL	= notifier_vtrip_sel_refgen;
assign REFGEN.NOTIFIER_VREG_EN 		= notifier_vreg_en_refgen;
assign REFGEN.NOTIFIER_IBUF_SEL		= notifier_ibuf_sel_refgen;
assign REFGEN.notifier_vref_sel		= notifier_vref_sel;
assign REFGEN.notifier_vref_sel_int	= notifier_vref_sel_int;
assign REFGEN.notifier_voh_sel		= notifier_voh_sel;
assign REFGEN.notifier_dft_refgen 	= notifier_dft_refgen;
assign SIO_PAIR_0_.NOTIFIER_ENABLE_H 	= notifier_enable_h_0;
assign SIO_PAIR_0_.NOTIFIER_HLD_OVR	= notifier_hld_ovr_0;
assign SIO_PAIR_0_.NOTIFIER_DM 		= notifier_dm_0;
assign SIO_PAIR_0_.NOTIFIER_INP_DIS 	= notifier_inp_dis_0;
assign SIO_PAIR_0_.NOTIFIER_VTRIP_SEL 	= notifier_vtrip_sel_0;
assign SIO_PAIR_0_.NOTIFIER_SLOW 	= notifier_slow_0;
assign SIO_PAIR_0_.NOTIFIER_OE_N	= notifier_oe_n_0;
assign SIO_PAIR_0_.NOTIFIER_OUT 	= notifier_out_0;
assign SIO_PAIR_0_.NOTIFIER_VREG_EN 	= notifier_vreg_en_0;
assign SIO_PAIR_0_.NOTIFIER_IBUF_SEL 	= notifier_ibuf_sel_0;
assign SIO_PAIR_1_.NOTIFIER_ENABLE_H 	= notifier_enable_h_1;
assign SIO_PAIR_1_.NOTIFIER_HLD_OVR	= notifier_hld_ovr_1;
assign SIO_PAIR_1_.NOTIFIER_DM 		= notifier_dm_1;
assign SIO_PAIR_1_.NOTIFIER_INP_DIS 	= notifier_inp_dis_1;
assign SIO_PAIR_1_.NOTIFIER_VTRIP_SEL 	= notifier_vtrip_sel_1;
assign SIO_PAIR_1_.NOTIFIER_SLOW 	= notifier_slow_1;
assign SIO_PAIR_1_.NOTIFIER_OE_N	= notifier_oe_n_1;
assign SIO_PAIR_1_.NOTIFIER_OUT 	= notifier_out_1;
assign SIO_PAIR_1_.NOTIFIER_VREG_EN 	= notifier_vreg_en_1;
assign SIO_PAIR_1_.NOTIFIER_IBUF_SEL 	= notifier_ibuf_sel_1;
sky130_fd_io__top_refgen_new REFGEN (
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
