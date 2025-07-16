
`timescale 1ns/1ps
`include "test.sv"


module tb;

    logic clk;
    logic reset;
    logic red_light;
    logic yellow_light;
    logic green_light;

    traffic_light_controller DUT (
        .clk(clk),
        .reset(reset),
        .red_light(red_light),
        .yellow_light(yellow_light),
        .green_light(green_light));

    
    parameter CLK_PERIOD = 10;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD /2 ) clk = ~clk;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
        $monitor("Time=%0d | CLK=%b | Reset=%b | Current State (from DUT outputs): Red=%b, Yellow=%b, Green=%b, ||Counter: %d ||",
                 $time, clk, reset, red_light, yellow_light, green_light,DUT.counter);
        reset =1; 
      #(CLK_PERIOD *1);
        $display("=========================================RESET DONE=========================================");
        reset = 0;
        
        #(CLK_PERIOD * 22 *2);
        reset = 1; #(CLK_PERIOD *2);
        $display("=========================================RESET AGAIN=========================================");
        reset = 0;
        #(CLK_PERIOD * 22 *4);
        $display("=========================================TEST COMPLETE=========================================");
        $finish;
    end

endmodule