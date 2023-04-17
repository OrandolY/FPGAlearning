module key_module(Clk,Rst_n,key_in,key_flag,state)
	
    input Clk;
	input Rst_n;
	input key_in;
	
	output key_flag;
	output state;

    reg key_0,key_1,key_flag;
    reg [3:0]state;
    reg en_cnt;
//    reg [20:0]cnt;
    wire key_full;
    wire en_cnt;

    localparam
        idle    = 4'b0001,
        filter0 = 4'b0010,
        filter1 = 4'b0100,
        press   = 4'b1000;

    module counter(en_cnt,key_full);

always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)begin//按键为低电平有效
        key_in  <= 1;
        key_0   <= 1;
        key_1   <= 1;
        en_cnt  <= 0;
        
        key_flag <= 0;
        state    <= idle;
    end
    else begin
        key_0  <= key_in;
        key_1  <= key_0;

        case (state)
            idle:begin
                if(! key_0 ^ key_1)//异或处理，相同为0；
                    begin
                    state <= idle;
                    key_flag <= 1'b0;
                    en_cnt <= 0;
                    end
                else if(key_0)//后入的高电平，变上升沿
                    state <= filter0;
                else
                    state <= filter1;         
            end

            filter0:begin //上升沿 按键结束

            
            
            
            end
    
    
    
        endcase
    
    
    end

endmodule

module counter(en_cnt,key_full);
    
    input   en_cnt;
    output  key_full;

    reg [20:0]cnt;

    if(!en_cnt)begin
        cnt <= 0;
        key_full <= 0;end
    else if (cnt == 999_999)begin
        cnt <= 0;
        key_full <= 1;
        en_cnt <= 0;end
    else
        cnt <= cnt + 1;
endmodule

