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

module sky130_fd_io__top_power_hvc_wpadv2 ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                          );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout P_CORE;
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
tran p1 (P_CORE, P_PAD);
endmodule
