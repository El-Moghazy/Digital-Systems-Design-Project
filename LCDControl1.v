module LCDControl1(clk, in, lcd_rs, lcd_rw, lcd_e, lcd_4, lcd_5, lcd_6, lcd_7);
                    parameter       n = 27;	// Total number of bits in counter
                    parameter       k = 17;	// The number of bits used to determine where to start counting from inside the case block
                    input           clk;
						  input [5:0]     in;
                    reg     [n-1:0] count=0;
                    reg             lcd_busy=1; // LCD input, determines when is the LCD being written to
                    reg             lcd_stb;	// LCD input
                    reg       [5:0] lcd_code;	// LCD input excluding lcd_stb
                    reg       [6:0] lcd_stuff; // Used to append LCD input
						  reg       [5:0]	lcd_text [0:12];
                    output reg      lcd_rs;
                    output reg      lcd_rw;
						  output reg      lcd_e;
                    output reg      lcd_7;
                    output reg      lcd_6;
                    output reg      lcd_5;
                    output reg      lcd_4;
						  reg [5:0] in_copy =  6'b011111;
  always @ (posedge clk) begin
		count <= count + 1;
	
	 	case (count[k+7:k+2])
		 0: lcd_code <= 6'b000010;    // function set
       1: lcd_code <= 6'b000010;
       2: lcd_code <= 6'b001100;	
       3: lcd_code <= 6'b000000;    // display on/off control
       4: lcd_code <= 6'b001100;
       5: lcd_code <= 6'b000000;    // display clear
       6: lcd_code <= 6'b000001;
       7: lcd_code <= 6'b000000;    // entry mode set
       8: lcd_code <= 6'b000110;
	    9: lcd_code <= lcd_text[0];
      10: lcd_code <= lcd_text[1];
      11: lcd_code <= lcd_text[2];
      12: lcd_code <= lcd_text[3];
      13: lcd_code <= lcd_text[4];
      14: lcd_code <= lcd_text[5];
      15: lcd_code <= lcd_text[6];
      16: lcd_code <= lcd_text[7];
      17: lcd_code <= lcd_text[8];
      18: lcd_code <= lcd_text[9];
      19: lcd_code <= lcd_text[10];
      20: lcd_code <= lcd_text[11];
		21: if (~(in_copy == in)) begin count <= 0; in_copy <= in; lcd_busy <= 1; end
		default: lcd_code <= 6'b010000;
    endcase
	 
	 if( in == 6'b000000 )
		begin
			lcd_text[0] <= 6'h24;	// F
			lcd_text[1] <= 6'h26;
			lcd_text[2] <= 6'h27;	// u
			lcd_text[3] <= 6'h25;
			lcd_text[4] <= 6'h26;	// l
			lcd_text[5] <= 6'h2c;
			lcd_text[6] <= 6'h26;	// l
			lcd_text[7] <= 6'h2c;
			lcd_text[8] <= 6'h22;
			lcd_text[9] <= 6'h20;
			lcd_text[10] <= 6'h22;
			lcd_text[11] <= 6'h20;
		end
	 else	// A slot is empty
		begin
			lcd_text[0] <= 6'h25;	// S
			lcd_text[1] <= 6'h23;
			lcd_text[2] <= 6'h26;	// l
			lcd_text[3] <= 6'h2c;
			lcd_text[4] <= 6'h26;	// o
			lcd_text[5] <= 6'h2f;
			lcd_text[6] <= 6'h27;	// t
			lcd_text[7] <= 6'h24;
			lcd_text[8] <= 6'h22;	//
			lcd_text[9] <= 6'h20;
			
			if(in[0] == 1'b1)
				begin
					lcd_text[10] <= 6'h23;	// 1
					lcd_text[11] <= 6'h21;
				end
			else if(in[1] == 1'b1)
				begin
					lcd_text[10] <= 6'h23;	// 2
					lcd_text[11] <= 6'h22;
				end
			else if(in[2] == 1'b1)
				begin
					lcd_text[10] <= 6'h23;	// 3
					lcd_text[11] <= 6'h23;
				end
			else if(in[3] == 1'b1)
				begin
					lcd_text[10] <= 6'h23;	// 4
					lcd_text[11] <= 6'h24;
				end
			else if(in[4] == 1'b1)
				begin
					lcd_text[10] <= 6'h23;	// 5
					lcd_text[11] <= 6'h25;
				end
			else if(in[5] == 1'b1)
				begin
					lcd_text[10] <= 6'h23;	// 6
					lcd_text[11] <= 6'h26;
				end
		end
		
	 if (lcd_rw)
      lcd_busy <= 0;
    lcd_stb <= ^count[k+1:k+0] & ~lcd_rw & lcd_busy;  // clkrate / 2^(k+2)
    lcd_stuff <= {lcd_stb,lcd_code};
    {lcd_e,lcd_rs,lcd_rw,lcd_7,lcd_6,lcd_5,lcd_4} <= lcd_stuff;
	end
endmodule