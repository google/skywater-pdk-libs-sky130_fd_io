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

module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
                                   AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
                                   DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
                                   ,VCCD, VCCHIB, VDDA, VDDIO,VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH
                                 );
output XRES_H_N;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout PAD;
input DISABLE_PULLUP_H;
input ENABLE_H;
input EN_VDDIO_SIG_H;
input INP_SEL_H;
input FILT_IN_H;
inout PULLUP_H;
input ENABLE_VDDIO;
input VCCD;
input VCCHIB;
input VDDA;
input VDDIO;
input VDDIO_Q;
input VSSA;
input VSSD;
input VSSIO;
input VSSIO_Q;
input VSWITCH;
wire mode_vcchib;
wire pwr_good_xres_tmp 	= (VDDIO===1) && (VDDIO_Q===1) && ((mode_vcchib && ENABLE_VDDIO)===1 ? VCCHIB===1 : 1'b1) &&  (VSSIO===0) && (VSSD===0);
wire pwr_good_xres_h_n 		= (VDDIO_Q===1) && (VSSD===0);
wire pwr_good_pullup 		= (VDDIO===1) && (VSSD===0);
inout PAD_A_ESD_H;
output TIE_HI_ESD;
output TIE_LO_ESD;
inout TIE_WEAK_HI_H;
wire tmp1;
pullup (pull1) p1 (tmp1); tranif1 x_pull_1 (TIE_WEAK_HI_H, tmp1, pwr_good_pullup===0  ? 1'bx : 1);
tran p2 (PAD, PAD_A_ESD_H);
buf p4 (TIE_HI_ESD, VDDIO);
buf p5 (TIE_LO_ESD, VSSIO);
wire tmp;
pullup (pull1) p3 (tmp); tranif0 x_pull (PULLUP_H, tmp, pwr_good_pullup===0 || ^DISABLE_PULLUP_H===1'bx ? 1'bx : DISABLE_PULLUP_H);
parameter MAX_WARNING_COUNT = 100;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
parameter MIN_DELAY = 0;
parameter MAX_DELAY = 0;
`else
parameter MIN_DELAY = 50;
parameter MAX_DELAY = 600;
`endif
integer min_delay, max_delay;
initial begin
    min_delay = MIN_DELAY;
    max_delay = MAX_DELAY;
end
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_ENABLE_VDDIO_CHANGE_X
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 1;
`else
parameter DISABLE_ENABLE_VDDIO_CHANGE_X = 0;
`endif
integer     disable_enable_vddio_change_x    = DISABLE_ENABLE_VDDIO_CHANGE_X;
reg notifier_enable_h;
specify
`ifdef SKY130_FD_IO_TOP_XRES4V2_DISABLE_DELAY
    specparam DELAY = 0;
`else
    specparam DELAY = 50;
`endif
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==1) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==1  & ENABLE_VDDIO==1 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==0  &  ENABLE_H==0  & ENABLE_VDDIO==0 & EN_VDDIO_SIG_H==0) (PAD   => XRES_H_N) =  (0:0:0 , 0:0:0);
    if (INP_SEL_H==1) (FILT_IN_H => XRES_H_N) =  (0:0:0 , 0:0:0);
    specparam tsetup = 0;
    specparam thold = 5;
    $setuphold (posedge ENABLE_VDDIO, posedge ENABLE_H,     tsetup, thold,  notifier_enable_h);
    $setuphold (negedge ENABLE_H,     negedge ENABLE_VDDIO, tsetup, thold,  notifier_enable_h);
endspecify
reg corrupt_enable;
always @(notifier_enable_h)
begin
    corrupt_enable <= 1'bx;
end
initial
begin
    corrupt_enable = 1'b0;
end
always @(PAD or ENABLE_H or EN_VDDIO_SIG_H or ENABLE_VDDIO or INP_SEL_H or FILT_IN_H or pwr_good_xres_tmp or DISABLE_PULLUP_H or PULLUP_H or TIE_WEAK_HI_H)
begin
    corrupt_enable <= 1'b0;
end
assign mode_vcchib 	= ENABLE_H && !EN_VDDIO_SIG_H;
wire xres_tmp 	= (pwr_good_xres_tmp===0 || ^PAD===1'bx || (mode_vcchib===1'bx ) ||(mode_vcchib!==1'b0 && ^ENABLE_VDDIO===1'bx) || (corrupt_enable===1'bx) ||
                  (mode_vcchib===1'b1 && ENABLE_VDDIO===0 && (disable_enable_vddio_change_x===0)))
     ? 1'bx : PAD;
wire x_on_xres_h_n = (pwr_good_xres_h_n===0
                      || ^INP_SEL_H===1'bx
                      || INP_SEL_H===1 && ^FILT_IN_H===1'bx
                      || INP_SEL_H===0 && xres_tmp===1'bx);
assign #1  XRES_H_N = x_on_xres_h_n===1 ? 1'bx : (INP_SEL_H===1 ? FILT_IN_H : xres_tmp);
realtime t_pad_current_transition,t_pad_prev_transition;
realtime t_filt_in_h_current_transition,t_filt_in_h_prev_transition;
realtime pad_pulse_width, filt_in_h_pulse_width;
always @(PAD)
begin
    if (^PAD !== 1'bx)
    begin
        t_pad_prev_transition    	= t_pad_current_transition;
        t_pad_current_transition 	= $realtime;
        pad_pulse_width 	     	= t_pad_current_transition - t_pad_prev_transition;
    end
    else
    begin
        t_pad_prev_transition 		= 0;
        t_pad_current_transition 	= 0;
        pad_pulse_width 		= 0;
    end
end
always @(FILT_IN_H)
begin
    if (^FILT_IN_H !== 1'bx)
    begin
        t_filt_in_h_prev_transition    			= t_filt_in_h_current_transition;
        t_filt_in_h_current_transition 			= $realtime;
        filt_in_h_pulse_width 	     			= t_filt_in_h_current_transition - t_filt_in_h_prev_transition;
    end
    else
    begin
        t_filt_in_h_prev_transition 			= 0;
        t_filt_in_h_current_transition 			= 0;
        filt_in_h_pulse_width 				= 0;
    end
end
reg dis_err_msgs;
integer msg_count_pad, msg_count_filt_in_h;
event event_errflag_pad_pulse_width, event_errflag_filt_in_h_pulse_width;
initial
begin
    dis_err_msgs = 1'b1;
    msg_count_pad = 0; msg_count_filt_in_h = 0;
`ifdef SKY130_FD_IO_TOP_XRES4V2_DIS_ERR_MSGS
`else
    #1;
    dis_err_msgs = 1'b0;
`endif
end
always @(pad_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===0 && (pad_pulse_width > min_delay) && (pad_pulse_width < max_delay))
        begin
            msg_count_pad = msg_count_pad + 1;
            ->event_errflag_pad_pulse_width;
            if (msg_count_pad <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for PAD input (= %3.2f ns)  is found to be in \the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",pad_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_pad == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
always @(filt_in_h_pulse_width)
begin
    if (!dis_err_msgs)
    begin
        if (INP_SEL_H===1 && (filt_in_h_pulse_width > min_delay) && (filt_in_h_pulse_width < max_delay))
        begin
            msg_count_filt_in_h = msg_count_filt_in_h + 1;
            ->event_errflag_filt_in_h_pulse_width;
            if (msg_count_filt_in_h <= MAX_WARNING_COUNT)
            begin
                $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Width of Input pulse for FILT_IN_H input (= %3.2f ns)  is found to be in \the range: %3d ns - %3d ns. In this range, the delay and pulse suppression of the input pulse are PVT dependent. : \%m",filt_in_h_pulse_width,min_delay,max_delay,$stime);
            end
            else
                if (msg_count_filt_in_h == MAX_WARNING_COUNT+1)
                begin
                    $display(" ===WARNING=== sky130_fd_io__top_xres4v2 :  Further WARNING messages will be suppressed as the \message count has exceeded 100 %m",$stime);
                end
        end
    end
end
endmodule
