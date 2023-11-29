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

module sky130_fd_io__top_refgen_new (VINREF, VOUTREF, REFLEAK_BIAS,
                                     AMUXBUS_A, AMUXBUS_B, DFT_REFGEN, HLD_H_N, IBUF_SEL, ENABLE_H, ENABLE_VDDA_H, VOH_SEL, VOHREF,
                                     VREF_SEL, VREG_EN, VTRIP_SEL, VOUTREF_DFT, VINREF_DFT);
output VINREF;
output VOUTREF;
inout REFLEAK_BIAS;
supply1 vccd;
supply1 vcchib;
supply1 vdda;
supply1 vddio;
supply1 vddio_q;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply1 vswitch;
supply0 vssa;
inout AMUXBUS_A;
inout AMUXBUS_B;
input DFT_REFGEN;
input HLD_H_N;
input IBUF_SEL;
input ENABLE_H;
input ENABLE_VDDA_H;
input [2:0] VOH_SEL;
input VOHREF;
input [1:0] VREF_SEL;
input VREG_EN;
input VTRIP_SEL;
inout VOUTREF_DFT;
inout VINREF_DFT;
reg ibuf_sel_final, vtrip_sel_final, vreg_en_final, dft_refgen_final, vref_sel_int_final;
reg [2:0] voh_sel_final;
reg [1:0] vref_sel_final;
reg vohref_int;
wire  pwr_good_active_mode_1    = 1;
wire  pwr_good_hold_mode_1	= 1;
wire  pwr_good_hold_mode_2   	= 1;
wire  pwr_good_active_mode_2 	= 1;
wire  pwr_good_hold_mode_3   	= 1;
wire  pwr_good_active_mode_3 	= 1;
`ifdef SKY130_FD_IO_TOP_REFGEN_NEW_DISABLE_DELAY
parameter STARTUP_TIME_VOUTREF = 0;
parameter STARTUP_TIME_VINREF  = 0;
`else
parameter STARTUP_TIME_VOUTREF = 50000;
parameter STARTUP_TIME_VINREF  = 50000;
`endif
integer startup_time_vinref,startup_time_voutref;
initial begin
    startup_time_vinref 	= vref_sel_int_final===1 && vtrip_sel_final===0 ? STARTUP_TIME_VINREF : 0;
    startup_time_voutref 	= STARTUP_TIME_VOUTREF;
end
wire 	notifier_enable_h, notifier_vtrip_sel, notifier_ibuf_sel, notifier_vref_sel,
      notifier_voh_sel, notifier_vreg_en, notifier_dft_refgen, notifier_vref_sel_int;
always @(*)
begin : LATCH_ibuf_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        ibuf_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        ibuf_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        ibuf_sel_final 		<= (^IBUF_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: IBUF_SEL;
end
always @(notifier_enable_h or notifier_ibuf_sel)
begin
    disable LATCH_ibuf_sel; ibuf_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vtrip_sel
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vtrip_sel_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vtrip_sel_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vtrip_sel_final 		<= (^VTRIP_SEL 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VTRIP_SEL;
end
always @(notifier_enable_h or notifier_vtrip_sel)
begin
    disable LATCH_vtrip_sel; vtrip_sel_final <= 1'bx;
end
always @(*)
begin : LATCH_vreg_en
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vreg_en_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vreg_en_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vreg_en_final 		<= (^VREG_EN 	  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx 	: VREG_EN;
end
always @(notifier_enable_h or notifier_vreg_en)
begin
    disable LATCH_vreg_en; vreg_en_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel_int
    if (^ENABLE_H===1'bx || !pwr_good_hold_mode_1 || (ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_int_final 		<= 1'bx;
    else if (ENABLE_H===0)
        vref_sel_int_final 		<= 1'b0;
    else if (HLD_H_N===1)
        vref_sel_int_final 		<= (^VREF_SEL[1:0]  === 1'bx  || !pwr_good_active_mode_1) ? 1'bx : (VREF_SEL[1] || VREF_SEL[0]);
end
always @(notifier_enable_h or notifier_vref_sel_int)
begin
    disable LATCH_vref_sel; vref_sel_int_final <= 1'bx;
end
always @(*)
begin : LATCH_vref_sel
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        vref_sel_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        vref_sel_final	= 2'b00;
    else if (HLD_H_N===1)
        vref_sel_final 	= (^VREF_SEL[1:0]=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : VREF_SEL;
end
always @(notifier_enable_h or notifier_vref_sel)
begin
    disable LATCH_vref_sel; vref_sel_final <= 2'bxx;
end
always @(*)
begin : LATCH_dft_refgen
    if (^ENABLE_VDDA_H===1'bx || ^ENABLE_H===1'bx ||!pwr_good_hold_mode_2 || (ENABLE_VDDA_H===1 && ENABLE_H===1 &&^HLD_H_N===1'bx))
        dft_refgen_final 	= 2'bxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        dft_refgen_final	= 2'b00;
    else if (HLD_H_N===1)
        dft_refgen_final 	= (^DFT_REFGEN=== 1'bx || !pwr_good_active_mode_2) ? 2'bxx : DFT_REFGEN;
end
always @(notifier_enable_h or notifier_dft_refgen)
begin
    disable LATCH_dft_refgen; dft_refgen_final <= 2'bxx;
end
always @(*)
begin : LATCH_voh_sel
    if (^ENABLE_VDDA_H===1'bx ||^ENABLE_H===1'bx || !pwr_good_hold_mode_3 || (ENABLE_VDDA_H===1 && ENABLE_H===1 && ^HLD_H_N===1'bx))
        voh_sel_final 	= 3'bxxx;
    else if (ENABLE_VDDA_H===0 || ENABLE_H===0)
        voh_sel_final	= 3'b000;
    else if (HLD_H_N===1)
        voh_sel_final 	= (^VOH_SEL[2:0]=== 1'bx || !pwr_good_active_mode_3) ? 3'bxxx : VOH_SEL;
end
always @(notifier_enable_h or notifier_voh_sel)
begin
    disable LATCH_voh_sel; voh_sel_final <= 2'bxx;
end
always @(*)
begin
    case (vref_sel_final[1:0])
        2'b00, 2'b01   : vohref_int = VOHREF!==1'b1 ? 1'bx : VOHREF;
        2'b10	       : vohref_int = ^AMUXBUS_A!==1'b1 ? 1'bx : AMUXBUS_A;
        2'b11	       : vohref_int = ^AMUXBUS_B!==1'b1 ? 1'bx : AMUXBUS_B;
        default	       : vohref_int = 1'bx;
    endcase
end
wire vohref_final = ENABLE_VDDA_H===1'b1 ? vohref_int : 1'bx;
assign #(startup_time_voutref,0) VOUTREF = (REFLEAK_BIAS===1'bx) ? 1'bx : (REFLEAK_BIAS===1 ? vohref_final:1'bz);
assign VOUTREF_DFT = dft_refgen_final===1 ? VOUTREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
assign REFLEAK_BIAS = vcchib!==1 ? 1'bx : (vreg_en_final || (ibuf_sel_final && vref_sel_int_final));
reg vinref_tmp;
always @(*)
begin
    if (ibuf_sel_final===1'bx
            || (ibuf_sel_final===1 && (vref_sel_int_final===1'bx || vtrip_sel_final===1'bx))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && (vcchib!==1 || vohref_int!==1))
            || (ibuf_sel_final===1 && vref_sel_int_final===1 && vtrip_sel_final===0 && ^voh_sel_final[2:0]===1'bx))
        vinref_tmp = 1'bx;
    else
        vinref_tmp = ibuf_sel_final===0 ? 1'bz : 1'b1;
end
assign #(startup_time_vinref,0) VINREF = vinref_tmp;
assign VINREF_DFT = dft_refgen_final===1 ? VINREF : (dft_refgen_final===0 ? 1'bz : 1'bx);
endmodule
