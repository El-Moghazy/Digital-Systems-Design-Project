module Project( lcd_rs,  leds , lcd_rw, lcd_e ,open_gate , pos , lcd_4, lcd_5, lcd_6, lcd_7 , infrared_input, clock_50MHz) ;

input [5:0] pos ;
output [5:0] leds   ;

input  infrared_input , clock_50MHz ;

output reg       lcd_rs;
output reg       lcd_rw;
output reg       lcd_e;
output reg       lcd_7;
output reg       lcd_6;
output reg       lcd_5;
output reg       lcd_4;

output open_gate ;

LCDControl1 lcd (  clock_50MHz, pos , lcd_rs, lcd_rw, lcd_e, lcd_4, lcd_5, lcd_6, lcd_7);

Led led(leds , pos ) ;

GateControl gate( open_gate , pos[0] , pos[1] , pos[2] , pos[3] , pos[4] , pos[5] , infrared_input, clock_50MHz) ;

endmodule