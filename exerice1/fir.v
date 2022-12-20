module fir (
data_in, valid_in,data_out,clk
);
input clk;

input signed [7:0] data_in;
input  valid_in;


output reg signed [14:0] data_out;

reg signed [7:0] x [2:0];
reg signed [7:0] h [2:0];
reg signed [7:0] m0,m1;

initial begin
h[0]=5;
h[1]=-5;
h[2]=15;
end

always @(posedge clk) begin
if (valid_in)begin
x[0]<=data_in;
x[1]<=x[0];
x[2]<=x[1];
end
end



reg en_d;
reg cnt_en;
reg [1:0] cnt;
wire flag;

always @(posedge clk)
if (valid_in)
cnt_en <= 1;
else if (cnt ==2)
cnt_en <= 0;

always @(posedge clk)
if (valid_in)
cnt <= 0;
else if (cnt ==2)
cnt <= 0;
else if (cnt_en)
cnt <= cnt + 1;




always @* 
begin
    m0 =0;
    if (cnt == 0)
    m0 = x[0];
    else if (cnt == 1)
    m0 = x[1];
    else if (cnt == 2)
    m0 = x[2];
end

always @* 
begin
    m1 =0;
    if (cnt == 0)
    m1 = h[0];
    else if (cnt == 1)
    m1 = h[1];
    else if (cnt == 2)
    m1 = h[2];
end

wire [14:0] m = m0*m1;

always @(posedge clk) begin

if (cnt_en == 0)
data_out <= 0;
else
if (cnt ==0) begin
    data_out <= data_out +m;
end

else if (cnt ==1) begin
    data_out <= data_out +m;
end

else if (cnt ==2) begin
    data_out <= data_out +m;
end

end

always @(posedge clk)
    en_d <= cnt_en;

assign flag = en_d &(!cnt_en);

endmodule