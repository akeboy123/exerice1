`include "fir.v"
module fir_tb();

reg clk = 0;


initial
    forever 
        #5 clk = ~clk;


reg [7:0] data_in;
reg valid_in;
reg [14:0] data_out;

 fir fir(
.data_in(data_in), 
.valid_in(valid_in),
.data_out(),
.clk(clk)
);

initial 
begin
    $dumpfile("dump.vcd");
    $dumpvars(0,fir_tb);
    
end;

initial 
begin
    #100
    data_in = 1;
    valid_in = 1;
    #10;
    valid_in = 0;
     #100
    data_in = 7;
    valid_in = 1;
    #10;
    valid_in = 0;
     #100
    data_in = 12;
    valid_in = 1;
    #10;
    valid_in = 0;
    #100
    $finish();
end


endmodule