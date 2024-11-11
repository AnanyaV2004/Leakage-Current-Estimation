*not_gate*
.include 45nm_MGK.pm

.PARAM supply=1.1
.PARAM Lmin=45nm
.PARAM Wmin=45nm
.PARAM Wp={2*Wmin}

vvdd vdd 0 supply
.global vdd gnd

MP1 pd1 pg1 ps1 pb1 pmos w={Wp} L={Lmin}
MN1 nd1 ng1 ns1 nb1 NMOS W={Wmin} L={Lmin}

Vout out out1 dc 0v

* Voltage sources for nmos
Vng1 ng1 a 0
Vnd1 nd1 out1 0
Vns1 ns1 0 0
Vnb1 nb1 0 0

* voltage sources for pmos
Vpg1 pg1 a 0
Vpd1 pd1 out 0
Vps1 ps1 vdd 0
Vpb1 pb1 vdd 0


*Use below lines for input 
Vin1 a 0 0 

.control
run 
echo "Actual leakage currents" << not.csv
* 0
alter Vin1 = 0
dc TEMP 85 85 10
print V(a)
print V(out) V(out1)
print I(Vng1) I(Vnd1) I(Vns1) I(Vnb1)
print I(Vpg1) I(Vpd1) I(Vps1) I(Vpb1)
print I(Vout) 
* let current_final0 = abs(I(Vng1)) + abs(I(Vnd1)) + abs(I(Vns1)) + abs(I(Vnb1)) + abs(I(Vpg1)) + abs(I(Vpd1)) + abs(I(Vps1)) + abs(I(Vpb1)) 
* echo "0,    $&current_final0" >> not.csv
print I(vvdd)
let leakage_current_0 = abs(I(vvdd))

echo "0,    $&leakage_current_0" >>not.csv

* 1
alter Vin1 = 1.1
dc TEMP 85 85 10
print V(a)
print V(out) V(out1)
print I(Vng1) I(Vnd1) I(Vns1) I(Vnb1)
print I(Vpg1) I(Vpd1) I(Vps1) I(Vpb1)
print I(Vout) 
* let current_final1 = abs(I(Vng1)) + abs(I(Vnd1)) + abs(I(Vns1)) + abs(I(Vnb1)) + abs(I(Vpg1)) + abs(I(Vpd1)) + abs(I(Vps1)) + abs(I(Vpb1)) 
* echo "1,    $&current_final1" >> not.csv
print (I(vvdd)+I(Vin1))
let leakage_current_1 = abs(I(vvdd)+I(Vin1))

echo "1,    $&leakage_current_1" >>not.csv

.endc
.end
    
