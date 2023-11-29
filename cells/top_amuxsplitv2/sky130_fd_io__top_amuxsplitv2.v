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

`ifndef SKY130_FD_IO__TOP_AMUXSPLITV2_V
`define SKY130_FD_IO__TOP_AMUXSPLITV2_V

/**
 * top_amuxsplitv2: Analog Mux Splitter
 *
 * The amux splitter cell is used to break the AMUX that forms a ring by itself
 * if the GPIO's are abutted.  This is useful for large chips that would require
 * a part of the AMUX to have different functionality from other.  Also, it
 * allows the flexibility to have groups of IO's on different IO domains.
 */

`timescale 1ns/1ps
`default_nettype none

module sky130_fd_io__top_amuxsplitv2 ( amuxbus_a_l, amuxbus_a_r, amuxbus_b_l, amuxbus_b_r
`ifdef USE_POWER_PINS    
    ,vccd, vcchib, vdda, vddio, vddio_q, vssa, vssd, vssio, vssio_q, vswitch
`endif    
    ,enable_vdda_h, hld_vdda_h_n,
    switch_aa_sl, switch_aa_sr, switch_aa_s0,
    switch_bb_sl, switch_bb_sr, switch_bb_s0
    );

`ifdef USE_POWER_PINS

  inout vssio_q;
  inout vcchib;
  inout vdda;
  inout vssa;
  inout vccd;
  inout vddio_q;
  inout vddio;
  inout vswitch;
  inout vssio;
  inout vssd;
    
`else

  supply0 vssio_q;
  supply1 vcchib;
  supply1 vdda;
  supply0 vssa;
  supply1 vccd;
  supply1 vddio_q;
  supply1 vddio;
  supply1 vswitch;
  supply0 vssio;
  supply0 vssd;

`endif
 
 input  switch_aa_sl, switch_aa_sr, switch_aa_s0,
        switch_bb_sl, switch_bb_sr, switch_bb_s0;
 
  inout amuxbus_b_r;
  inout amuxbus_a_l;
  inout amuxbus_b_l;
  inout amuxbus_a_r;
  input enable_vdda_h;
  input hld_vdda_h_n;
 


  reg switch_aa_sl_final,  switch_bb_sl_final;
  reg switch_aa_sr_final,  switch_bb_sr_final;
  reg switch_aa_s0_final,  switch_bb_s0_final;


  parameter MAX_WARNING_COUNT = 100;


//===================================================================================================================================================

// POWER-GOOD Definitions 


`ifdef USE_POWER_PINS

	wire  pwr_good_lv 	= (vdda===1)  && (vswitch===1)  && (vssa===0)   && (vccd===1);
	
	wire  pwr_good_hv 	= (vdda===1)  && (vswitch===1)  && (vssa===0) && (vssd===0);  
	
`else

	wire  pwr_good_lv 	= 1'b1;
	
	wire  pwr_good_hv   	= 1'b1;
	

`endif



//======================================================================================================================================================================
reg notifier_switch_aa_sl,notifier_switch_aa_sr,notifier_switch_aa_s0,notifier_switch_bb_sl,notifier_switch_bb_sr,notifier_switch_bb_s0,notifier_enable_vdda_h;

wire    switch_aa_sl_buf, switch_aa_sr_buf, switch_aa_s0_buf,switch_bb_sl_buf, switch_bb_sr_buf, switch_bb_s0_buf, hld_vdda_h_n_buf;

wire     switch_aa_sl_del, switch_aa_sr_del, switch_aa_s0_del, switch_bb_sl_del, switch_bb_sr_del, switch_bb_s0_del,hld_vdda_h_n_del; 

