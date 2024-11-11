import csv

# Function to map voltage to 0 or 1
def map_voltage(voltage):
    threshold = 0.05  # Adjust threshold as needed
    if abs(voltage - 1.1) < threshold:
        return 1
    elif abs(voltage) < threshold:
        return 0
    else:
        return None  # No mapping found

# Function to preload data from csv files
def preload_csv_data():
    nor_data = {}
    with open('Gate_output/nor.csv', 'r') as nor_file:
        nor_reader = csv.reader(nor_file)
        for row in nor_reader:
            input1, input2, leakage = row
            nor_data[(int(input1), int(input2))] = float(leakage)

    not_data = {}
    with open('Gate_output/not.csv', 'r') as not_file:
        not_reader = csv.reader(not_file)
        for row in not_reader:
            input1, leakage = row
            not_data[int(input1)] = float(leakage)

    nand_data = {}
    with open('Gate_output/nand.csv', 'r') as nand_file:
        nand_reader = csv.reader(nand_file)
        for row in nand_reader:
            input1, input2, leakage = row
            nand_data[(int(input1), int(input2))] = float(leakage)

    return nor_data, not_data, nand_data

# Function to process input CSV and write output CSV
def process_csv(input_file, output_file, nor_data, not_data, nand_data):
    total_leakage_current = 0

    with open(input_file, 'r') as csvfile, open(output_file, 'w', newline='') as outputcsv:
        reader = csv.reader(csvfile)
        writer = csv.writer(outputcsv)
        writer.writerow(['gate', 'gate_name', 'input1_mapped', 'input2_mapped', 'leakage_current'])

        for row in reader:
            gate, gate_name, input1, input2 = row
            mapped_input1 = map_voltage(float(input1.strip()))
            mapped_input2 = map_voltage(float(input2.strip()))
            if gate.startswith('nor'):
                leakage = nor_data.get((mapped_input1, mapped_input2), None)
            elif gate.startswith('not'):
                leakage = not_data.get(mapped_input1, None)
            elif gate.startswith('nand'):
                leakage = nand_data.get((mapped_input1, mapped_input2), None)
            else:
                leakage = None

            if mapped_input1 is not None and mapped_input2 is not None and leakage is not None:
                total_leakage_current += leakage
                writer.writerow([gate, gate_name, mapped_input1, mapped_input2, leakage])
            else:
                # If voltage or leakage data doesn't match criteria, keep original values
                writer.writerow([gate, gate_name, input1.strip(), input2.strip(), ''])

    return total_leakage_current
# Preload data from csv files

def get_current_mos():
    nor_data, not_data, nand_data = preload_csv_data()

    # Example usage:
    input_file = 'output.csv'
    output_file = 'mapped_output.csv'
    total_leakgae_current = process_csv(input_file, output_file, nor_data, not_data, nand_data)

    return total_leakgae_current


total_leakage_current = get_current_mos()
print("Mapping completed. Results saved to 'mapped_output.csv'")
print('Total Leakage current is: ', total_leakage_current)


