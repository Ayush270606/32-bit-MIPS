module tb3();       
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

       dut.Mem[0]= 32'h280a00c8;  //addi r10,r0,200;
       dut.Mem[1]= 32'h28020001;  //addi r2,r0,r1;
       dut.Mem[2]= 32'h0e94a000;  //or r20,r20,r20;
       dut.Mem[3]= 32'h21430000;  //load r3,0(r10);
       dut.Mem[4]= 32'h0e94a000;  //or r20,r20,r20;
       dut.Mem[5]= 32'h14431000;  //loop mul r2,r2,r3;
       dut.Mem[6]= 32'h2c630001;  //subi r3,r3,1;
       dut.Mem[7]= 32'h0e94a000;  //or r20,r20,r20;
       dut.Mem[8]= 32'h3460fffc;  //bneqz r3,loop1(i.e. -4 offset);
       dut.Mem[9]= 32'h2542fffe;  //sw r2,-2(r10);
       dut.Mem[10]= 32'hfc000000;  // hault;
        dut.Mem[200]=7;
        dut.HALTED=0;
        dut.PC=0;
        dut.TAKEN_BRANCH=0;
        #2000
        $display("Mem[200]: %2d\nMem[198]: %6d",dut.Mem[200],dut.Mem[198]);
        #1000 $finish;
    end
    initial begin
        $monitor("R2:%4d",dut.Reg[2]);
    end


endmodule