`ifdef FUNCTIONAL
	
	assign hld_vdda_h_n_buf = hld_vdda_h_n;
	assign  switch_aa_sl_buf = switch_aa_sl ;
	assign  switch_aa_sr_buf = switch_aa_sr ;
	assign switch_aa_s0_buf  = switch_aa_s0;
	assign  switch_bb_sl_buf = switch_bb_sl;
	assign  switch_bb_sr_buf = switch_bb_sr;
	assign  switch_bb_s0_buf = switch_bb_s0;

`else
	assign hld_vdda_h_n_buf = hld_vdda_h_n_del;
	assign switch_aa_sl_buf = switch_aa_sl_del;
	assign switch_aa_sr_buf = switch_aa_sr_del;
	assign switch_aa_s0_buf  = switch_aa_s0_del;
	assign  switch_bb_sl_buf =  switch_bb_sl_del;
	assign switch_bb_sr_buf = switch_bb_sr_del;
	assign switch_bb_s0_buf = switch_bb_s0_del;



specify

      
    $width  (negedge hld_vdda_h_n,	      (15.500:0:15.500));
    $width  (posedge hld_vdda_h_n,	      (15.500:0:15.500));
   
    specparam tsetup = 5;
    specparam thold = 5;

    $setuphold (posedge enable_vdda_h,    negedge hld_vdda_h_n,    tsetup, thold,  notifier_enable_vdda_h); 


    $setuphold (negedge hld_vdda_h_n, posedge switch_aa_sl,   tsetup, thold,  notifier_switch_aa_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sl_del); 
   $setuphold (negedge hld_vdda_h_n, negedge switch_aa_sl,   tsetup, thold,  notifier_switch_aa_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sl_del); 

    $setuphold (negedge hld_vdda_h_n, posedge switch_aa_sr,   tsetup, thold,  notifier_switch_aa_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sr_del);
    $setuphold (negedge hld_vdda_h_n, negedge switch_aa_sr,   tsetup, thold,  notifier_switch_aa_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_sr_del); 

   $setuphold (negedge hld_vdda_h_n, posedge switch_aa_s0,   tsetup, thold,  notifier_switch_aa_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_s0_del); 
   $setuphold (negedge hld_vdda_h_n, negedge switch_aa_s0,   tsetup, thold,  notifier_switch_aa_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_aa_s0_del);

 $setuphold (negedge hld_vdda_h_n, posedge switch_bb_sl,   tsetup, thold,  notifier_switch_bb_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sl_del);
  $setuphold (negedge hld_vdda_h_n, negedge switch_bb_sl,   tsetup, thold,  notifier_switch_bb_sl,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sl_del); 

    $setuphold (negedge hld_vdda_h_n, posedge switch_bb_sr,   tsetup, thold,  notifier_switch_bb_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sr_del); 
   $setuphold (negedge hld_vdda_h_n, negedge switch_bb_sr,   tsetup, thold,  notifier_switch_bb_sr,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_sr_del); 

    $setuphold (negedge hld_vdda_h_n, posedge switch_bb_s0,   tsetup, thold,  notifier_switch_bb_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_s0_del); 
    $setuphold (negedge hld_vdda_h_n, negedge switch_bb_s0,   tsetup, thold,  notifier_switch_bb_s0,   enable_vdda_h==1'b1, enable_vdda_h==1'b1, hld_vdda_h_n_del, switch_bb_s0_del); 
 
 endspecify

