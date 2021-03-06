/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module vga_3 (
    input clk,
    input rst,
    output reg red,
    output reg blue,
    output reg green,
    output reg hsync,
    output reg vsync,
    input up,
    input down,
    input up1,
    input down1,
    output reg [3:0] displayp11,
    output reg [3:0] displayp12,
    output reg [3:0] displayp21,
    output reg [3:0] displayp22
  );
  
  
  
  reg [10:0] M_pixel_d, M_pixel_q = 1'h0;
  reg [10:0] M_line_d, M_line_q = 1'h0;
  reg [10:0] M_player1_d, M_player1_q = 9'h12c;
  reg [10:0] M_player2_d, M_player2_q = 9'h12c;
  reg [10:0] M_ballX_d, M_ballX_q = 9'h190;
  reg [10:0] M_ballY_d, M_ballY_q = 9'h12c;
  reg [0:0] M_ballDirX_d, M_ballDirX_q = 1'h1;
  reg [0:0] M_ballDirY_d, M_ballDirY_q = 1'h1;
  reg [27:0] M_ballspeed_d, M_ballspeed_q = 19'h7a120;
  reg [3:0] M_tmr_d, M_tmr_q = 1'h0;
  reg [3:0] M_p11score_d, M_p11score_q = 1'h0;
  reg [3:0] M_p12score_d, M_p12score_q = 1'h0;
  reg [3:0] M_p21score_d, M_p21score_q = 1'h0;
  reg [3:0] M_p22score_d, M_p22score_q = 1'h0;
  reg [5:0] M_alufn_d, M_alufn_q = 1'h0;
  reg [15:0] M_a_d, M_a_q = 1'h0;
  reg [15:0] M_b_d, M_b_q = 1'h0;
  wire [1-1:0] M_stateCounter1_inc_state;
  wire [1-1:0] M_stateCounter1_dec_state;
  wire [1-1:0] M_stateCounter1_inc1_state;
  wire [1-1:0] M_stateCounter1_dec1_state;
  wire [1-1:0] M_stateCounter1_updateball;
  wire [1-1:0] M_stateCounter1_updatespd;
  reg [28-1:0] M_stateCounter1_ballspd;
  stateCounter_7 stateCounter1 (
    .clk(clk),
    .rst(rst),
    .btn(up),
    .btn1(down),
    .btn2(up1),
    .btn3(down1),
    .ballspd(M_stateCounter1_ballspd),
    .inc_state(M_stateCounter1_inc_state),
    .dec_state(M_stateCounter1_dec_state),
    .inc1_state(M_stateCounter1_inc1_state),
    .dec1_state(M_stateCounter1_dec1_state),
    .updateball(M_stateCounter1_updateball),
    .updatespd(M_stateCounter1_updatespd)
  );
  
  wire [16-1:0] M_alumod_alu;
  wire [1-1:0] M_alumod_z;
  wire [1-1:0] M_alumod_v;
  wire [1-1:0] M_alumod_n;
  wire [1-1:0] M_alumod_overflow;
  alu_8 alumod (
    .alufn(M_alufn_q),
    .a(M_a_q),
    .b(M_b_q),
    .alu(M_alumod_alu),
    .z(M_alumod_z),
    .v(M_alumod_v),
    .n(M_alumod_n),
    .overflow(M_alumod_overflow)
  );
  
  integer border;
  
  integer bordersize;
  
  integer padsize;
  
  integer mid_line;
  
  integer p1;
  
  integer p2;
  
  integer ball;
  
  integer ball_inX;
  
  integer ball_inY;
  
  integer bouncingObject;
  
  reg collisionX1;
  reg collisionX2;
  reg collisionY1;
  reg collisionY2;
  reg collisionX3;
  reg collisionX4;
  
  integer updateballpos;
  
  always @* begin
    M_b_d = M_b_q;
    M_pixel_d = M_pixel_q;
    M_a_d = M_a_q;
    M_ballDirY_d = M_ballDirY_q;
    M_line_d = M_line_q;
    M_ballDirX_d = M_ballDirX_q;
    M_p21score_d = M_p21score_q;
    M_alufn_d = M_alufn_q;
    M_ballspeed_d = M_ballspeed_q;
    M_tmr_d = M_tmr_q;
    M_player1_d = M_player1_q;
    M_player2_d = M_player2_q;
    M_ballX_d = M_ballX_q;
    M_ballY_d = M_ballY_q;
    M_p22score_d = M_p22score_q;
    M_p12score_d = M_p12score_q;
    M_p11score_d = M_p11score_q;
    
    bordersize = 4'ha;
    padsize = 6'h32;
    displayp11 = M_p11score_q;
    displayp12 = M_p12score_q;
    displayp21 = M_p21score_q;
    displayp22 = M_p22score_q;
    if (M_stateCounter1_updatespd == 1'h1) begin
      if (M_tmr_q > 5'h14) begin
        M_tmr_d = M_tmr_q;
      end else begin
        M_tmr_d = M_tmr_q + 1'h1;
      end
    end
    M_ballspeed_d = 18'h3d090 - (13'h1388 * M_tmr_q);
    M_stateCounter1_ballspd = M_ballspeed_q;
    border = (M_pixel_q > (10'h320 - bordersize)) || (M_pixel_q < bordersize) || (M_line_q > (10'h258 - bordersize)) || (M_line_q < bordersize);
    mid_line = (M_pixel_q > 9'h18e) && (M_pixel_q < 9'h190);
    if ((M_player1_q > (10'h258 - bordersize - padsize))) begin
      M_alufn_d = 6'h01;
      M_a_d = 10'h258;
      M_b_d = bordersize + padsize;
      M_player1_d = M_alumod_alu[0+10-:11];
    end else begin
      if ((M_player1_q < (bordersize + padsize))) begin
        M_alufn_d = 6'h00;
        M_a_d = bordersize + padsize;
        M_b_d = 1'h1;
        M_player1_d = M_alumod_alu[0+10-:11];
      end else begin
        if (M_stateCounter1_inc_state == 1'h1) begin
          M_player1_d = M_player1_q + 1'h1;
        end else begin
          if (M_stateCounter1_dec_state == 1'h1) begin
            M_player1_d = M_player1_q - 1'h1;
          end
        end
      end
    end
    if ((M_player2_q > (10'h258 - bordersize - padsize))) begin
      M_alufn_d = 6'h01;
      M_a_d = 10'h258;
      M_b_d = bordersize + padsize;
      M_player2_d = M_alumod_alu[0+10-:11];
    end else begin
      if ((M_player2_q < (bordersize + padsize))) begin
        M_alufn_d = 6'h00;
        M_a_d = bordersize + padsize;
        M_b_d = 1'h1;
        M_player2_d = M_alumod_alu[0+10-:11];
      end else begin
        if (M_stateCounter1_inc1_state == 1'h1) begin
          M_player2_d = M_player2_q + 1'h1;
        end else begin
          if (M_stateCounter1_dec1_state == 1'h1) begin
            M_player2_d = M_player2_q - 1'h1;
          end
        end
      end
    end
    p1 = (M_pixel_q > 5'h14) && (M_pixel_q < 5'h1e) && (M_line_q > (M_player1_q - padsize)) && (M_line_q < (M_player1_q + padsize));
    p2 = (M_pixel_q > 10'h302) && (M_pixel_q < 10'h30c) && (M_line_q > (M_player2_q - padsize)) && (M_line_q < (M_player2_q + padsize));
    if (M_pixel_q < 10'h320 && M_line_q < 10'h258) begin
      if (M_ballX_q == 1'h0 && M_ballY_q == 1'h0) begin
        M_ballX_d = 9'h190;
        M_ballY_d = 9'h12c;
        M_ballspeed_d = 19'h7a120;
      end
      ball_inX = M_ballX_q + 5'h14;
      ball_inY = M_ballY_q + 5'h14;
      ball = (M_pixel_q > M_ballX_q) && (M_pixel_q < (ball_inX)) && (M_line_q > M_ballY_q) && (M_line_q < (ball_inY));
      bouncingObject = border | p1 | p2;
      collisionX1 = ((M_ballX_q == 4'ha));
      collisionX2 = ((ball_inX == 10'h316));
      collisionX3 = ((M_ballX_q == 5'h1e) & ((ball_inY > (M_player1_q - padsize)) & (M_ballY_q < (M_player1_q + padsize))));
      collisionX4 = ((ball_inX == 10'h302) & ((ball_inY > (M_player2_q - padsize)) & (M_ballY_q < (M_player2_q + padsize))));
      collisionY1 = ((M_ballY_q == 4'ha));
      collisionY2 = ((ball_inY == 10'h24e));
      if (collisionX1) begin
        M_ballX_d = 9'h190;
        M_ballY_d = 9'h12c;
        if (M_p22score_q > 4'h8) begin
          M_p22score_d = 1'h0;
          M_p21score_d = M_p21score_q + 1'h1;
        end else begin
          M_p22score_d = M_p22score_q + 1'h1;
        end
        if (M_p21score_q == 4'ha) begin
          M_p21score_d = 1'h0;
        end
      end
      if (collisionX2) begin
        M_ballX_d = 9'h190;
        M_ballY_d = 9'h12c;
        if (M_p12score_q > 4'h8) begin
          M_p12score_d = 1'h0;
          M_p11score_d = M_p11score_q + 1'h1;
        end else begin
          M_p12score_d = M_p12score_q + 1'h1;
        end
        if (M_p11score_q == 4'ha) begin
          M_p11score_d = 1'h0;
        end
      end
      if (collisionX3) begin
        M_ballDirX_d = 1'h1;
      end
      if (collisionX4) begin
        M_ballDirX_d = 1'h0;
      end
      if (collisionY1) begin
        M_ballDirY_d = 1'h1;
      end
      if (collisionY2) begin
        M_ballDirY_d = 1'h0;
      end
      updateballpos = M_stateCounter1_updateball;
      if (updateballpos) begin
        if (M_ballDirX_q) begin
          M_ballX_d = M_ballX_q + 1'h1;
        end else begin
          M_ballX_d = M_ballX_q - 1'h1;
        end
        if (M_ballDirY_q) begin
          M_ballY_d = M_ballY_q + 1'h1;
        end else begin
          M_ballY_d = M_ballY_q - 1'h1;
        end
      end
      red = border | mid_line | p1 | p2;
      green = border | mid_line | ball;
      blue = border | mid_line;
    end else begin
      red = 1'h0;
      green = 1'h0;
      blue = 1'h0;
    end
    if (M_pixel_q >= 12'h357 && M_pixel_q <= 13'h03ce) begin
      hsync = 1'h1;
    end else begin
      hsync = 1'h0;
    end
    if (M_line_q >= 12'h27c && M_line_q <= 13'h0281) begin
      vsync = 1'h1;
    end else begin
      vsync = 1'h0;
    end
    if (M_pixel_q == 14'h040f) begin
      if (M_line_q == 14'h0299) begin
        M_line_d = 1'h0;
      end else begin
        M_line_d = M_line_q + 1'h1;
      end
      M_pixel_d = 1'h0;
    end else begin
      M_pixel_d = M_pixel_q + 1'h1;
    end
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_pixel_q <= 1'h0;
      M_line_q <= 1'h0;
      M_player1_q <= 9'h12c;
      M_player2_q <= 9'h12c;
      M_ballX_q <= 9'h190;
      M_ballY_q <= 9'h12c;
      M_ballDirX_q <= 1'h1;
      M_ballDirY_q <= 1'h1;
      M_ballspeed_q <= 19'h7a120;
      M_tmr_q <= 1'h0;
      M_p11score_q <= 1'h0;
      M_p12score_q <= 1'h0;
      M_p21score_q <= 1'h0;
      M_p22score_q <= 1'h0;
      M_alufn_q <= 1'h0;
      M_a_q <= 1'h0;
      M_b_q <= 1'h0;
    end else begin
      M_pixel_q <= M_pixel_d;
      M_line_q <= M_line_d;
      M_player1_q <= M_player1_d;
      M_player2_q <= M_player2_d;
      M_ballX_q <= M_ballX_d;
      M_ballY_q <= M_ballY_d;
      M_ballDirX_q <= M_ballDirX_d;
      M_ballDirY_q <= M_ballDirY_d;
      M_ballspeed_q <= M_ballspeed_d;
      M_tmr_q <= M_tmr_d;
      M_p11score_q <= M_p11score_d;
      M_p12score_q <= M_p12score_d;
      M_p21score_q <= M_p21score_d;
      M_p22score_q <= M_p22score_d;
      M_alufn_q <= M_alufn_d;
      M_a_q <= M_a_d;
      M_b_q <= M_b_d;
    end
  end
  
endmodule
