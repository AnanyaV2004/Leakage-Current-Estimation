module testbench;

  reg            CN;
  reg  [3:0]     PB, GB;
  wire           PBo, GBo, CNX, CNY, CNZ;

  // Instantiate the DUT (Design Under Test)
  Circuit74182 UUT (.CN(CN), .PB(PB), .GB(GB), .PBo(PBo), .GBo(GBo), .CNX(CNX), .CNY(CNY), .CNZ(CNZ));

  initial begin
    // Hardcoded inputs
    CN = 0;           // Example value for CN
    GB = 4'b1011;     // Example value for GB
    PB = 4'b0101;     // Example value for PB

    // Simulate some delay
    #1;

    // Display inputs
    $display("Inputs: CN=%b PB=%b GB=%b", CN, PB, GB);

    // Simulate some more delay
    #1;
  end

  // Display outputs
  always @* begin
    $display("Outputs: PBo=%b GBo=%b CNX=%b CNY=%b CNZ=%b", PBo, GBo, CNX, CNY, CNZ);
  end

endmodule /* testbench */