`endif








//======================================================================================================================================================================

// Switch functionality 

wire switch_aa_mid, switch_bb_mid;


// T-Switch (amuxbus_a_l <---> amuxbus_a_r)

tranif1  x_aa_sl ( amuxbus_a_l,   switch_aa_mid, switch_aa_sl_final);

tranif1  x_aa_sr ( amuxbus_a_r,   switch_aa_mid, switch_aa_sr_final);

bufif1   x_aa_s0 ( switch_aa_mid, vssa, 	 switch_aa_s0_final);



// T-Switch (amuxbus_b_l <---> amuxbus_b_r)

tranif1  x_bb_sl ( amuxbus_b_l,   switch_bb_mid, switch_bb_sl_final);

tranif1  x_bb_sr ( amuxbus_b_r,   switch_bb_mid, switch_bb_sr_final);

bufif1   x_bb_s0 ( switch_bb_mid, vssa, 	 switch_bb_s0_final);


//========================================================================================================================================================================

// Level-shifted digital inputs - switch_aa_sl, switch_aa_sr, switch_aa_s0

always @(*)
begin : LSH_switch_aa_sl
		
	if ( (^enable_vdda_h===1'bx && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_aa_sl_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0 )
	begin
		switch_aa_sl_final 	<= 1'b0;
	end
	else
	begin
		switch_aa_sl_final 	<= (^switch_aa_sl_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_aa_sl_buf;
	end
end

always @(notifier_switch_aa_sl or notifier_enable_vdda_h)
begin
     disable LSH_switch_aa_sl; switch_aa_sl_final <= 1'bx;
end


always @(*)
begin : LSH_switch_aa_sr
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0 )|| !pwr_good_hv)
	begin
		switch_aa_sr_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_aa_sr_final 	<= 1'b0;
	end
	else
	begin
		switch_aa_sr_final 	<= (^switch_aa_sr_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_aa_sr_buf;
	end
end

always @(notifier_switch_aa_sr or notifier_enable_vdda_h)
begin
     disable LSH_switch_aa_sr; switch_aa_sr_final <= 1'bx;
end


always @(*)
begin : LSH_switch_aa_s0
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_aa_s0_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_aa_s0_final 	<= 1'b0;
	end
	else
	begin
		switch_aa_s0_final 	<= (^switch_aa_s0_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_aa_s0_buf;
	end
end


always @(notifier_switch_aa_s0 or notifier_enable_vdda_h)
begin
     disable LSH_switch_aa_s0; switch_aa_s0_final <= 1'bx;
end


//========================================================================================================================================================================

// Level-shifted digital inputs - switch_bb_sl, switch_bb_sr, switch_bb_s0


always @(*)
begin : LSH_switch_bb_sl
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_bb_sl_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_bb_sl_final 	<= 1'b0;
	end
	else
	begin
		switch_bb_sl_final 	<= (^switch_bb_sl_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_bb_sl_buf;
	end
end

always @(notifier_switch_bb_sl or notifier_enable_vdda_h)
begin
     disable LSH_switch_bb_sl; switch_bb_sl_final <= 1'bx;
end


always @(*)
begin : LSH_switch_bb_sr
		
	if ( (^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) || (^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0) || !pwr_good_hv)
	begin
		switch_bb_sr_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_bb_sr_final 	<= 1'b0;
	end
	else
	begin
		switch_bb_sr_final 	<= (^switch_bb_sr_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_bb_sr_buf;
	end
end

always @(notifier_switch_bb_sr or notifier_enable_vdda_h)
begin
     disable LSH_switch_bb_sr; switch_bb_sr_final <= 1'bx;
end


always @(*)
begin : LSH_switch_bb_s0
		
	if ((^enable_vdda_h===1'bx  && hld_vdda_h_n_buf!==0) ||(^hld_vdda_h_n_buf===1'bx && enable_vdda_h!==0)  || !pwr_good_hv)
	begin
		switch_bb_s0_final 	<= 1'bx;
	end
	else if (enable_vdda_h===0 || hld_vdda_h_n_buf ===0)
	begin
		switch_bb_s0_final 	<= 1'b0;
	end

	else
	begin
		switch_bb_s0_final 	<= (^switch_bb_s0_buf	=== 1'bx || !pwr_good_lv) ? 1'bx : switch_bb_s0_buf;
	end
end

always @(notifier_switch_bb_s0 or notifier_enable_vdda_h)
begin
     disable LSH_switch_bb_s0; switch_bb_s0_final <= 1'bx;
end


//==================================================================================================================================================
 
// ERROR message flagged if illegal switch_sel combinations are detected 

// M0S8 SAS / BROS : Location (where this Error message is specified is to be determined

reg dis_err_msgs;
integer flag_error_short_ar_br, flag_error_short_al_bl, flag_error_illegal_inputs_aa,flag_error_illegal_inputs_bb,msg_count_pad,msg_count_pad1;




initial
begin
  
  dis_err_msgs = 1'b1;
    
  msg_count_pad  = 0; 
  msg_count_pad1 = 0;

  flag_error_short_ar_br	= 0;  
  flag_error_short_al_bl	= 0;  
  flag_error_illegal_inputs_aa	= 0;  
  flag_error_illegal_inputs_bb	= 0;
  
  `ifdef S8IOM0S8_TOP_AMUXSPLITV2_DIS_ERR_MSGS
  `else
    #1;
    dis_err_msgs = 1'b0;
  `endif
