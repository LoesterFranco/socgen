
`include "defines.v"

module `VARIANT
#(parameter STATE_SIZE=3)

(

    input  wire                            clk,         
    input  wire                          reset,        
    input  wire                         enable,
    input  wire                         disable_ir,
    input  wire                       fetch_op,
    input  wire  [STATE_SIZE:0]         state,            
    input  wire            [7:0]     prog_data,            

    output  reg 		  now_fetch_op,
 
    output  reg            [7:0]            ir,            
    output  reg            [1:0]        length,            

    output  reg                      immediate,
    output  reg                       absolute,
    output  reg                      zero_page,
    output  reg                      indirectx,
    output  reg                      indirecty,
    output  reg                        implied,
    output  reg                       relative,
    output  reg                          stack,

    output  reg                            jsr,
    output  reg                           jump,
    output  reg                  jump_indirect,
    output  reg                            brk,
    output  reg                            rti,
    output  reg                            rts,

    output  reg                        invalid,

    output  reg            [1:0]      ins_type,

    output  reg            [2:0]          ctrl,
    output  reg            [2:0]          dest, 
 
    output  reg            [2:0]  alu_op_a_sel, 
    output  reg            [1:0]  alu_op_b_sel, 
    output  reg                   alu_op_b_inv,
    output  reg            [1:0]  alu_op_c_sel,

    output  reg            [1:0]       idx_sel, 
 

    output reg             [2:0]      alu_mode,
    output reg             [4:0] alu_status_update,    
 
    output  reg            [7:0]     brn_value,
    output  reg            [7:0]    brn_enable
);



reg  [1:0]  n_length;

reg  n_immediate;
reg  n_absolute;
reg  n_zero_page;
reg  n_indirectx;
reg  n_indirecty;
reg  n_implied;
reg  n_relative;
reg  n_stack;
reg  n_jsr;
reg  n_jump;
reg  n_jump_indirect;
reg  n_brk;
reg  n_rti;
reg  n_rts;
reg  n_invalid;
reg [1:0]  n_ins_type;

reg [2:0]  n_ctrl;
reg [2:0]  n_dest; 
reg [2:0]  n_alu_op_a_sel; 
reg [1:0]  n_alu_op_b_sel;
reg [1:0]  n_idx_sel;    
reg        n_alu_op_b_inv;
reg [1:0]  n_alu_op_c_sel; 
reg [2:0]  n_alu_mode;
reg [4:0]  n_alu_status_update;    
reg [7:0]  n_brn_value;
reg [7:0]  n_brn_enable;




