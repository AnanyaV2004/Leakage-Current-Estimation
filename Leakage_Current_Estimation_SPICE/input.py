import itertools
import subprocess
from cal_current_cir import get_current_cir
from cal_current_mos import get_current_mos
import os

def generate_combinations(num_inputs):
    return list(itertools.product([0, 1], repeat=num_inputs))

def callculate_error(leakage_current_cir, leakage_current_mos):
    error = (abs(leakage_current_cir - leakage_current_mos)/abs(leakage_current_cir))*10
    return error

def modify_circuit_net(num_inputs, circuit_net_file):
    combinations = generate_combinations(num_inputs)

    with open(circuit_net_file, 'r') as file:
        lines = file.readlines()

    input_lines = [line.strip() for line in lines if line.startswith('V')]
    num_input_lines = len(input_lines)

    if num_inputs != num_input_lines:
        print(f"Number of inputs in circuit.net file doesn't match specified inputs ({num_inputs}).")
        return

    min_error = 10000
    max_error = 0
    total_error = 0

    f = open('Error.csv', "w")
    f.write(f'Combination, leakage_current_cir, leakage_current_mos, error\n')
    f.close()
    
    for combination in combinations:

        modified_lines = []
        for line, input_value in zip(input_lines, combination):
            parts = line.split()
            parts[-1] = str(input_value)
            modified_lines.append(' '.join(parts) + '\n')

        modified_file = f"{circuit_net_file[:-4]}_combination.net"
        print(combination)
        combination_str = ''.join(map(str, combination))

        with open(modified_file, 'w') as file:
            for i, line in enumerate(lines):
                if line.strip() in input_lines:
                    file.write(modified_lines[input_lines.index(line.strip())])
                else:
                    file.write(line)
        
        os.remove('Currents.csv')
        os.remove('mapped_output.csv')
        os.remove('output.csv')
        result = subprocess.run(['ngspice', 'Circuit_combination.net'])
        print('Executed')
        if result.returncode == 0:
            # Command executed successfully, proceed with the rest of the code
            leakage_current_mos = get_current_mos()
            leakage_current_cir = get_current_cir()
        else:
            # Command failed
            print("Error: ngspice command failed.")

        print(leakage_current_cir, leakage_current_mos)
        error = callculate_error(leakage_current_cir, leakage_current_mos)
        min_error = min(min_error, error)
        max_error = max(max_error, error)
        total_error += error

        f = open('Error.csv', "a")
        f.write(f'{combination_str},{leakage_current_cir}, {leakage_current_mos}, {error}\n')
        f.close()
        
    return max_error, min_error, total_error/512


        
# Example usage:
num_inputs = 9  # Modify based on the number of inputs you have
circuit_net_file = 'Circuit.net'  # Specify the path to your circuit.net file

matrix = modify_circuit_net(num_inputs, circuit_net_file)
print(matrix)
