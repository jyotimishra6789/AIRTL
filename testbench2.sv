`timescale 1ns/1ps

module tb_mor1kx_branch_predictor_gshare;

    
    parameter int GSHARE_BITS_NUM = 10;
    parameter int OPTION_OPERAND_WIDTH = 32;

    
    logic clk;
    logic rst;
    logic predicted_flag_o;
    logic execute_op_bf_i;
    logic execute_op_bnf_i;
    logic op_bf_i;
    logic op_bnf_i;
    logic padv_decode_i;
    logic flag_i;
    logic prev_op_brcond_i;
    logic branch_mispredict_i;
    logic [OPTION_OPERAND_WIDTH-1:0] brn_pc_i;

    
    integer outfile;

    
    mor1kx_branch_predictor_gshare #(
        .GSHARE_BITS_NUM(GSHARE_BITS_NUM),
        .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .predicted_flag_o(predicted_flag_o),
        .execute_op_bf_i(execute_op_bf_i),
        .execute_op_bnf_i(execute_op_bnf_i),
        .op_bf_i(op_bf_i),
        .op_bnf_i(op_bnf_i),
        .padv_decode_i(padv_decode_i),
        .flag_i(flag_i),
        .prev_op_brcond_i(prev_op_brcond_i),
        .branch_mispredict_i(branch_mispredict_i),
        .brn_pc_i(brn_pc_i)
    );

    
    always #5 clk = ~clk;

  
    integer gate_count = 0;
    integer flip_flop_count = 0;
    integer fan_in = 0;
    integer fan_out = 0;
    integer path_length = 0;
    integer depth = 0;

    function integer compute_logic_depth(input integer gates, input integer flipflops, input integer fanin);
        return (gates / (fanin + 1)) + (flipflops / 2);  
    endfunction
   
    initial begin
       
        outfile = $fopen("output.txt", "w");
        if (outfile == 0) begin
            $display("Error opening output file!");
            $finish;
        end

       
        clk = 0;
        rst = 1;
        execute_op_bf_i = 0;
        execute_op_bnf_i = 0;
        op_bf_i = 0;
        op_bnf_i = 0;
        padv_decode_i = 0;
        flag_i = 0;
        prev_op_brcond_i = 0;
        branch_mispredict_i = 0;
        brn_pc_i = 0;

        #10 rst = 0;

       
        gate_count = 500;
        flip_flop_count = 100;
        fan_in = 3;
        fan_out = 2;
        path_length = 10;
        depth = compute_logic_depth(gate_count, flip_flop_count, fan_in);

       
        $fdisplay(outfile, "Time(ns)\tSignal Type\tFan-in\tFan-out\tGate Count\tPath Length\tFlip-Flops\tDepth\tPredicted Flag");

        #10 op_bf_i = 1; flag_i = 1;
        #10 op_bf_i = 0;
        depth = compute_logic_depth(gate_count, flip_flop_count, fan_in);
        $fdisplay(outfile, "%0t\tBranch Taken\t%d\t%d\t%d\t%d\t%d\t%d\t%b", $time, fan_in, fan_out, gate_count, path_length, flip_flop_count, depth, predicted_flag_o);

        
        #10 op_bnf_i = 1; flag_i = 0;
        #10 op_bnf_i = 0;
        depth = compute_logic_depth(gate_count, flip_flop_count, fan_in);
        $fdisplay(outfile, "%0t\tBranch Not Taken\t%d\t%d\t%d\t%d\t%d\t%d\t%b", $time, fan_in, fan_out, gate_count, path_length, flip_flop_count, depth, predicted_flag_o);

        #10 prev_op_brcond_i = 1; branch_mispredict_i = 1;
        #10 prev_op_brcond_i = 0; branch_mispredict_i = 0;
        depth = compute_logic_depth(gate_count, flip_flop_count, fan_in);
        $fdisplay(outfile, "%0t\tMispredict\t%d\t%d\t%d\t%d\t%d\t%d\t%b", $time, fan_in, fan_out, gate_count, path_length, flip_flop_count, depth, predicted_flag_o);

       
        #10 op_bf_i = $random % 2; op_bnf_i = $random % 2; flag_i = $random % 2;
        #10;
        depth = compute_logic_depth(gate_count, flip_flop_count, fan_in);
        $fdisplay(outfile, "%0t\tRandom Toggle\t%d\t%d\t%d\t%d\t%d\t%d\t%b", $time, fan_in, fan_out, gate_count, path_length, flip_flop_count, depth, predicted_flag_o);

        
        $fclose(outfile);

        #20 $finish;
    end

endmodule
