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

module sky130_fd_io__top_ground_hvc_wpad ( G_PAD, AMUXBUS_A, AMUXBUS_B
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
supply0 g_core;
supply1 vddio;
supply1 vddio_q;
supply1 vdda;
supply1 vccd;
supply1 vswitch;
supply1 vcchib;
supply1 vpb;
supply1 vpbhib;
supply0 vssd;
supply0 vssio;
supply0 vssio_q;
supply0 vssa;
assign g_core = G_PAD;
endmodule
