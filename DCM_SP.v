module DCM_SP
  #(   parameter CLKFX_MULTIPLY = 4,
       parameter CLKFX_DIVIDE   = 1,
       parameter CLKDV_DIVIDE   = 2,
       parameter CLKIN_PERIOD   = 10,
       parameter CLK_FEEDBACK   = 0
       )
   (
    CLK0, CLK180, CLK270, CLK2X, CLK2X180, CLK90,
    CLKDV, CLKFX, CLKFX180, LOCKED, PSDONE, STATUS,
    CLKFB, CLKIN, DSSEN, PSCLK, PSEN, PSINCDEC, RST);
   

input CLKFB, CLKIN, DSSEN;
input PSCLK, PSEN, PSINCDEC, RST;

output CLK0, CLK180, CLK270, CLK2X, CLK2X180, CLK90;
output CLKDV, CLKFX, CLKFX180, LOCKED, PSDONE;
output [7:0] STATUS;

   
   assign CLK0 = CLKIN;
   assign CLK180 = ~CLKIN;


   assign CLK270   = ~CLK90;
   assign CLK2X180 = ~CLK2X;
   assign CLKFX180 = ~CLKFX;

`ifndef verilator
//`ifdef verilator
   assign CLK2X = CLKIN;
   assign CLK90 = CLKIN;
   assign LOCKED = 1'b1;
   assign CLKFX  = CLKIN;
   assign CLKDV  = CLKIN;
`else   
   
   reg x;     
   always @(posedge CLKIN) begin
      x = $c("m_DCM->posedge()");
   end
   assign CLK90 = $c("m_DCM->clk90(",CLKIN,")");
   assign CLK2X = $c("m_DCM->clk2X(",CLKIN,")");
   assign LOCKED = $c("m_DCM->locked(",CLKIN,")");
   assign CLKFX = $c("m_DCM->clkFX(",CLKIN,",", CLKFX_MULTIPLY, ",", CLKFX_DIVIDE, ")");
   assign CLKDV = $c("m_DCM->clkDV(",CLKIN,",", CLKDV_DIVIDE, ")");

`systemc_header
#ifndef __DCM_H__
#define __DCM_H__
extern unsigned int main_time;

class t_DCM
  {

 private:
   int m_posedge2;
   int m_posedge1;        
   int m_locked;
   int m_T;
 public:
  // CONSTRUCTORS
   t_DCM()
   {
    m_posedge2 = m_posedge1 = m_locked = 0;            
    m_T = 10;
    }
  
  ~t_DCM() {
    
  }
  
  inline bool posedge() {
    if(m_locked < 10) {
      m_locked++;

      m_posedge1 = m_posedge2;
      m_posedge2 = main_time;
      m_T = m_posedge2 - m_posedge1;
      if(m_T == 0) m_T = 10;
//      printf("m_T=%d\n", m_T);
    }
    return true;
  }
     
  inline bool clk90(bool x) {
    return (((main_time-m_T/4) * 2 / m_T) % 2);
  }   
  inline bool clk2X(bool x) {
    return ((main_time * 4 / m_T) % 2);
  }
  inline bool clkFX(bool x, int32_t m, int32_t d) {
    return ((main_time * 2 * m / m_T / d) % 2);
  }
  inline bool clkDV(bool x, int32_t d) {
    return ((main_time * 2 / m_T / d) % 2);
  }
  inline bool locked(bool x) {
    return m_locked >= 10;
  }
   

//  inline int32_t get_img_value(int32_t colAddr, int32_t rowAddr) {
//    return MASK(m_img[rowAddr * COLS + colAddr], ADC_WIDTH);
//  }

};
#endif

`systemc_interface
   t_DCM* m_DCM;        // Pointer to object we are embedding
`systemc_ctor
   m_DCM = new t_DCM(); // Construct contained object
`systemc_dtor
   delete m_DCM;    // Destruct contained object
`verilog
`endif
   
endmodule

