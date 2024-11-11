*NAND_gate*
.include 45nm_MGK.pm
.TEMP 85
.PARAM supply=1.1
.PARAM Lmin=45nm
.PARAM Wmin=45nm
.PARAM Wp={2*Wmin}

vvdd vdd 0 supply
.global vdd gnd


MP1 pd1 pg1 ps1 pb1 pmos w={Wp} L={Lmin}
MP2 pd2 pg2 ps2 pb2 pmos w={Wp} L={Lmin}

MN1 nd1 ng1 ns1 nb1 NMOS W={Wmin} L={Lmin}
MN2 nd2 ng2 ns2 nb2 NMOS W={Wmin} L={Lmin}




* Xn a b out interm interm1 out1 nand

Vinterm interm interm1 dc 0v
Vout out out1 dc 0v

* * Connections for nmos 
* MN1 nd1 ng1 ns1 nb1 nmos W={Wmin} L={Lmin}
* MN2 nd2 ng2 ns2 nb2 nmos W={Wmin} L={Lmin}

* * Connections for pmos
* MP1 pd1 pg1 ps1 pb1 pmos W={Wp} L={Lmin}
* MP2 pd2 pg2 ps2 pb2 pmos W={Wp} L={Lmin}

* Voltage sources for nmos
Vng1 ng1 a 0
Vng2 ng2 b 0
Vnd1 nd1 out1 0
Vnd2 nd2 interm1 0
Vns1 ns1 interm 0
Vns2 ns2 0 0
Vnb1 nb1 0 0
Vnb2 nb2 0 0

* voltage sources for pmos
Vpg1 pg1 a 0
Vpg2 pg2 b 0
Vpd1 pd1 out  0
Vpd2 pd2 out  0
Vps1 ps1 vdd  0
Vps2 ps2 vdd  0
Vpb1 pb1 vdd  0
Vpb2 pb2 vdd  0


* Use below lines for input 
* V1 a alim 0
* V2 b blim 0
Vin1 a 0 0 
Vin2 b 0 0 

.control
run 
echo "Actual leakage currents" << nand.csv
* 00
alter Vin1 = 0
alter Vin2 = 0
dc TEMP 85 85 10
print V(a) V(b) 
print V(out) V(out1) V(interm) V(interm1)
print I(Vng1) I(Vnd1) I(Vns1) I(Vnb1)
print I(Vpg1) I(Vpd1) I(Vps1) I(Vpb1)
print I(Vng2) I(Vnd2) I(Vns2) I(Vnb2)
print I(Vpg2) I(Vpd2) I(Vps2) I(Vpb2)
print I(Vout) I(Vinterm)
let current_final00 = abs(I(Vng1)) + abs(I(Vnd1)) + abs(I(Vns1)) + abs(I(Vnb1)) + abs(I(Vpg1)) + abs(I(Vpd1)) + abs(I(Vps1)) + abs(I(Vpb1)) + abs(I(Vng2)) + abs(I(Vnd2)) + abs(I(Vns2)) + abs(I(Vnb2)) + abs(I(Vpg2)) + abs(I(Vpd2)) + abs(I(Vps2)) + abs(I(Vpb2))
* echo "0,    0,  $&current_final00" >> nand.csv
let leakage_current_00 = abs(I(vvdd))
echo "$&leakage_current_00" >>nand.csv
print ((I(vvdd)))
* 01
alter Vin1 = 0
alter Vin2 = 1.1
dc TEMP 85 85 10
print V(a) V(b) 
print V(out) V(out1) V(interm) V(interm1)
print I(Vng1) I(Vnd1) I(Vns1) I(Vnb1)
print I(Vpg1) I(Vpd1) I(Vps1) I(Vpb1)
print I(Vng2) I(Vnd2) I(Vns2) I(Vnb2)
print I(Vpg2) I(Vpd2) I(Vps2) I(Vpb2)
print I(Vout) I(Vinterm)
let current_final01 = abs(I(Vng1)) + abs(I(Vnd1)) + abs(I(Vns1)) + abs(I(Vnb1)) + abs(I(Vpg1)) + abs(I(Vpd1)) + abs(I(Vps1)) + abs(I(Vpb1)) + abs(I(Vng2)) + abs(I(Vnd2)) + abs(I(Vns2)) + abs(I(Vnb2)) + abs(I(Vpg2)) + abs(I(Vpd2)) + abs(I(Vps2)) + abs(I(Vpb2))
* echo "0,    1,  $&current_final01" >> nand.csv
print ((I(vvdd)) + (I(Vin2)))
let leakage_current_01 = abs(I(vvdd) + I(Vin2))
echo "$&leakage_current_01" >>nand.csv
* 10
alter Vin1 = 1.1
alter Vin2 = 0
dc TEMP 85 85 10
print V(a) V(b) 
print V(out) V(out1) V(interm) V(interm1)
print I(Vng1) I(Vnd1) I(Vns1) I(Vnb1)
print I(Vpg1) I(Vpd1) I(Vps1) I(Vpb1)
print I(Vng2) I(Vnd2) I(Vns2) I(Vnb2)
print I(Vpg2) I(Vpd2) I(Vps2) I(Vpb2)
print I(Vout) I(Vinterm)
print I(Vin1) I(Vin2)
* let current_final10 = abs(I(Vng1)) + abs(I(Vnd1)) + abs(I(Vns1)) + abs(I(Vnb1)) + abs(I(Vpg1)) + abs(I(Vpd1)) + abs(I(Vps1)) + abs(I(Vpb1)) + abs(I(Vng2)) + abs(I(Vnd2)) + abs(I(Vns2)) + abs(I(Vnb2)) + abs(I(Vpg2)) + abs(I(Vpd2)) + abs(I(Vps2)) + abs(I(Vpb2))
* let current_final10 = abs(I())
* echo "1,    0,  $&current_final10" >> nand.csv
print ((I(vvdd)) + (I(Vin1)) )
let leakage_current_10 = abs(I(vvdd) + I(Vin1))
echo "$&leakage_current_10" >>nand.csv
* 11
alter Vin1 = 1.1
alter Vin2 = 1.1
dc TEMP 85 85 10
print V(a) V(b) 
print V(out) V(out1) V(interm) V(interm1)
print I(Vng1) I(Vnd1) I(Vns1) I(Vnb1)
print I(Vpg1) I(Vpd1) I(Vps1) I(Vpb1)
print I(Vng2) I(Vnd2) I(Vns2) I(Vnb2)
print I(Vpg2) I(Vpd2) I(Vps2) I(Vpb2)
print I(Vout) I(Vinterm)
let current_final11 = abs(I(Vng1)) + abs(I(Vnd1)) + abs(I(Vns1)) + abs(I(Vnb1)) + abs(I(Vpg1)) + abs(I(Vpd1)) + abs(I(Vps1)) + abs(I(Vpb1)) + abs(I(Vng2)) + abs(I(Vnd2)) + abs(I(Vns2)) + abs(I(Vnb2)) + abs(I(Vpg2)) + abs(I(Vpd2)) + abs(I(Vps2)) + abs(I(Vpb2))
* echo "1,    1,  $&current_final11" >> nand.csv
print ((I(vvdd)) + (I(Vin1)) + (I(Vin2)))
let leakage_current_11 = abs(I(vvdd) + I(Vin1) + I(Vin2))

echo "$&leakage_current_11" >>nand.csv

.endc
.end
    
