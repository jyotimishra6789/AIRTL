`timescale 1ns/1ps

module testbench;
    reg clk;
    reg rst;
    reg [7:0] signal_in;
    reg [7:0] fan_in;
    reg [7:0] fan_out;
    reg [7:0] gate_count;
    reg [7:0] path_length;
    reg [7:0] num_ff;
    wire [7:0] depth;

    integer outfile; 

    LogicDepthAnalyzer dut (
        .clk(clk),
        .rst(rst),
        .signal_in(signal_in),
        .fan_in(fan_in),
        .fan_out(fan_out),
        .gate_count(gate_count),
        .path_length(path_length),
        .num_ff(num_ff),
        .depth(depth)
    );

   
    always #5 clk = ~clk;

    initial begin
        
       
        outfile = $fopen("output.txt", "w");
        if (outfile == 0) begin
            $display("Error: Failed to open output.txt");
            $finish;
        end

        // Initialize signals
        clk = 0;
        rst = 1;
        signal_in  = 8'b00000000;
        fan_in     = 8'd0;
        fan_out    = 8'd0;
        gate_count = 8'd0;
        path_length = 8'd0;
        num_ff     = 8'd0;

        $fwrite(outfile, "Time\tSignal In\tFan-in\tFan-out\tGate Count\tPath Length\tFlip-Flops\tDepth\n"); 
        #10 rst = 0; 

        
        #20 signal_in  = 8'b00000001; fan_in = 8'd3; fan_out = 8'd2; gate_count = 8'd5; path_length = 8'd4; num_ff = 8'd1;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b00000101; fan_in = 8'd2; fan_out = 8'd3; gate_count = 8'd7; path_length = 8'd5; num_ff = 8'd2;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b11111111; fan_in = 8'd6; fan_out = 8'd5; gate_count = 8'd12; path_length = 8'd8; num_ff = 8'd3;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b00001010; fan_in = 8'd4; fan_out = 8'd3; gate_count = 8'd9; path_length = 8'd7; num_ff = 8'd2;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b00000000; fan_in = 8'd0; fan_out = 8'd0; gate_count = 8'd0; path_length = 8'd0; num_ff = 8'd0;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b00000011; fan_in = 8'd5; fan_out = 8'd4; gate_count = 8'd10; path_length = 8'd6; num_ff = 8'd2;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b10000000; fan_in = 8'd3; fan_out = 8'd2; gate_count = 8'd6; path_length = 8'd5; num_ff = 8'd1;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b01111111; fan_in = 8'd7; fan_out = 8'd6; gate_count = 8'd14; path_length = 8'd9; num_ff = 8'd4;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b00000000; fan_in = 8'd0; fan_out = 8'd0; gate_count = 8'd0; path_length = 8'd0; num_ff = 8'd0;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #20 signal_in  = 8'b00000111; fan_in = 8'd6; fan_out = 8'd5; gate_count = 8'd11; path_length = 8'd8; num_ff = 8'd3;
        $fwrite(outfile, "%0t\t%b\t%d\t%d\t%d\t%d\t%d\t%d\n", $time, signal_in, fan_in, fan_out, gate_count, path_length, num_ff, depth);

        #50;
        $fclose(outfile); 
        $finish; 
    end
endmodule
