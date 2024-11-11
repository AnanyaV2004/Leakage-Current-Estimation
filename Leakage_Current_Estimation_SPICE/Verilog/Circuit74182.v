module Circuit74182 (CN, PB, GB, PBo, GBo, CNX, CNY, CNZ);

  input         CN;
  input [3:0]   PB, GB;
  output        PBo, GBo, CNX, CNY, CNZ;
	
  TopLevel74182 Ckt74182 (CN, PB, GB, PBo, GBo, CNX, CNY, CNZ);

endmodule /* Circuit74182 */