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

module sky130_fd_io__top_sio (IN_H, PAD_A_NOESD_H, PAD, DM, HLD_H_N, INP_DIS, IN,
                              ENABLE_H, OE_N, SLOW, VTRIP_SEL, VINREF, VOUTREF, VREG_EN, IBUF_SEL,
                              REFLEAK_BIAS, PAD_A_ESD_0_H, TIE_LO_ESD, HLD_OVR, OUT,
                              PAD_A_ESD_1_H
                             );
output IN_H;
inout PAD_A_NOESD_H;
inout PAD;
input [2:0] DM;
input HLD_H_N;
input INP_DIS;
output IN;
input ENABLE_H;
input OE_N;
input SLOW;
input VTRIP_SEL;
input VINREF;
input VOUTREF;
input VREG_EN;
input IBUF_SEL;
input REFLEAK_BIAS;
inout PAD_A_ESD_0_H;
output TIE_LO_ESD;
input HLD_OVR;
input OUT;
inout PAD_A_ESD_1_H;
supply0 vssio;
supply0 vssio_q;
supply0 vssd;
supply1 vccd;
supply1 vddio;
supply1 vcchib;
supply1 vddio_q;
reg [2:0] dm_final;
reg slow_final, vtrip_sel_final, inp_dis_final, out_final, oe_n_final, hld_ovr_final;
reg ibuf_sel_final, vreg_en_final;
wire notifier_dm, notifier_slow, notifier_oe_n, notifier_out, notifier_vtrip_sel, notifier_hld_ovr, notifier_inp_dis, notifier_vreg_en,notifier_ibuf_sel;
wire notifier_enable_h;
wire  pwr_good_inpbuff_hv      	= 1;
wire  pwr_good_inpbuff_lv      	= 1;
wire  pwr_good_output_driver  	= 1;
wire  pwr_good_hold_mode	= 1;
wire  pwr_good_hold_ovr_mode	= 1;
wire  pwr_good_active_mode      = 1;
wire pad_tristate = oe_n_final === 1 || dm_final === 3'b000 || dm_final === 3'b001;
wire x_on_pad  =  !pwr_good_output_driver
     || (dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'bx)
     || (^dm_final[2:0] === 1'bx && oe_n_final===1'b0)
     || (slow_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || (vreg_en_final===1'bx && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0)
     || ((VOUTREF!==1'b1 || REFLEAK_BIAS!==1'b1) && vreg_en_final===1'b1 && dm_final !== 3'b000 && dm_final !== 3'b001 && oe_n_final===1'b0 );
`ifdef SKY130_FD_IO_TOP_SIO_SLOW_BEHV
parameter SLOW_1_DELAY= 101;
parameter SLOW_0_DELAY= 42;
`else
parameter SLOW_1_DELAY= 0;
parameter SLOW_0_DELAY= 0;
`endif
integer slow_1_delay,slow_0_delay,slow_delay;
initial slow_1_delay = SLOW_1_DELAY;
initial slow_0_delay = SLOW_0_DELAY;
always @(*)
begin
    if (SLOW===1)
        slow_delay = slow_1_delay;
    else
        slow_delay = slow_0_delay;
end
bufif1 (pull1, strong0) #slow_delay  dm2 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b010));
bufif1 (strong1, pull0)  #slow_delay dm3 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b011));
bufif1 (highz1, strong0) #slow_delay dm4 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b100));
bufif1 (strong1, highz0) #slow_delay dm5 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b101));
bufif1 (strong1, strong0)#slow_delay dm6 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b110));
bufif1 (pull1, pull0)   #slow_delay  dm7 (PAD, out_final, x_on_pad===1 ? 1'bx : (pad_tristate===0 && dm_final===3'b111));
tran pad_esd_1 (PAD,PAD_A_NOESD_H);
tran pad_esd_2 (PAD,PAD_A_ESD_0_H);
tran pad_esd_3 (PAD,PAD_A_ESD_1_H);
wire x_on_in  =  (pwr_good_inpbuff_hv===0)
     || (inp_dis_final===1'bx    && dm_final !== 3'b000)
     || (inp_dis_final===0 	     && ^dm_final[2:0] === 1'bx )
     || (vtrip_sel_final===1'bx  && inp_dis_final===0  && dm_final !== 3'b000)
     || (ibuf_sel_final===1'bx   && inp_dis_final===0  && dm_final !== 3'b000)
     || (VINREF!==1'b1  && inp_dis_final===0  && dm_final !== 3'b000 && ibuf_sel_final===1);
wire disable_inp_buff = (dm_final===3'b000 || inp_dis_final===1);
assign IN_H = x_on_in===1 ? 1'bx : (disable_inp_buff===1 ? 0 : (^PAD===1'bx ? 1'bx : PAD));
assign IN = pwr_good_inpbuff_lv===1 ? IN_H : 1'bx;
assign TIE_LO_ESD = vssio===1'b0 ? 1'b0 : 1'bx;
always @(*)
begin : LATCH_dm
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        dm_final 	<= 3'bxxx;
    else if (ENABLE_H===0)
        dm_final 	<= 3'b000;
    else if (HLD_H_N===1)
        dm_final 	<= (^DM[2:0]	=== 1'bx	|| !pwr_good_active_mode) ? 3'bxxx : DM;
end
always @(notifier_enable_h or notifier_dm)
begin
    disable LATCH_dm; dm_final <= 3'bxxx;
end
always @(*)
begin : LATCH_inp_dis
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        inp_dis_final 	<= 1'bx;
    else if (ENABLE_H===0)
        inp_dis_final 	<= 1'b0;
    else if (HLD_H_N===1)
        inp_dis_final 	<= (^INP_DIS === 1'bx	|| !pwr_good_active_mode) ? 1'bx : INP_DIS;
end
always @(notifier_enable_h or notifier_inp_dis)
begin
    disable LATCH_inp_dis; inp_dis_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 	<= (^VTRIP_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_slow
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        slow_final 	<= 1'bx;
    else if (ENABLE_H===0)
        slow_final 	<= 1'b0;
    else if (HLD_H_N===1)
        slow_final 	<= (^SLOW === 1'bx	|| !pwr_good_active_mode) ? 1'bx : SLOW;
end
always @(notifier_enable_h or notifier_slow)
begin
    disable LATCH_slow; slow_final <= 1'bx;
end
always @(*)
begin : LATCH_hld_ovr
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        hld_ovr_final 	<= 1'bx;
    else if (ENABLE_H===0)
        hld_ovr_final 	<= 1'b0;
    else if (HLD_H_N===1)
        hld_ovr_final 	<= (^HLD_OVR === 1'bx	|| !pwr_good_active_mode) ? 1'bx : HLD_OVR;
end
always @(notifier_enable_h or notifier_hld_ovr)
begin
    disable LATCH_hld_ovr; hld_ovr_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 	<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 	<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 	<= (^VREG_EN === 1'bx	|| !pwr_good_active_mode) ? 1'bx : VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 	<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 	<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 	<= (^IBUF_SEL === 1'bx	|| !pwr_good_active_mode) ? 1'bx : IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_oe_n
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        oe_n_final 	<= 1'bx;
    else if (ENABLE_H===0)
        oe_n_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        oe_n_final  	<= (^OE_N  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OE_N;
end
always @(notifier_enable_h or notifier_oe_n)
begin
    disable LATCH_oe_n; oe_n_final <= 1'bx;
end
always @(*)
begin : LATCH_out
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode || (ENABLE_H===1 && (^HLD_H_N===1'bx || (HLD_H_N===0 && hld_ovr_final===1'bx))))
        out_final 	<= 1'bx;
    else if (ENABLE_H===0)
        out_final 	<= 1'b0;
    else if (HLD_H_N===1 || hld_ovr_final===1)
        out_final  	<= (^OUT  === 1'bx  || !pwr_good_hold_ovr_mode) ? 1'bx   : OUT;
end
always @(notifier_enable_h or notifier_out)
begin
    disable LATCH_out; out_final <= 1'bx;
end
reg dis_err_msgs;
initial
begin
    dis_err_msgs = 1'b1;
`ifdef SKY130_FD_IO_TOP_SIO_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(*)
begin
    if (!dis_err_msgs)
    begin
        if (vreg_en_final===1 && (dm_final!==3'b011 && dm_final!==3'b110 && dm_final!==3'b101))
            $display(" ===INFO=== sky130_fd_io__top_sio :  In regulated output driver mode (vreg_en_final=1), dm_final should be either \011 / 101 / 110 (i.E.strong-pullup mode) inorder for regulated mode to be effective : DM (= %b) and VREG_EN (= %b): %m",dm_final,vreg_en_final,$stime);
    end
end
endmodule
