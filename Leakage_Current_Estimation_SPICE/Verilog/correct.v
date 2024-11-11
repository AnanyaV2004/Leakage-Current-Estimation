module Circuit74182 (CN, PB, GB, PBo, GBo, CNX, CNY, CNZ);

  input         CN;
  input [3:0]   PB, GB;
  output        PBo, GBo, CNX, CNY, CNZ;
	
  TopLevel74182 Ckt74182 (CN, PB, GB, PBo, GBo, CNX, CNY, CNZ);

endmodule /* Circuit74182 */

/*************************************************************************/

module TopLevel74182 (CN, PB, GB, PBo, GBo, CNX, CNY, CNZ);

  input          CN;
  input  [3:0]   PB, GB;
  output         PBo, GBo, CNX, CNY, CNZ;
  
  reg            PBo, GBo, CNX, CNY, CNZ;

  not CNBgate(CNB, CN);

  and PB0GB0gate(PB0GB0, PB[0], GB[0]);
  and CNBGB0gate(CNBGB0, CNB, GB[0]);

  and PB1GB1gate(PB1GB1, PB[1], GB[1]);
  and PB0GB01gate(PB0GB01, PB[0], GB[0], GB[1]);
  and CNBGB01gate(CNBGB01, CNB, GB[0], GB[1]);

  and PB2GB2gate(PB2GB2, PB[2], GB[2]);
  and PB1GB12gate(PB1GB12, PB[1], GB[1], GB[2]);
  and PB0GB012gate(PB0GB012, PB[0], GB[0], GB[1], GB[2]);
  and CNBGB012gate(CNBGB012, CNB, GB[0], GB[1], GB[2]);

  and PB3GB3gate(PB3GB3, PB[3], GB[3]);
  and PB2GB23gate(PB2GB23, PB[2], GB[2], GB[3]);
  and PB1GB123gate(PB1GB123, PB[1], GB[1], GB[2], GB[3]);
  and GB0123gate(GB0123, GB[0], GB[1], GB[2], GB[3]);

  or PBogate(PBo,PB[0],PB[1],PB[2],PB[3]);

  or GBogate(GBo,PB3GB3,PB2GB23,PB1GB123,GB0123);

  nor CNZgate(CNZ,PB2GB2,PB1GB12,PB0GB012,CNBGB012);

  nor CNYgate(CNY,PB1GB1,PB0GB01,CNBGB01);

  nor CNXgate(CNX,PB0GB0,CNBGB0);

  always @(*) begin
    PBo = PBo;
    GBo = GBo;
    CNX = CNX;
    CNY = CNY;
    CNZ = CNZ;
  end

endmodule /* TopLevel74182 */

/*************************************************************************/

module testbench;

  reg            CN;
  reg  [3:0]     PB, GB;
  wire           PBo, GBo, CNX, CNY, CNZ;

  initial begin
    $display("Enter inputs CN, PB[3:0], GB[3:0]:");
    $monitor("Output: PBo=%b, GBo=%b, CNX=%b, CNY=%b, CNZ=%b", PBo, GBo, CNX, CNY, CNZ);
    $monitor("Input: CN=%b, PB=%b, GB=%b", CN, PB, GB);
    $monitor("--------------------------");
    $monitor("Enter 'x' to exit.");
    while (1) begin
      $display("Enter CN:");
      $fscanf("%b", CN);
      $display("Enter PB[3:0]:");
      $fscanf("%b", PB);
      $display("Enter GB[3:0]:");
      $fscanf("%b", GB);
      #1;
    end
  end

  Circuit74182 UUT (.CN(CN), .PB(PB), .GB(GB), .PBo(PBo), .GBo(GBo), .CNX(CNX), .CNY(CNY), .CNZ(CNZ));

endmodule /* testbench */
