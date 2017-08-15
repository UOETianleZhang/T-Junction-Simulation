//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Fri Nov 13 17:08:50 2015
//Host        : ENG-4933 running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target mb_system_wrapper.bd
//Design      : mb_system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mb_system_wrapper
   (clk_in,
    ext_reset_in,
    led_out_tri_o,
    p_btn_d_tri_i,
    p_btn_l_tri_i,
    p_btn_r_tri_i,
    p_btn_u_tri_i,
    region_0_colour_tri_o,
    region_10_colour_tri_o,
    region_11_colour_tri_o,
    region_1_colour_tri_o,
    region_2_colour_tri_o,
    region_3_colour_tri_o,
    region_4_colour_tri_o,
    region_5_colour_tri_o,
    region_6_colour_tri_o,
    region_7_colour_tri_o,
    region_8_colour_tri_o,
    region_9_colour_tri_o,
    s_switches_tri_i,
    seg7_hex_out_tri_o,
    seg7_sel_out_tri_o,
    uart_rxd,
    uart_txd,
    vga_hs_tri_o,
    vga_vs_tri_o);
  input clk_in;
  input ext_reset_in;
  output [15:0]led_out_tri_o;
  input [0:0]p_btn_d_tri_i;
  input [0:0]p_btn_l_tri_i;
  input [0:0]p_btn_r_tri_i;
  input [0:0]p_btn_u_tri_i;
  output [11:0]region_0_colour_tri_o;
  output [11:0]region_10_colour_tri_o;
  output [11:0]region_11_colour_tri_o;
  output [11:0]region_1_colour_tri_o;
  output [11:0]region_2_colour_tri_o;
  output [11:0]region_3_colour_tri_o;
  output [11:0]region_4_colour_tri_o;
  output [11:0]region_5_colour_tri_o;
  output [11:0]region_6_colour_tri_o;
  output [11:0]region_7_colour_tri_o;
  output [11:0]region_8_colour_tri_o;
  output [11:0]region_9_colour_tri_o;
  input [15:0]s_switches_tri_i;
  output [7:0]seg7_hex_out_tri_o;
  output [3:0]seg7_sel_out_tri_o;
  input uart_rxd;
  output uart_txd;
  output [0:0]vga_hs_tri_o;
  output [0:0]vga_vs_tri_o;

  wire clk_in;
  wire ext_reset_in;
  wire [15:0]led_out_tri_o;
  wire [0:0]p_btn_d_tri_i;
  wire [0:0]p_btn_l_tri_i;
  wire [0:0]p_btn_r_tri_i;
  wire [0:0]p_btn_u_tri_i;
  wire [11:0]region_0_colour_tri_o;
  wire [11:0]region_10_colour_tri_o;
  wire [11:0]region_11_colour_tri_o;
  wire [11:0]region_1_colour_tri_o;
  wire [11:0]region_2_colour_tri_o;
  wire [11:0]region_3_colour_tri_o;
  wire [11:0]region_4_colour_tri_o;
  wire [11:0]region_5_colour_tri_o;
  wire [11:0]region_6_colour_tri_o;
  wire [11:0]region_7_colour_tri_o;
  wire [11:0]region_8_colour_tri_o;
  wire [11:0]region_9_colour_tri_o;
  wire [15:0]s_switches_tri_i;
  wire [7:0]seg7_hex_out_tri_o;
  wire [3:0]seg7_sel_out_tri_o;
  wire uart_rxd;
  wire uart_txd;
  wire [0:0]vga_hs_tri_o;
  wire [0:0]vga_vs_tri_o;

  mb_system mb_system_i
       (.LED_OUT_tri_o(led_out_tri_o),
        .P_BTN_D_tri_i(p_btn_d_tri_i),
        .P_BTN_L_tri_i(p_btn_l_tri_i),
        .P_BTN_R_tri_i(p_btn_r_tri_i),
        .P_BTN_U_tri_i(p_btn_u_tri_i),
        .REGION_0_COLOUR_tri_o(region_0_colour_tri_o),
        .REGION_10_COLOUR_tri_o(region_10_colour_tri_o),
        .REGION_11_COLOUR_tri_o(region_11_colour_tri_o),
        .REGION_1_COLOUR_tri_o(region_1_colour_tri_o),
        .REGION_2_COLOUR_tri_o(region_2_colour_tri_o),
        .REGION_3_COLOUR_tri_o(region_3_colour_tri_o),
        .REGION_4_COLOUR_tri_o(region_4_colour_tri_o),
        .REGION_5_COLOUR_tri_o(region_5_colour_tri_o),
        .REGION_6_COLOUR_tri_o(region_6_colour_tri_o),
        .REGION_7_COLOUR_tri_o(region_7_colour_tri_o),
        .REGION_8_COLOUR_tri_o(region_8_colour_tri_o),
        .REGION_9_COLOUR_tri_o(region_9_colour_tri_o),
        .SEG7_HEX_OUT_tri_o(seg7_hex_out_tri_o),
        .SEG7_SEL_OUT_tri_o(seg7_sel_out_tri_o),
        .S_SWITCHES_tri_i(s_switches_tri_i),
        .VGA_HS_tri_o(vga_hs_tri_o),
        .VGA_VS_tri_o(vga_vs_tri_o),
        .clk_in(clk_in),
        .ext_reset_in(ext_reset_in),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));
endmodule
