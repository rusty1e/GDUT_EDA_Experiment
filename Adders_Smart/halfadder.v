//halfadder.v
module half_adder(S,C,A,B);
input A,B;
output S,C;
xor gate1 (S,A,B);
and gate2 (C,A,B);

endmodule

