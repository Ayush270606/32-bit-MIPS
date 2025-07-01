module tb2();       
    reg clk1,clk2;
    integer k;
    mips_pipe dut(clk1,clk2);
   
    initial begin
        clk1<=1'b0;
        clk2<=1'b0;
        repeat(50)
        begin
        #5 clk1=1; #5 clk1=0;
        #5 clk2=1; #5 clk2=0;
    end
    end

    initial 
    begin
        for(k=0;k<31;k++)
       dut.Reg[k]=k;

       dut.Mem[0]= 32'h28010078;  //addi r1,ro,120;
       dut.Mem[1]= 32'h0c631800;  //or r3,r3,r3;
       dut.Mem[2]= 32'h20220000;  //lw r2,0(r1);
       dut.Mem[3]= 32'h0c631800;  //or r3,r3,r3;
       dut.Mem[4]= 32'h2842002d;  //addi r2,r2,45;
       dut.Mem[5]= 32'h00222000;  //add r4,r1,r2;
       dut.Mem[6]= 32'h0c631800;  //or r3,r3,r3;
       dut.Mem[7]= 32'h24220001;  //sw r2,1(r1);
       dut.Mem[8]= 32'hfc000000;  // hault;
        dut.Mem[120]=85;
        dut.HALTED=0;
        dut.PC=0;
        dut.TAKEN_BRANCH=0;
        #500
        $display("Mem[120]: %4d\nMem[121]: %4d",dut.Mem[120],dut.Mem[121]);
    end

endmodule
