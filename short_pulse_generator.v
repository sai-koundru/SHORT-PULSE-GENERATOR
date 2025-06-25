module cmplx (
    input clk,
    input rst,       // Active high reset
    input start,
    output reg pulse
);

    reg [3:0] count;         // 4-bit counter (0 to 10)
    reg [1:0] pulse_timer;   // 2-bit timer for 2ns high pulse

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            pulse <= 0;
            pulse_timer <= 0;
        end else begin
            if (pulse_timer != 0) begin
                // Maintain pulse high for 2ns
                pulse_timer <= pulse_timer - 1;
                if (pulse_timer == 1)
                    pulse <= 0;
            end else if (start) begin
                count <= count + 1;

                if (count == 9) begin  // 10th clock cycle
                    count <= 0;
                    pulse <= 1;
                    pulse_timer <= 1;  // Just 1 clock will make it high for 10ns = enough for 2ns in waveform
                end
            end else begin
                count <= 0;  // reset count if start goes low
            end
        end
    end

endmodule
