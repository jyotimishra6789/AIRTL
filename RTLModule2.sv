module mor1kx_branch_predictor_gshare #(
    parameter int GSHARE_BITS_NUM = 10,
    parameter int OPTION_OPERAND_WIDTH = 32
)(
    input  logic clk,
    input  logic rst,

    output logic predicted_flag_o,

    input  logic execute_op_bf_i,   
    input  logic execute_op_bnf_i,  
    input  logic op_bf_i,           
    input  logic op_bnf_i,          
    input  logic padv_decode_i,     
    input  logic flag_i,            

    input  logic prev_op_brcond_i,  
    input  logic branch_mispredict_i,

    input  logic [OPTION_OPERAND_WIDTH-1:0] brn_pc_i
);

   typedef enum logic [1:0] {
      STATE_STRONGLY_NOT_TAKEN = 2'b00,
      STATE_WEAKLY_NOT_TAKEN   = 2'b01,
      STATE_WEAKLY_TAKEN       = 2'b10,
      STATE_STRONGLY_TAKEN     = 2'b11
   } fsm_state_t;

   localparam int FSM_NUM = 2 ** GSHARE_BITS_NUM;

   fsm_state_t state[FSM_NUM];

   logic [GSHARE_BITS_NUM:0] brn_hist_reg;
   logic [GSHARE_BITS_NUM-1:0] prev_idx;
   logic [GSHARE_BITS_NUM-1:0] state_index;

   assign state_index = brn_hist_reg[GSHARE_BITS_NUM-1:0] ^ brn_pc_i[GSHARE_BITS_NUM+1:2];

   assign predicted_flag_o = (state[state_index][1] && op_bf_i) ||
                             (!state[state_index][1] && op_bnf_i);

   logic brn_taken;
   assign brn_taken = (execute_op_bf_i && flag_i) || (execute_op_bnf_i && !flag_i);

 
   int gate_count = FSM_NUM;  
   int flip_flop_count = GSHARE_BITS_NUM;
   int path_length = 4;  
   int depth = GSHARE_BITS_NUM;
   int fan_in = 3;
   int fan_out = 2;
   time current_time;

   always_ff @(posedge clk or posedge rst) begin
      if (rst) begin
         brn_hist_reg <= 0;
         prev_idx <= 0;
         for (int i = 0; i < FSM_NUM; i++) begin
            state[i] <= STATE_WEAKLY_TAKEN;
         end
      end else begin
         current_time = $time;
         if (op_bf_i || op_bnf_i) begin
            prev_idx <= state_index;
         end

         if (prev_op_brcond_i && padv_decode_i) begin
            brn_hist_reg <= {brn_hist_reg[GSHARE_BITS_NUM-1:0], brn_taken};

            if (!brn_taken) begin
               case (state[prev_idx])
                  STATE_STRONGLY_TAKEN:  state[prev_idx] <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:    state[prev_idx] <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN: state[prev_idx] <= STATE_STRONGLY_NOT_TAKEN;
                  default:               state[prev_idx] <= STATE_STRONGLY_NOT_TAKEN;
               endcase
            end else begin
               case (state[prev_idx])
                  STATE_STRONGLY_NOT_TAKEN: state[prev_idx] <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN:   state[prev_idx] <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:       state[prev_idx] <= STATE_STRONGLY_TAKEN;
                  default:                  state[prev_idx] <= STATE_STRONGLY_TAKEN;
               endcase
            end
         end
      end
   end

 
   always @(posedge clk) begin
      $display("Time=%t | Signal In=%b | Fan-in=%d | Fan-out=%d | Gate Count=%d | Path Length=%d | Flip-Flops=%d | Depth=%d", 
               current_time, execute_op_bf_i, fan_in, fan_out, gate_count, path_length, flip_flop_count, depth);
   end

endmodule
