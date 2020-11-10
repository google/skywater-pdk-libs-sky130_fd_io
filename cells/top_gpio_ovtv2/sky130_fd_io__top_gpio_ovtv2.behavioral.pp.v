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

module sky130_fd_io__top_gpio_ovtv2 ( IN, IN_H, TIE_HI_ESD, TIE_LO_ESD, AMUXBUS_A,
                                      AMUXBUS_B, PAD, PAD_A_ESD_0_H, PAD_A_ESD_1_H, PAD_A_NOESD_H,
                                      VCCD, VCCHIB,VDDA, VDDIO, VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH,
                                      ANALOG_EN, ANALOG_POL, ANALOG_SEL, DM, ENABLE_H, ENABLE_INP_H, ENABLE_VDDA_H, ENABLE_VDDIO, ENABLE_VSWITCH_H, HLD_H_N,
                                      HLD_OVR, IB_MODE_SEL, INP_DIS, OE_N, OUT, SLOW, SLEW_CTL, VTRIP_SEL, HYS_TRIM, VINREF );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VDDIO;
input ENABLE_VSWITCH_H;
input INP_DIS;
input VTRIP_SEL;
input HYS_TRIM;
input SLOW;
input [1:0] SLEW_CTL;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
input [1:0] IB_MODE_SEL;
input VINREF;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
wire hld_h_n_del;
wire hld_h_n_buf;
reg [2:0] dm_final;
reg [1:0] slew_ctl_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final, hys_trim_final, analog_en_final,analog_en_vdda, analog_en_vswitch,analog_en_vddio_q;
reg [1:0] ib_mode_sel_final;
wire [2:0] dm_del;
wire [1:0] slew_ctl_del;
wire [1:0] ib_mode_sel_del;
wire slow_del, vtrip_sel_del, inp_dis_del, out_del, oe_n_del, hld_ovr_del, hys_trim_del;
wire [2:0] dm_buf;
wire [1:0] slew_ctl_buf;
wire [1:0] ib_mode_sel_buf;
wire slow_buf, vtrip_sel_buf, inp_dis_buf, out_buf, oe_n_buf, hld_ovr_buf, hys_trim_buf;
reg notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis;
reg notifier_slew_ctl, notifier_ib_mode_sel, notifier_hys_trim;
reg notifier_enable_h, notifier, dummy_notifier1;
assign hld_h_n_buf 	= hld_h_n_del;
assign hld_ovr_buf 	= hld_ovr_del;
assign dm_buf 		= dm_del;
assign inp_dis_buf 	= inp_dis_del;
assign vtrip_sel_buf 	= vtrip_sel_del;
assign slow_buf 	= slow_del;
assign oe_n_buf 	= oe_n_del;
assign out_buf 		= out_del;
assign ib_mode_sel_buf 	= ib_mode_sel_del;
assign slew_ctl_buf	= slew_ctl_del;
assign hys_trim_buf 	= hys_trim_del;
specify
    ( INP_DIS => IN) = (0:0:0 , 0:0:0);
    ( INP_DIS => IN_H) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD ) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD ) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b1 & HYS_TRIM==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b0 ) ( OUT=>  PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b1 & SLEW_CTL[0]==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OE_N => PAD ) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OE_N => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b0 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b1 & DM[1]==1'b0 & DM[0]==1'b0 & SLOW==1'b1 & SLEW_CTL[1]==1'b0 & SLEW_CTL[0]==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0, 0:0:0, 0:0:0, 0:0:0, 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b0  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b0 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN) = (0:0:0 , 0:0:0);
    if (  IB_MODE_SEL[1]==1'b0 & IB_MODE_SEL[0]==1'b0 & VTRIP_SEL==1'b1  ) ( PAD => IN_H) = (0:0:0 , 0:0:0);
    if (  OE_N==1'b0 & DM[2]==1'b0 & DM[1]==1'b1 & DM[0]==1'b1 & SLOW==1'b1 ) ( OUT => PAD) = (0:0:0 , 0:0:0);
    $width  (negedge HLD_H_N,	      (15.500:0:15.500));
    $width  (posedge HLD_H_N,	      (15.500:0:15.500));
    $width  (negedge HLD_OVR,	      (15.500:0:15.500));
    $width  (posedge HLD_OVR,	      (15.500:0:15.500));
    specparam tsetup = 5;
    specparam tsetup1 = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_H,     negedge HLD_H_N,      tsetup, thold,  notifier_enable_h);
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup1, thold,  notifier_enable_h);
    $setuphold (negedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (negedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (negedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (negedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (negedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (negedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (negedge HLD_H_N, posedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (negedge HLD_H_N, negedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (negedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (negedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (negedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (negedge HLD_H_N, posedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (negedge HLD_H_N, negedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (negedge HLD_H_N, posedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (negedge HLD_H_N, negedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (negedge HLD_H_N, posedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (negedge HLD_H_N, negedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_H_N, posedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, negedge HLD_OVR,    tsetup, thold,  notifier_hld_ovr,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hld_ovr_del);
    $setuphold (posedge HLD_H_N, posedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, negedge DM[2],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[2]);
    $setuphold (posedge HLD_H_N, posedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, negedge DM[1],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[1]);
    $setuphold (posedge HLD_H_N, posedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, negedge DM[0],      tsetup, thold,  notifier_dm,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, dm_del[0]);
    $setuphold (posedge HLD_H_N, posedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, negedge INP_DIS,    tsetup, thold,  notifier_inp_dis,   ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, inp_dis_del);
    $setuphold (posedge HLD_H_N, posedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, negedge VTRIP_SEL,  tsetup, thold,  notifier_vtrip_sel, ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, vtrip_sel_del);
    $setuphold (posedge HLD_H_N, posedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (posedge HLD_H_N, negedge HYS_TRIM,   tsetup, thold,  notifier_hys_trim,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, hys_trim_del);
    $setuphold (posedge HLD_H_N, posedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, negedge SLOW,       tsetup, thold,  notifier_slow,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slow_del);
    $setuphold (posedge HLD_H_N, posedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, negedge OE_N,       tsetup, thold,  notifier_oe_n,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, oe_n_del);
    $setuphold (posedge HLD_H_N, posedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, negedge OUT,        tsetup, thold,  notifier_out,	 ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, out_del);
    $setuphold (posedge HLD_H_N, posedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (posedge HLD_H_N, negedge SLEW_CTL[1],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[1]);
    $setuphold (posedge HLD_H_N, posedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (posedge HLD_H_N, negedge SLEW_CTL[0],   tsetup, thold,  notifier_slew_ctl,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, slew_ctl_del[0]);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL[1], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[1]);
    $setuphold (posedge HLD_H_N, posedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_H_N, negedge IB_MODE_SEL[0], tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, hld_h_n_del, ib_mode_sel_del[0]);
    $setuphold (posedge HLD_OVR,    	negedge HLD_H_N, tsetup, thold,  notifier_hld_ovr,	ENABLE_H==1'b1, ENABLE_H==1'b1, hld_ovr_del, hld_h_n_del);
    $setuphold (posedge DM[2],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[2], hld_h_n_del);
    $setuphold (posedge DM[1],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[1], hld_h_n_del);
    $setuphold (posedge DM[0],      	negedge HLD_H_N, tsetup, thold,  notifier_dm,		ENABLE_H==1'b1, ENABLE_H==1'b1, dm_del[0], hld_h_n_del);
    $setuphold (posedge INP_DIS,    	negedge HLD_H_N, tsetup, thold,  notifier_inp_dis,	ENABLE_H==1'b1, ENABLE_H==1'b1, inp_dis_del, hld_h_n_del);
    $setuphold (posedge VTRIP_SEL,  	negedge HLD_H_N, tsetup, thold,  notifier_vtrip_sel, 	ENABLE_H==1'b1, ENABLE_H==1'b1, vtrip_sel_del, hld_h_n_del);
    $setuphold (posedge HYS_TRIM,   	negedge HLD_H_N, tsetup, thold,  notifier_hys_trim,  	ENABLE_H==1'b1, ENABLE_H==1'b1, hys_trim_del, hld_h_n_del);
    $setuphold (posedge SLOW,	    	negedge HLD_H_N, tsetup, thold,  notifier_slow,		ENABLE_H==1'b1, ENABLE_H==1'b1, slow_del, hld_h_n_del);
    $setuphold (posedge OE_N,	    	negedge HLD_H_N, tsetup, thold,  notifier_oe_n,		ENABLE_H==1'b1, ENABLE_H==1'b1, oe_n_del, hld_h_n_del);
    $setuphold (posedge OUT,	    	negedge HLD_H_N, tsetup, thold,  notifier_out,		ENABLE_H==1'b1, ENABLE_H==1'b1, out_del, hld_h_n_del);
    $setuphold (posedge SLEW_CTL[1],   	negedge HLD_H_N, tsetup, thold,  notifier_slew_ctl,     ENABLE_H==1'b1, ENABLE_H==1'b1, slew_ctl_del[1], hld_h_n_del);
    $setuphold (posedge SLEW_CTL[0],   	negedge HLD_H_N, tsetup, thold,  notifier_slew_ctl,     ENABLE_H==1'b1, ENABLE_H==1'b1, slew_ctl_del[0], hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL[1], negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, ib_mode_sel_del[1], hld_h_n_del);
    $setuphold (posedge IB_MODE_SEL[0], negedge HLD_H_N, tsetup, thold,  notifier_ib_mode_sel,  ENABLE_H==1'b1, ENABLE_H==1'b1, ib_mode_sel_del[0], hld_h_n_del);
endspecify
wire  pwr_good_amux	         = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1))  && (VSSD===0) && (VSSA===0) && (VSSIO_Q===0);
wire  pwr_good_output_driver     = (VDDIO===1)   && (VDDIO_Q===1)&& (VSSIO===0)   && (VSSD===0)  && (VSSA===0) ;
wire  pwr_good_hold_ovr_mode     = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCHIB===1);
wire  pwr_good_active_mode       = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0)    && (VCCD===1);
wire  pwr_good_hold_mode         = (VDDIO_Q===1) && (VDDIO===1)  && (VSSD===0);
wire  pwr_good_active_mode_vdda  = (VDDA===1)  && (VSSD===0)   && (VCCD===1);
wire  pwr_good_hold_mode_vdda    = (VDDA===1)    && (VSSD===0);
wire  pwr_good_inpbuff_hv        = (VDDIO_Q===1) && (inp_dis_final===0 && dm_final!==3'b000 && ib_mode_sel_final===2'b01 ? VCCHIB===1 : 1) && (VSSD===0);
wire  pwr_good_inpbuff_lv        = (VDDIO_Q===1) && (VSSD===0)   && (VCCHIB===1);
wire  pwr_good_analog_en_vdda    = (VDDA===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vddio_q = (VDDIO_Q ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_analog_en_vswitch = (VSWITCH ===1)  && (VSSD===0) && (VSSA===0) ;
wire  pwr_good_amux_vccd   	 = ((hld_h_n_buf===0 || ENABLE_H===0) ? 1:(VCCD===1));
parameter MAX_WARNING_COUNT = 100;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 	&& dm_final !== 3'b001 		&& oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx 	&& oe_n_final===1'b0)
     || (slow_final===1'bx 	&& dm_final !== 3'b000		&& dm_final !== 3'b001 && oe_n_final===1'b0)
     || (slow_final===1'b1 	&& ^slew_ctl_final[1:0] ===1'bx 	&& dm_final === 3'b100 && oe_n_final===1'b0);
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLOW_BEHV
parameter SLOW_1_DELAY= 70 ;
parameter SLOW_0_DELAY= 40;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
parameter SLEW_00_DELAY= 127 ;
parameter SLEW_01_DELAY= 109;
parameter SLEW_10_DELAY= 193;
parameter SLEW_11_DELAY= 136;
`else
parameter SLEW_00_DELAY= 0 ;
parameter SLEW_01_DELAY= 0;
parameter SLEW_10_DELAY= 0;
parameter SLEW_11_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay,slew_00_delay,slew_01_delay,slew_10_delay,slew_11_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
initial slew_00_delay = SLEW_00_DELAY;
initial slew_01_delay = SLEW_01_DELAY;
initial slew_10_delay = SLEW_10_DELAY;
initial slew_11_delay = SLEW_11_DELAY;
always @(*)
begin
    if (SLOW===1)
    begin
        if (DM[2]===1 && DM[1]===0 && DM[0]===0)
        begin
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_SLEW_BEHV
            if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_00_delay;
            else if (SLEW_CTL[1] ===0 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_01_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===0)
                slow_delay = 	slew_10_delay;
            else if (SLEW_CTL[1] ===1 && SLEW_CTL[0] ===1)
                slow_delay = 	slew_11_delay;
`else
            slow_delay = slow_1_delay;
`endif
        end
        else
            slow_delay = slow_1_delay;
    end
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0) #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0) #slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)  #slow_delay dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in_hv  =  (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b01)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire x_on_in_lv  =  (ENABLE_H===0  && ^ENABLE_VDDIO===1'bx)
     || (ENABLE_H===0  && ^ENABLE_INP_H===1'bx)
     || (inp_dis_final===1'bx  && ^dm_final[2:0]!==1'bx && dm_final !== 3'b000)
     || (^ENABLE_H===1'bx)
     || (inp_dis_final===0 	       		&& ^dm_final[2:0] === 1'bx)
     || (^ib_mode_sel_final===1'bx  	&& inp_dis_final===0  		&& dm_final !== 3'b000)
     || (vtrip_sel_final===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000		&& ib_mode_sel_final===2'b00)
     || (^ENABLE_VDDIO===1'bx    		&& inp_dis_final===0        	&& dm_final !== 3'b000	)
     || (ib_mode_sel_final[1]===1'b1	&& VINREF !== 1'b1    		&& inp_dis_final===0      	&& dm_final !== 3'b000)
     || (ib_mode_sel_final[1]===1'b1	&& hys_trim_final===1'bx	&& inp_dis_final===0      	&& dm_final !== 3'b000);
wire disable_inp_buff = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_INP_H===0;
assign IN_H = (x_on_in_hv===1 || pwr_good_inpbuff_hv===0) ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
wire disable_inp_buff_lv = ENABLE_H===1 ? (dm_final===3'b000 || inp_dis_final===1) : ENABLE_VDDIO===0;
assign IN   = (x_on_in_lv ===1 || pwr_good_inpbuff_lv===0) ? 1'bx : (disable_inp_buff_lv===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign TIE_HI_ESD = VDDIO===1'b1 ? 1'b1 : 1'bx;
assign TIE_LO_ESD = VSSIO===1'b0 ? 1'b0 : 1'bx;
wire functional_mode_amux = (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_analog_en_vswitch ===1 );
wire x_on_analog_en_vdda = (pwr_good_analog_en_vdda !==1
                            || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                            || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VDDA_H ===1'bx) ));
wire zero_on_analog_en_vdda = ( (pwr_good_analog_en_vdda ===1 && ENABLE_VDDA_H ===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                || (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                ||  (pwr_good_analog_en_vdda ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vddio_q =  ( pwr_good_analog_en_vddio_q !==1
                                 || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                                 || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) ));
wire zero_on_analog_en_vddio_q =  ( (pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                    || (pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                    ||  (pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
wire x_on_analog_en_vswitch = (pwr_good_analog_en_vswitch !==1
                               || (functional_mode_amux ==1 && (ENABLE_H !==0 && ^hld_h_n_buf === 1'bx) || (hld_h_n_buf!== 0 && ^ENABLE_H=== 1'bx) || pwr_good_amux_vccd !==1 )
                               || (functional_mode_amux ==1 && (hld_h_n_buf ===1 && ENABLE_H===1 && ^ANALOG_EN === 1'bx && ENABLE_VDDA_H ===1 && ENABLE_VSWITCH_H===1 ) || (hld_h_n_buf ===1 && ENABLE_H===1 && ANALOG_EN ===0 && ^ENABLE_VSWITCH_H ===1'bx) ));
wire  zero_on_analog_en_vswitch =   ( (pwr_good_analog_en_vswitch ===1 && ENABLE_VSWITCH_H ===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && hld_h_n_buf===0)
                                      || (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && ENABLE_H===0)
                                      ||  (pwr_good_analog_en_vswitch ===1 && pwr_good_analog_en_vddio_q ===1 && pwr_good_amux_vccd && ANALOG_EN===0) );
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        dm_final 	<= 3'bxxx;
    end
    else if (ENABLE_H===0)
    begin
        dm_final 	<= 3'b000;
    end
    else if (hld_h_n_buf===1)
    begin
        dm_final 	<= (^dm_buf[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : dm_buf;
    end
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        inp_dis_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        inp_dis_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1)
    begin
        inp_dis_final 	<= (^inp_dis_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : inp_dis_buf;
    end
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_ib_mode_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        ib_mode_sel_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        ib_mode_sel_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        ib_mode_sel_final 	<= (^ib_mode_sel_buf[1:0]	=== 1'bx	|| !pwr_good_active_mode) ? 2'bxx : ib_mode_sel_buf;
    end
end
always @(notifier_enable_h or notifier_ib_mode_sel)
begin
    disable LATCH_ib_mode_sel; ib_mode_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_slew_ctl_final
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slew_ctl_final 	<= 2'bxx;
    end
    else if (ENABLE_H===0)
    begin
        slew_ctl_final 	<= 2'b00;
    end
    else if (hld_h_n_buf===1)
    begin
        slew_ctl_final 	<= (^slew_ctl_buf[1:0] === 1'bx || !pwr_good_active_mode) ? 2'bxx : slew_ctl_buf;
    end
end
always @(notifier_enable_h or notifier_slew_ctl)
begin
    disable LATCH_slew_ctl_final; slew_ctl_final <= 2'bxx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        vtrip_sel_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        vtrip_sel_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        vtrip_sel_final 	<= (^vtrip_sel_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : vtrip_sel_buf;
    end
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_hys_trim
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hys_trim_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hys_trim_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hys_trim_final 	<= (^hys_trim_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hys_trim_buf;
    end
end
always @(notifier_enable_h or notifier_hys_trim)
begin
    disable LATCH_hys_trim; hys_trim_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        slow_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        slow_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        slow_final 	<= (^slow_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : slow_buf;
    end
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^hld_h_n_buf===1'bx))
    begin
        hld_ovr_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        hld_ovr_final 	<= 1'b0;
    end
    else if (hld_h_n_buf===1)
    begin
        hld_ovr_final 	<= (^hld_ovr_buf === 1'bx	|| !pwr_good_active_mode) ? 1'bx : hld_ovr_buf;
    end
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx || (hld_h_n_buf===0 && hld_ovr_final===1'bx)|| (hld_h_n_buf===1 && hld_ovr_final===1'bx))))
    begin
        oe_n_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        oe_n_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        oe_n_final  	<= (^oe_n_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : oe_n_buf;
    end
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^hld_h_n_buf===1'bx ||(hld_h_n_buf===0 &&  hld_ovr_final===1'bx)||(hld_h_n_buf===1 &&  hld_ovr_final===1'bx))))
    begin
        out_final 	<= 1'bx;
    end
    else if (ENABLE_H===0)
    begin
        out_final 	<= 1'b1;
    end
    else if (hld_h_n_buf===1 || hld_ovr_final===1)
    begin
        out_final  	<= (^out_buf  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : out_buf;
    end
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
always @(*)
begin
    if (x_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'bx;
    end
    else if ( zero_on_analog_en_vdda ===1 )
    begin
        analog_en_vdda <= 1'b0;
    end
    else if (x_on_analog_en_vdda !==1 && zero_on_analog_en_vdda !==1)
    begin
        analog_en_vdda <= ANALOG_EN;
    end
    if (x_on_analog_en_vddio_q  ===1 )
    begin
        analog_en_vddio_q  <= 1'bx;
    end
    else if ( zero_on_analog_en_vddio_q ===1 )
    begin
        analog_en_vddio_q  <= 1'b0;
    end
    else if ( x_on_analog_en_vddio_q !==1 && zero_on_analog_en_vddio_q !==1)
    begin
        analog_en_vddio_q  <= ANALOG_EN;
    end
    if (x_on_analog_en_vswitch  ===1 )
    begin
        analog_en_vswitch  <= 1'bx;
    end
    else if ( zero_on_analog_en_vswitch ===1 )
    begin
        analog_en_vswitch  <= 1'b0;
    end
    else if (x_on_analog_en_vswitch !==1 && zero_on_analog_en_vswitch !==1)
    begin
        analog_en_vswitch  <= ANALOG_EN;
    end
    if ( (analog_en_vswitch ===1'bx && analog_en_vdda ===1'bx) || (analog_en_vswitch ===1'bx && analog_en_vddio_q ===1'bx) || (analog_en_vddio_q ===1'bx && analog_en_vdda ===1'bx ) )
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vdda ===1'bx && (analog_en_vddio_q ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vddio_q ===1'bx && (analog_en_vdda ===1 ||analog_en_vswitch===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if (analog_en_vswitch===1'bx && (analog_en_vdda ===1 || analog_en_vddio_q ===1 ))
    begin
        analog_en_final  <= 1'bx;
    end
    else if ((analog_en_vdda ===0 && analog_en_vddio_q ===0 )|| (analog_en_vdda ===0 && analog_en_vswitch===0 ) ||  (analog_en_vddio_q ===0 && analog_en_vswitch===0 ))
    begin
        analog_en_final  <=0;
    end
    else if (analog_en_vdda ===1 && analog_en_vddio_q ===1 &&  analog_en_vswitch ===1)
    begin
        analog_en_final  <=1;
    end
end
wire [2:0] amux_select = {ANALOG_SEL, ANALOG_POL, out_buf};
wire invalid_controls_amux = 	(analog_en_final===1'bx && inp_dis_final===1)
     || !pwr_good_amux
     || (analog_en_final===1 && ^amux_select[2:0] === 1'bx && inp_dis_final===1);
wire enable_pad_amuxbus_a = invalid_controls_amux  ? 1'bx : (amux_select===3'b001 || amux_select===3'b010) && (analog_en_final===1);
wire enable_pad_amuxbus_b = invalid_controls_amux  ? 1'bx : (amux_select===3'b101 || amux_select===3'b110) && (analog_en_final===1);
wire enable_pad_vssio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b100 || amux_select===3'b000) && (analog_en_final===1);
wire enable_pad_vddio_q   = invalid_controls_amux  ? 1'bx : (amux_select===3'b011 || amux_select===3'b111) && (analog_en_final===1);
tranif1 pad_amuxbus_a 	(PAD, AMUXBUS_A, enable_pad_amuxbus_a);
tranif1 pad_amuxbus_b 	(PAD, AMUXBUS_B, enable_pad_amuxbus_b);
bufif1 pad_vddio_q	(PAD, VDDIO_Q,   enable_pad_vddio_q);
bufif1 pad_vssio_q   	(PAD, VSSIO_Q,   enable_pad_vssio_q);
reg dis_err_msgs;
integer msg_count_pad,msg_count_pad1,msg_count_pad2,msg_count_pad3,msg_count_pad4,msg_count_pad5,msg_count_pad6,msg_count_pad7,msg_count_pad8,msg_count_pad9,msg_count_pad10,msg_count_pad11,msg_count_pad12;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad  = 0;
    msg_count_pad1 = 0;
    msg_count_pad2 = 0;
    msg_count_pad3 = 0;
    msg_count_pad4 = 0;
    msg_count_pad5 = 0;
    msg_count_pad6 = 0;
    msg_count_pad7 = 0;
    msg_count_pad8 = 0;
    msg_count_pad9 = 0;
    msg_count_pad10 = 0;
    msg_count_pad11 = 0;
    msg_count_pad12  = 0;
`ifdef SKY130_FD_IO_TOP_GPIO_OVTV2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
wire #100 error_enable_vddio = (ENABLE_VDDIO===0 && ENABLE_H===1);
event event_error_enable_vddio;
always @(error_enable_vddio)
begin
    if (!dis_err_msgs)
    begin
        if (error_enable_vddio===1)
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_error_enable_vddio;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 :  Enable_h (= %b) and ENABLE_VDDIO (= %b) are complement of each \other. This is an illegal combination as ENABLE_VDDIO and ENABLE_H are the same input signals IN different power \domains %m", ENABLE_H, ENABLE_VDDIO, $stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda = ( VDDA===1 && VDDIO_Q !==1 && ENABLE_VDDA_H===1 );
event event_error_vdda;
always @(error_vdda)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda===1)
        begin
            msg_count_pad1 = msg_count_pad1 + 1;
            ->event_error_vdda;
            if (msg_count_pad1 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H (= %b) cannot be 1 when VDDA (= %b) and VDDIO_Q (= %b) %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,$stime);
            end
            else
                if (msg_count_pad1 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda2 = ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  &&  VCCD===1 && ANALOG_EN ===1 );
event event_error_vdda2;
always @(error_vdda2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda2===1)
        begin
            msg_count_pad2 = msg_count_pad2 + 1;
            ->event_error_vdda2;
            if (msg_count_pad2 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b)   %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad2 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda3 =  ( VDDA===1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H===1 && hld_h_n_buf ===1  && VCCD !==1 );
event event_error_vdda3;
always @(error_vdda3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda3===1)
        begin
            msg_count_pad3 = msg_count_pad3 + 1;
            ->event_error_vdda3;
            if (msg_count_pad3 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : VCCD (= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b) and hld_h_n_buf (= %b) %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad3 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch1 =  (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && (ENABLE_VSWITCH_H===1)) ;
event event_error_vswitch1;
always @(error_vswitch1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch1===1)
        begin
            msg_count_pad4 = msg_count_pad4 + 1;
            ->event_error_vswitch1;
            if (msg_count_pad4 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad4 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch2 =   (VDDA !==1 && VDDIO_Q !==1 && VSWITCH ===1 && VCCD===1 && ANALOG_EN===1);
event event_error_vswitch2;
always @(error_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch2===1)
        begin
            msg_count_pad5 = msg_count_pad5 + 1;
            ->event_error_vswitch2;
            if (msg_count_pad5 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN (= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b)  & VCCD(= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,VCCD,$stime);
            end
            else
                if (msg_count_pad5 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch3 =   (VDDA ===1 && VDDIO_Q !==1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch3;
always @(error_vswitch3)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch3===1)
        begin
            msg_count_pad6 = msg_count_pad6 + 1;
            ->event_error_vswitch3;
            if (msg_count_pad6 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad6 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch4 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_VSWITCH_H===1);
event event_error_vswitch4;
always @(error_vswitch4)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch4===1)
        begin
            msg_count_pad7 = msg_count_pad7 + 1;
            ->event_error_vswitch4;
            if (msg_count_pad7 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) & VSWITCH(= %b) %m",ENABLE_VSWITCH_H,VDDA,VDDIO_Q,VSWITCH,$stime);
            end
            else
                if (msg_count_pad7 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vswitch5 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vswitch5;
always @(error_vswitch5)
begin
    if (!dis_err_msgs)
    begin
        if (error_vswitch5===1)
        begin
            msg_count_pad8 = msg_count_pad8 + 1;
            ->event_error_vswitch5;
            if (msg_count_pad8 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b),hld_h_n_buf (= %b) and VCCD (= %b) %m",ANALOG_EN,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad8 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q1 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD!==1);
event event_error_vddio_q1;
always @(error_vddio_q1)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q1===1)
        begin
            msg_count_pad9 = msg_count_pad9 + 1;
            ->event_error_vddio_q1;
            if (msg_count_pad9 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : VCCD(= %b) cannot be any value other than 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) and hld_h_n_buf (= %b)  %m",VCCD,VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,$stime);
            end
            else
                if (msg_count_pad9 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vddio_q2 =  (VDDA !==1 && VDDIO_Q ===1 && VSWITCH !==1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 && ANALOG_EN===1);
event event_error_vddio_q2;
always @(error_vddio_q2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vddio_q2===1)
        begin
            msg_count_pad10 = msg_count_pad10 + 1;
            ->event_error_vddio_q2;
            if (msg_count_pad10 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ANALOG_EN(= %b) cannot be 1 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b),ENABLE_H (= %b) , hld_h_n_buf (= %b) && VCCD (= %b) %m",ANALOG_EN, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,$stime);
            end
            else
                if (msg_count_pad10 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_supply_good = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1  && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VSWITCH_H !==1 && ENABLE_VSWITCH_H !==0 );
event event_error_supply_good;
always @(error_supply_good)
begin
    if (!dis_err_msgs)
    begin
        if (error_supply_good===1)
        begin
            msg_count_pad11 = msg_count_pad11 + 1;
            ->event_error_supply_good;
            if (msg_count_pad11 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VSWITCH_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VSWITCH_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad11 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
wire #100 error_vdda_vddioq_vswitch2 = ( VDDA ===1 && VDDIO_Q ===1 && VSWITCH ===1 && ENABLE_H ===1 && hld_h_n_buf ===1 && VCCD ===1 &&  ANALOG_EN===1 && ENABLE_VDDA_H !==1 && ENABLE_VDDA_H !==0 );
event event_error_vdda_vddioq_vswitch2;
always @(error_vdda_vddioq_vswitch2)
begin
    if (!dis_err_msgs)
    begin
        if (error_vdda_vddioq_vswitch2===1)
        begin
            msg_count_pad12 = msg_count_pad12 + 1;
            ->event_error_vdda_vddioq_vswitch2;
            if (msg_count_pad12 <= MAX_WARNING_COUNT)
            begin
                $display(" ===ERROR=== sky130_fd_io__top_gpio_ovtv2 : ENABLE_VDDA_H(= %b) should be either 1 or 0 when VDDA (= %b) , VDDIO_Q (= %b) , VSWITCH(= %b), ENABLE_H (= %b), hld_h_n_buf (= %b) ,VCCD (= %b) and ANALOG_EN(= %b)  %m",ENABLE_VDDA_H, VDDA,VDDIO_Q,VSWITCH,ENABLE_H,hld_h_n_buf,VCCD,ANALOG_EN,$stime);
            end
            else
                if (msg_count_pad12 == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_gpio_ovtv2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