always@(*)
 now_fetch_op = (state == `FETCH_OP) ||  fetch_op  ||  implied || stack  ;
   
   

always@(posedge clk)
  if (reset || disable_ir)
    begin
    ir                 <= 8'h00;
    length             <= 2'b00;
    absolute           <= 1'b0;
    immediate          <= 1'b0;
    implied            <= 1'b0;
    indirectx          <= 1'b0;
    indirecty          <= 1'b0;
    relative           <= 1'b0;
    zero_page          <= 1'b0;
    stack              <= 1'b0;
    jump               <= 1'b0;
    jump_indirect      <= 1'b0;
    jsr                <= 1'b0;
    brk                <= 1'b0;
    rti                <= 1'b0;
    rts                <= 1'b0;
    ins_type           <= `ins_type_none;     
    alu_mode           <= `alu_mode_add;
    alu_op_a_sel       <= `alu_op_a_00;
    alu_op_b_sel       <= `alu_op_b_00;
    alu_op_b_inv       <= 1'b0; 
    alu_op_c_sel       <= `alu_op_c_00;   
    idx_sel            <= `idx_sel_00;   
    alu_status_update  <= `alu_status_update_none;  
    brn_value          <= 8'h00;
    brn_enable         <= 8'h00;
    dest               <= `dest_none;   
    ctrl               <= `ctrl_none;   
    invalid            <= 1'b0;
    end
  else
  if((!enable) || (!now_fetch_op)  )  
   begin
    ir                 <= ir                ;
    length             <= length            ;
    absolute           <= absolute          ;
    immediate          <= immediate         ;
    implied            <= implied           ;
    indirectx          <= indirectx         ;
    indirecty          <= indirecty         ;
    relative           <= relative          ;
    zero_page          <= zero_page         ;
    stack              <= stack             ;
    jump               <= jump              ;
    jump_indirect      <= jump_indirect     ;
    jsr                <= jsr               ;
    brk                <= brk               ;
    rti                <= rti               ;
    rts                <= rts               ;
    ins_type           <= ins_type          ;     
    alu_mode           <= alu_mode          ;
    alu_op_a_sel       <= alu_op_a_sel      ;
    alu_op_b_sel       <= alu_op_b_sel      ;
    alu_op_b_inv       <= alu_op_b_inv      ; 
    alu_op_c_sel       <= alu_op_c_sel      ;
    idx_sel            <= idx_sel           ;
    alu_status_update  <= alu_status_update ;  
    brn_value          <= brn_value         ;
    brn_enable         <= brn_enable        ;
    dest               <= dest              ;   
    ctrl               <= ctrl              ;   
    invalid            <= invalid           ;
    end    
  else
   begin
    ir                 <= prog_data           ;
    length             <= n_length            ;
    absolute           <= n_absolute          ;
    immediate          <= n_immediate         ;
    implied            <= n_implied           ;
    indirectx          <= n_indirectx         ;
    indirecty          <= n_indirecty         ;
    relative           <= n_relative          ;
    zero_page          <= n_zero_page         ;
    stack              <= n_stack             ;
    jump               <= n_jump              ;
    jump_indirect      <= n_jump_indirect     ;
    jsr                <= n_jsr               ;
    brk                <= n_brk               ;
    rti                <= n_rti               ;
    rts                <= n_rts               ;
    ins_type           <= n_ins_type          ;     
    alu_mode           <= n_alu_mode          ;
    alu_op_a_sel       <= n_alu_op_a_sel      ;
    alu_op_b_sel       <= n_alu_op_b_sel      ;
    alu_op_b_inv       <= n_alu_op_b_inv      ; 
    alu_op_c_sel       <= n_alu_op_c_sel      ;   
    idx_sel            <= n_idx_sel           ;   
    alu_status_update  <= n_alu_status_update ;  
    brn_value          <= n_brn_value         ;
    brn_enable         <= n_brn_enable        ;
    dest               <= n_dest              ;   
    ctrl               <= n_ctrl              ;   
    invalid            <= n_invalid           ;
   end
    


always @ (*) 
  begin  
   n_length             = 2'b00;
   n_absolute           = 1'b0;
   n_immediate          = 1'b0;
   n_implied            = 1'b0;
   n_indirectx          = 1'b0;
   n_indirecty          = 1'b0;
   n_relative           = 1'b0;
   n_zero_page          = 1'b0;
   n_stack              = 1'b0;
   n_jump               = 1'b0;
   n_jump_indirect      = 1'b0;
   n_jsr                = 1'b0;
   n_brk                = 1'b0;
   n_rti                = 1'b0;
   n_rts                = 1'b0;
   n_ins_type           = `ins_type_none;     
   n_alu_mode           = `alu_mode_add;
   n_alu_op_a_sel       = `alu_op_a_00;
   n_alu_op_b_sel       = `alu_op_b_00;
   n_alu_op_b_inv       = 1'b0; 
   n_alu_op_c_sel       = `alu_op_c_00;
   n_idx_sel            = `idx_sel_00;   
   n_alu_status_update  = `alu_status_update_none;  
   n_brn_value          = 8'h00;
   n_brn_enable         = 8'h00;
   n_dest               = `dest_none;   
   n_ctrl               = `ctrl_none;   
   n_invalid            = 1'b0;
 
   case (prog_data)

// implied

      
       `CLC_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h00;
           n_brn_enable                         = 8'h01;
           n_dest                               = `dest_none;
           end

       `CLD_IMP:  
           begin
           n_length                             = 2'b01;	    
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h00;
           n_brn_enable                         = 8'h08;
           n_dest                               = `dest_none;    
           end

       `CLI_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h00;
           n_brn_enable                         = 8'h04;
           n_dest                               = `dest_none;    
           end

       `CLV_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h00;
           n_brn_enable                         = 8'h40;
           n_dest                               = `dest_none;    
           end

       `DEX_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_x;    
           end

       `DEY_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_y;    
           end

       `INX_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_x;    
           end

       `INY_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_y;    
           end

       `SEC_IMP: 
           begin
           n_length                             = 2'b01;	    
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h01;
           n_brn_enable                         = 8'h01;
           n_dest                               = `dest_none;    
           end

       `SED_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h08;
           n_brn_enable                         = 8'h08;
           n_dest                               = `dest_none;    
           end

       `SEI_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h04;
           n_brn_enable                         = 8'h04;
           n_dest                               = `dest_none;    
           end

       `TAX_IMP:
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_x;     
           end

       `TAY_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_y;     
           end

       `TXA_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;    
           end

       `TYA_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;    
           end


       `NOP_IMP: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_dest                               = `dest_none;    
           end
     
       `ASL_ACC:
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;   
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc; 
           n_dest                               = `dest_alu_a;        
           end
 
       `LSR_ACC: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;      
           n_dest                               = `dest_alu_a;                  
           end


       `ROL_ACC:
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;      
           n_dest                               = `dest_alu_a;                  
           end 

       `ROR_ACC: 
           begin
           n_length                             = 2'b01;
           n_implied                            = 1'b1;
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;      
           n_dest                               = `dest_alu_a;                  
           end

// immediate

       `ADC_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;
           n_dest                               = `dest_alu_a;                   
           end

       `AND_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;                  
           end

       `CMP_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;                  
           end

       `CPX_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;                 
           end

       `CPY_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b1;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;           
           end

       `EOR_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;        
           end

       `LDA_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;        
           n_dest                               = `dest_alu_a;                   
           end

       `LDX_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_alu_x;                    
           end

       `LDY_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz; 
           n_dest                               = `dest_alu_y;        
           end

       `ORA_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;                        
           end

       `SBC_IMM: 
           begin
           n_length                             = 2'b10;
           n_immediate                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_imm;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;     
           n_dest                               = `dest_alu_a;                   
           end

// zero_page
     

       `ADC_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;  	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;
           n_dest                               = `dest_alu_a;                  
           end    


       `AND_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;        
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;        
           end    


       `ASL_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_rmw;       	      
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                  
           end    


       `BIT_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;   
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_z67;
           n_dest                               = `dest_mem;        
           end    


       `CMP_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;         
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                  
           end    


       `CPX_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                        
           end    


       `CPY_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc; 
           n_dest                               = `dest_mem;                       
           end    


       `DEC_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_ff;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                  
           end    


       `EOR_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                            
           end    


       `INC_ZPG: 
           begin
           n_length                             = 2'b10;	    
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                            
           end    


       `LDA_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_alu_a;                     
           end    


       `LDX_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_x;                               
           end    


       `LDY_ZPG:
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_y;                                        
           end    


       `LSR_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                     
           end    


       `ORA_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                               
           end    


       `ROL_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                               
           end    


       `ROR_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                               
           end    


       `SBC_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;
           n_dest                               = `dest_mem;                               
           end    


       `STA_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_write;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;                     
           end    


       `STX_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;                     
           end    


       `STY_ZPG: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_ins_type                           = `ins_type_write;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;                     
           end    

// zero_page_indexed
     

       `ADC_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;
           n_dest                               = `dest_alu_a;          
           end

       `AND_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;                               
           end

       `ASL_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                               
           end

       `CMP_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;                     
           end

       `DEC_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
           n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_ff;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                               
           end

       `EOR_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                               
           end

       `INC_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                               
           end

       `LDA_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;                               
           end

       `LDY_ZPX: 
           begin
           n_length                             = 2'b10;	    
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;          
           n_dest                               = `dest_alu_y;                     
           end

       `LSR_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                                     
           end

       `ORA_ZPX:  
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                                               
           end

       `ROL_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_rmw;	      
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                                               
           end

       `ROR_ZPX:
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                                               
           end

       `SBC_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;
           n_dest                               = `dest_mem;                                               
           end

       `STA_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_write;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;                                               
           end

       `STY_ZPX: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_write;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;                                               
           end


       `LDX_ZPY:
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_x;                                               
           end
 
       `STX_ZPY: 
           begin
           n_length                             = 2'b10;
           n_zero_page                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_write;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;                                               
           end

// Branch

       `BCC_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`C]                     = 1'b1;
           n_brn_value[`C]                      = 1'b0;
           n_dest                               = `dest_none;                                               
           end 



       `BCS_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`C]                     = 1'b1;
           n_brn_value[`C]                      = 1'b1;
           n_dest                               = `dest_none;                                               
           end 


       `BNE_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`Z]                     = 1'b1;
           n_brn_value[`Z]                      = 1'b0;
           n_dest                               = `dest_none;                                               
           end 



       `BEQ_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`Z]                     = 1'b1;
           n_brn_value[`Z]                      = 1'b1; 
           n_dest                               = `dest_none;                                               
           end 







       `BPL_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`N]                     = 1'b1;
           n_brn_value[`N]                      = 1'b0;   
           n_dest                               = `dest_none;                                               
           end 



       `BMI_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`N]                     = 1'b1;
           n_brn_value[`N]                      = 1'b1;   
           n_dest                               = `dest_none;                  
           end 



       `BVC_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`V]                     = 1'b1;
           n_brn_value[`V]                      = 1'b0;   
           n_dest                               = `dest_none;                                                         
           end 



       `BVS_REL: 
           begin
           n_length                             = 2'b10;
           n_relative                           = 1'b1;
           n_ctrl                               = `ctrl_branch;   
           n_brn_enable[`V]                     = 1'b1;
           n_brn_value[`V]                      = 1'b1;   
           n_dest                               = `dest_none;                                                         
           end 

// absolute
     
       `ADC_ABS:
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;
           n_dest                               = `dest_alu_a;                                                         
           end 
    
       `AND_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;	      
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;                                                                   
           end 

       `ASL_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;                                                                   
           end 

       `BIT_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_z67;
           n_dest                               = `dest_none;                                                                   
           end 

       `CMP_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;                                                                   
           end 

       `CPX_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       	      
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc; 
           n_dest                               = `dest_none;                                                                        
           end 

       `CPY_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;                                                                                  
           end 

       `DEC_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_ff;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                                                                                  
           end 

       `EOR_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;                                                                         
          end 

       `INC_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;                                                                         
           end 

       `LDA_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;          
           n_dest                               = `dest_alu_a;                                                                         
           end 

       `LDX_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;          
           n_dest                               = `dest_alu_x;                                                                         
           end 

       `LDY_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;          
           n_dest                               = `dest_alu_y;                                                                         
           end 

       `LSR_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;       
           n_dest                               = `dest_mem;
           end 

       `ORA_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_alu_a;
           end 

       `ROL_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;       
           n_dest                               = `dest_mem;
           end 

       `ROR_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_rmw;     	      	       
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;       
           n_dest                               = `dest_mem;
           end 

       `SBC_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_read;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;	      
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;       
           n_dest                               = `dest_alu_a; 
           end 

       `STA_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_write;     	      	       
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;
           end 

       `STX_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_x;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;
           end 

       `STY_ABS: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_y;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;
           n_dest                               = `dest_mem;
           end  

// absolute_indexed
     
       `ADC_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;  
           n_dest                               = `dest_alu_a;
           end 

       `AND_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 

       `ASL_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;  
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_mem;
           end 

       `CMP_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;
           end 

       `DEC_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_ff;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;
           end 

       `EOR_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 

       `INC_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_mem;
           end  

       `LDA_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;          
           n_dest                               = `dest_alu_a;
           end 

       `LDY_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;          
           n_dest                               = `dest_alu_y;
           end 

       `LSR_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nzc;       
           n_dest                               = `dest_mem;
           end 

       `ORA_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;	      
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_mem;
           end 

       `ROL_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;
           n_alu_mode                           = `alu_mode_sfl;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;       
           n_dest                               = `dest_mem;
           end 

       `ROR_ABX:
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_rmw;
           n_alu_mode                           = `alu_mode_sfr;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzc;       
           n_dest                               = `dest_mem;
           end  

       `SBC_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;       
           n_dest                               = `dest_alu_a;
           end 

       `STA_ABX: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;
           end 

       `ADC_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;  
           n_dest                               = `dest_alu_a;
           end 


       `AND_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd; 
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;	      
           end  


       `CMP_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;
           end 


       `EOR_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 


       `LDA_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_alu_a;
           end 


       `LDX_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;    
           n_dest                               = `dest_alu_x;
           end 


       `ORA_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;      
           n_dest                               = `dest_alu_a;
           end 


       `SBC_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;      
           n_dest                               = `dest_alu_a;
           end 


       `STA_ABY: 
           begin
           n_length                             = 2'b11;
           n_absolute                           = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;
           end 
// indirectx
     
       `ADC_IDX: 
           begin
           n_length                             = 2'b10;	    
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;  
           n_dest                               = `dest_alu_a;
           end 

       `AND_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 

       `CMP_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;
           end 

       `EOR_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 

       `LDA_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_alu_a;
           end 

       `ORA_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;      
           n_dest                               = `dest_alu_a;
           end 

       `SBC_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd; 
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;      
           n_dest                               = `dest_alu_a;
           end 

       `STA_IDX: 
           begin
           n_length                             = 2'b10;
           n_indirectx                          = 1'b1;
	   n_idx_sel                            = `idx_sel_x;   
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;
           end 

// indirecty
     
       `ADC_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0; 
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;  
           n_dest                               = `dest_alu_a;
           end 

       `AND_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_and;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 

       `CMP_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;        
           n_alu_op_c_sel                       = `alu_op_c_01;
           n_alu_status_update                  = `alu_status_update_nzc;
           n_dest                               = `dest_none;
           end 

       `EOR_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_eor;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;	      
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;
           end 

       `LDA_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;      
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;  
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;       
           n_dest                               = `dest_alu_a;
           end 

       `ORA_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_orr;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;      
           n_dest                               = `dest_alu_a;
           end 

       `SBC_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
           n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b1;  
           n_alu_op_c_sel                       = `alu_op_c_cin;
           n_alu_status_update                  = `alu_status_update_nzcv;      
           n_dest                               = `dest_alu_a;
           end 

       `STA_IDY: 
           begin 
           n_length                             = 2'b10;
           n_indirecty                          = 1'b1;
	   n_idx_sel                            = `idx_sel_y;   
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;
           end 



// stack



       `PHA_IMP: 
           begin
           n_length                             = 2'b01;
           n_stack                              = 1'b1;
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_acc;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_none;	      
           end

       `PHP_IMP: 
           begin
           n_length                             = 2'b01;
           n_stack                              = 1'b1;	      
           n_ins_type                           = `ins_type_write;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_psr;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_none;  
           n_dest                               = `dest_mem;	      
           end

       `PLA_IMP: 
           begin
           n_length                             = 2'b01;
           n_stack                              = 1'b1;
           n_ins_type                           = `ins_type_read;	      
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_stk;
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_nz;
           n_dest                               = `dest_alu_a;	      
           end

       `PLP_IMP: 
           begin
           n_length                             = 2'b01;
           n_stack                              = 1'b1;
           n_ins_type                           = `ins_type_read;  	      
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_stk;	      
           n_alu_op_b_inv                       = 1'b0;        
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_res;
           n_dest                               = `dest_none;	               
           end



// jump
     
       `JMP_ABS: 
           begin
           n_length                             = 2'b11;
           n_jump                               = 1'b1;
           n_ctrl                               = `ctrl_jmp;   
           end

// jump_indirect     
       `JMP_IND: 
           begin
           n_length                             = 2'b11;
           n_jump_indirect                      = 1'b1;
           n_ctrl                               = `ctrl_jmp_ind;   
           end

// jump_subroutine
     
       `JSR_ABS: 
           begin
           n_length                             = 2'b11;
           n_jsr                                = 1'b1;
           n_ctrl                               = `ctrl_jsr;   
           end


// break     
// ??????????  Need to update alu_status at the end of this instruction
     
       `BRK_IMP: 
           begin
           n_length                             = 2'b01;
           n_brk                                = 1'b1;
           n_ctrl                               = `ctrl_brk;   
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_psr;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_wr;  
           n_brn_value                          = 8'h10; // BRK bit in psr
           n_brn_enable                         = 8'h10;
           n_dest                               = `dest_none;
          end


// return for int
     
       `RTI_IMP: 
           begin
           n_length                             = 2'b01;
           n_rti                                = 1'b1;
           n_ctrl                               = `ctrl_rti;   
           n_ins_type                           = `ins_type_read;
           n_alu_mode                           = `alu_mode_add;
           n_alu_op_a_sel                       = `alu_op_a_00;
           n_alu_op_b_sel                       = `alu_op_b_opnd;
           n_alu_op_b_inv                       = 1'b0;
           n_alu_op_c_sel                       = `alu_op_c_00;
           n_alu_status_update                  = `alu_status_update_res; 
           n_dest                               = `dest_none;
         end

// return from sub
     
       `RTS_IMP: 
           begin
           n_length                             = 2'b01;
           n_rts                                = 1'b1;
           n_ctrl                               = `ctrl_rts;   
           end




       default: 
           begin
           n_invalid                            = 1'b1;
           n_ins_type                           = `ins_type_none;
           end

  endcase

 end // always @ (*)

   

 


endmodule



