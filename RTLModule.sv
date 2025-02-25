module LogicDepthAnalyzer #(
    parameter int N = 8  
)(
    input  wire             clk,
    input  wire             rst,
    input  wire [N-1:0]     signal_in,  
    input  wire [N-1:0]     fan_in,    
    input  wire [N-1:0]     fan_out,    
    input  wire [7:0]       gate_count, 
    input  wire [7:0]       path_length,
    input  wire [7:0]       num_ff,     
    output reg  [7:0]       depth,      
    output reg  [7:0]       flip_flops  
);

    integer i;
    reg [7:0] logic_depth [N-1:0]; 
    reg [7:0] max_depth;
    reg [7:0] total_ff; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < N; i = i + 1) begin
                logic_depth[i] <= 0;
            end
            depth <= 0;
            max_depth <= 0;
            total_ff <= 0;
            flip_flops <= 0;
        end else begin
            max_depth = 0; 
            total_ff = 0;  

            for (i = 0; i < N; i = i + 1) begin
                if (signal_in[i]) begin
                   
                    logic_depth[i] <= gate_count + path_length + fan_in[i] + fan_out[i] - num_ff;
                end 

                if (signal_in[i]) begin
                    total_ff = total_ff + num_ff;  
                end

               
                if (logic_depth[i] > max_depth) begin
                    max_depth = logic_depth[i];
                end
            end

            depth <= max_depth;  
            flip_flops <= total_ff;  
        end
    end
endmodule
