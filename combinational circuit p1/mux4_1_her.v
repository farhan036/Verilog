module mux4_1 (
input s1,s2,x1,x2,x3,x4,
output reg f
);
always @(s1,s2,x1,x2,x3,x4)
begin
if (s1==1&&s2==1)
f=x4;
else if(s1==0&&s2==1)
f=x3;
else if(s1==1&&s2==0)
f=x2;
else
f=x1;
end



endmodule