end



//=========================================================================================================================================================================

// ERROR MESSAGES FOR DETECTING ILLEGAL (INDIVIDUAL) COMBINATIONS OF T-SWITCH CONTROL INPUTS

wire #100 error_illegal_inputs_aa = ({switch_aa_sl_final,switch_aa_sr_final,switch_aa_s0_final} === 3'b010) || ({switch_aa_sl_final,switch_aa_sr_final,switch_aa_s0_final} === 3'b100);

wire #100 error_illegal_inputs_bb = ({switch_bb_sl_final,switch_bb_sr_final,switch_bb_s0_final} === 3'b010) || ({switch_bb_sl_final,switch_bb_sr_final,switch_bb_s0_final} === 3'b100);

event event_error_illegal_inputs_aa, event_error_illegal_inputs_bb;


always @(error_illegal_inputs_aa) 
begin
  	if (!dis_err_msgs) 
  	begin
    		if (error_illegal_inputs_aa===1) 
		begin

			msg_count_pad = msg_count_pad + 1;

			->event_error_illegal_inputs_aa;

			if (msg_count_pad <= MAX_WARNING_COUNT)
			begin
			$display("\n ===ERROR=== sky130_fd_io__top_amuxsplitv2 :  Illegal combination of T-switch select signals for AMUXBUS_A_L -- AMUXBUS_A_R : \
			switch_aa_sl = %b,switch_aa_sr = %b,switch_aa_s0 = %b. Legal combinations are (sl,sr,s0) = 000, 001, 011, 101, 110, 111 %m\n", 
			switch_aa_sl_final,switch_aa_sr_final,switch_aa_s0_final, $stime);
			end

			else
			if (msg_count_pad == MAX_WARNING_COUNT+1)
			begin
				$display("\n ===WARNING=== sky130_fd_io__top_amuxsplitv2 :  Further WARNING messages will be suppressed as the \
				message count has exceeded 100 %m\n",$stime);
			end
	
		end
	end
end



always @(error_illegal_inputs_bb) 
begin
  	if (!dis_err_msgs) 
  	begin
    		if (error_illegal_inputs_bb===1) 
		begin
		
			msg_count_pad1 = msg_count_pad1 + 1;
		
			->event_error_illegal_inputs_bb;

			if (msg_count_pad1 <= MAX_WARNING_COUNT)
			begin
			$display("\n ===ERROR=== sky130_fd_io__top_amuxsplitv2 :  Illegal combination of T-switch select signals for AMUXBUS_B_L -- AMUXBUS_B_R : \
			switch_bb_sl = %b,switch_bb_sr = %b,switch_bb_s0 = %b. Legal combinations are (sl,sr,s0) = 000, 001, 011, 101, 110, 111 %m\n", 
			switch_bb_sl_final,switch_bb_sr_final,switch_bb_s0_final, $stime);

			end
			else
			if (msg_count_pad1 == MAX_WARNING_COUNT+1)
			begin
				$display("\n ===WARNING=== sky130_fd_io__top_amuxsplitv2 :  Further WARNING messages will be suppressed as the \
				message count has exceeded 100 %m\n",$stime);

			end
			
		end
	end
end


//======================================================================================================================================================================   
  
 
 
endmodule

`default_nettype wire
`endif  // SKY130_FD_IO__TOP_AMUXSPLITV2_V
