    module traffic_light_controller (
        input logic clk,
        input logic reset,
        output logic red_light,
        output logic yellow_light,
        output logic green_light
    );

        typedef enum  { 
            RED_STATE,
            RED_YELLOW_STATE,
            YELLOW_STATE,
            GREEN_STATE
        } traffic_state_t;

        traffic_state_t current_state, next_state;
        logic [3:0] counter;

        parameter RED_TIME = 4'd10;
        parameter YELLOW_TIME = 4'd2;
        parameter GREEN_TIME = 4'd8;

        always_ff@(posedge clk) begin
            if (reset) begin
                current_state <= RED_STATE;
                counter <= 4'd0;
            end else begin
                current_state <= next_state;
                if (current_state != next_state) begin
                    counter <= 4'd0;
                end else begin
                    counter <= counter +1;
                end
                end
            end
        
        always_comb begin
            //next_state = current_state;
            red_light = 1'b0;
            yellow_light = 1'b0;
            green_light = 1'b0;

            case (current_state)
            RED_STATE :  begin
                red_light = 1'b1;
                    if (counter == RED_TIME-1) begin
                        next_state = RED_YELLOW_STATE;                        
                    end
            end
            RED_YELLOW_STATE : begin
                yellow_light = 1'b1;
                if (counter == YELLOW_TIME-1) begin
                    next_state = GREEN_STATE;
                                        
                end
            end
            GREEN_STATE : begin
                green_light = 1'b1;
                if (counter == GREEN_TIME-1) begin
                    next_state = YELLOW_STATE;
                                        
                end
            end
            YELLOW_STATE : begin
                yellow_light =1;
                if (counter == YELLOW_TIME-1) begin
                    next_state = RED_STATE;
                                        
                end
            end
                default: begin
                    next_state = RED_STATE;
                end
            endcase
        end

    endmodule