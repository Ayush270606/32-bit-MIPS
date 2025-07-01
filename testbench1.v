module tb1();       
    reg clk1,clk2;
    integer k;
    mips_pipe dut(clk1,clk2);
   
    initial begin
        clk1<=1'b0;
        clk2<=1'b0;
        repeat(20)
        begin
        #5 clk1=1; #5 clk1=0;
        #5 clk2=1; #5 clk2=0;
    end
    end

    initial 
    begin
        for(k=0;k<31;k++)
       dut.Reg[k]=k;

       dut.Mem[0]= 32'h2801000a;  //addi r1,ro,10;
       dut.Mem[1]= 32'h28020014;  //addi r2,r0,20; 
       dut.Mem[2]= 32'h28030019;  //addi r3,r0,25;
       dut.Mem[3]= 32'h0ce77800;  //or r7,r7,r7;
       dut.Mem[4]= 32'h0ce77800;  //or r7,r7,r7;
       dut.Mem[5]= 32'h00222000;  //add r4,r1,r2;
       dut.Mem[6]= 32'h0ce77800;  //or r7,r7,r7;
       dut.Mem[7]= 32'h00832800;  //add r5,r4,r3;
       dut.Mem[8]= 32'hfc000000;  // hault;
        dut.HALTED=0;
        dut.PC=0;
        dut.TAKEN_BRANCH=0;
        #280
        for(k=0;k<6;k++)
        $display("R%1d  - %2d",k,dut.Reg[k]);
    end

endmodule 
