// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Apr  1 01:25:13 2024
// Host        : Aghilan running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Aghilan/Amrita/Project_phase_2/proj_directory/full_adder_trojan/full_adder_trojan.sim/sim_1/impl/timing/xsim/MULTIPLIER_tb_time_impl.v
// Design      : fa_trojan
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "ffff99c0" *) 
(* NotValidForBitStream *)
module fa_trojan
   (A,
    B,
    Ci,
    S,
    Co);
  input A;
  input B;
  input Ci;
  output S;
  output Co;

  wire A;
  wire A_IBUF;
  wire B;
  wire B_IBUF;
  wire Ci;
  wire Ci_IBUF;
  wire Co;
  wire S;
  wire S_OBUF;

initial begin
 $sdf_annotate("MULTIPLIER_tb_time_impl.sdf",,,,"tool_control");
end
  IBUF A_IBUF_inst
       (.I(A),
        .O(A_IBUF));
  IBUF B_IBUF_inst
       (.I(B),
        .O(B_IBUF));
  IBUF Ci_IBUF_inst
       (.I(Ci),
        .O(Ci_IBUF));
  OBUF Co_OBUF_inst
       (.I(1'b0),
        .O(Co));
  OBUF S_OBUF_inst
       (.I(S_OBUF),
        .O(S));
  full_adder fa_inst
       (.A_IBUF(A_IBUF),
        .B_IBUF(B_IBUF),
        .Ci_IBUF(Ci_IBUF),
        .S_OBUF(S_OBUF));
endmodule

module full_adder
   (S_OBUF,
    B_IBUF,
    A_IBUF,
    Ci_IBUF);
  output S_OBUF;
  input B_IBUF;
  input A_IBUF;
  input Ci_IBUF;

  wire A_IBUF;
  wire B_IBUF;
  wire Ci_IBUF;
  wire S_OBUF;

  LUT3 #(
    .INIT(8'h96)) 
    output_sum
       (.I0(B_IBUF),
        .I1(A_IBUF),
        .I2(Ci_IBUF),
        .O(S_OBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
