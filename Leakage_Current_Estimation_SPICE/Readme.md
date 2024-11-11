# LEAKAGE CURRENT ESTIMATION

## Folder Structure

- **Project-1/**:
    - **Gate_output/**
        - **nand.csv**
        - **nor.csv**
        - **not.csv**
    - **Stage-1/**
      - **Single-MOS-Varying-Vg-Vs-Vd/**
        - **45nm_MGK.pm**
        - **nmos.ckt**
        - **nmos.csv**
        - **pmos.ckt**
        - **pmos.csv**
      - **Single-MOS-Varying-Vdd-W/**
        - **NMOS-off** (similarly for pmos_on, pmos_off, nmos_on, nmos_off)
          - **main.py**
          - **nmos_off.net**
    - **Stage-2/**: Contains data models.
        - **45nm_MGK.pm**
        - **nand.sp**
        - **nor.sp**
        - **not.sp**
    - **45nm_MGK.pm**
    - **cal_current_cir.py**
    - **cal_current_mos.py**
    - **Circuit.net**
    - **input.py**
    - **README.md**
    - **Currents.csv**: Not present intially but created upon running "Circuit.net"
    - **output.csv** : Not present intially but created upon running "Circuit.net"
    - **mapped_output.csv** : Not present intially but created upon running "cal_current_mos.py"

This structure provides a clear organization of the project's files and directories.

## Purpose of each file:

- **Project-1/**:
    - **Gate_output/** : has the total leakage current of individual nand, nor, not gate calculated in stage-2
        - **nand.csv** : estimated leakage currents of a nand gate for 00,01,10,11 input combinations
        - **nor.csv** : estimated leakage currents of a nor gate for 00,01,10,11 input combinations
        - **not.csv** : estimated leakage currents of a not gate for 0,1 input combinations
    - **Stage-1/Single-MOS-Varying-Vg-Vs-Vd** : Codes and outputs of stage-1/Single-MOS-Varying-Vg-Vs-Vd
        - **45nm_MGK.pm** : MOSFET model file
        - **nmos.ckt** : calculates the currents across drain, gate, source and body terminal of an nmos for different combinations of drain, gate, source voltages and outputs them to "nmos.csv"
        - **nmos.csv**: has outputs from nmos.ckt in the format: <br> 
            `V(drain), V(gate), V(source), I(drain), I(gate), I(source), I(body)`
        - **pmos.ckt** : calculates the currents across drain, gate, source and body terminal of a pmos for different combinations of drain, gate, source voltages and outputs them to "pmos.csv"
        - **pmos.csv**: has outputs from nmos.ckt in the format: <br>
            `V(drain), V(gate), V(source), I(drain), I(gate), I(source), I(body)`
    
    - **Stage-1/Single-MOS-Varying-Vdd-W**: COdes and outputs of Stage-1/Single-MOS-Varying-Vdd-W
      - **Folders**: Contains  4 folders: NMOS-off, NMOS-on, PMOS-on, PMOS-off.
      - Each folder has following files:
        - **Parameter file**
        - **main.py**: Python script to vary the W/L ratio.
        - **<folder_name>.net**: The original circuit file 
        - **out.csv**: Output file were we store results in followign order:
            `Width, V_alim, V(drain), V(gate), V(source), V(body), I(Vd), I(Vg), I(Vs), I(Vb)`
    - **Stage-2/**: Calculation and verification of leakage currents for nad, nor, not
        - **45nm_MGK.pm**: MOSFET model file
        - **nand.sp**: has nand circuit simulated and prints voltage and current across each terminal of each mosfet and also prints leakage current for each combination to verify against manually calculated leakage current
        - **nor.sp**: has nor circuit simulated and prints voltage and current across each terminal of each mosfet and also prints leakage current for each combination to verify against manually calculated leakage current
        - **not.sp**: has not circuit simulated and prints voltage and current across each terminal of each mosfet and also prints leakage current for each combination to verify against manually calculated leakage current
    - **45nm_MGK.pm** : MOSFET model file
    - **cal_current_cir.py**: calculates actual current across entire circuit for verification for a given input combination.
    - **cal_current_mos.py**: python script to calculate estimayted leakage current for a given input combination.
    - **Circuit.net**: Has the entire ISCAS 74182 circuit simulated. This outputs the input voltage values at every gate present in the entire circuit in "output.csv"
    - **input.py** : Calculates estimated and actual currents for all input combinations with 9 inputs and claculates error percentage for each combination.
    - **README.md**
    - **Currents.csv**: Not present intially but created upon running "Circuit.net"
    - **output.csv** : Not present intially but created upon running "Circuit.net"
    - **mapped_output.csv** : Not present intially but created upon running "cal_current_mos.py"
    - **errors.csv** : Not present intially but created upon running "input.py"

## How to run for a given input

First of all, we need to run Circuit.net by changing the Voltage source values of inputs accordingly. <br>
`ngspice Circuit.net`
This will create output.csv and Currents.csv. 

Then run:
<br>
`python3 cal_current_cir`
<br>
This will give the actual leakage current printed on the terminal

Then run: 
<br>
`python3 cal_current_cir`
<br>
This will give the estimated leakage current printed on the terminal

## How to run for all inputs to get error percentages:

Run:
<br>
`python3 input.py` <br>
This creates errors.csv, that has errpr percentages for allinput combinations for the 9 inputs.