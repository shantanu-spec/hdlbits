module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] state;
    reg [255:0] next;

    // Wrap index modulo 16 using bitwise AND
    function [3:0] wrap_index;
        input [5:0] idx;  // 6 bits to support index ±1 around 0..15
        begin
            wrap_index = idx & 4'hF;  // idx mod 16
        end
    endfunction

    // Count neighbors for cell at (row, col)
    function [3:0] count_neighbors;
        input [255:0] grid;
        input [3:0] row, col;
        integer dr, dc;
        reg [3:0] r, c;
        reg [3:0] count;
        begin
            count = 0;
            for (dr = -1; dr <= 1; dr = dr + 1) begin
                for (dc = -1; dc <= 1; dc = dc + 1) begin
                    if (dr == 0 && dc == 0)
                        continue;
                    r = wrap_index(row + dr + 16);
                    c = wrap_index(col + dc + 16);
                    if (grid[r*16 + c])
                        count = count + 1;
                end
            end
            count_neighbors = count;
        end
    endfunction

    integer i;

    always @(*) begin
        for (i = 0; i < 256; i = i + 1) begin
            reg [3:0] row;
            reg [3:0] col;
            reg cell1;
            reg [3:0] neighbors;

            row = i[7:4];
            col = i[3:0];
            cell1 = state[i];
            neighbors = count_neighbors(state, row, col);

            case (neighbors)
                2: next[i] = cell1;
                3: next[i] = 1;
                default: next[i] = 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (load)
            state <= data;
        else
            state <= next;
    end

    always @(*) begin
        q = state;
    end

endmodule
