import csv

def read_current_csv():
    data_map = {}
    with open('Currents.csv', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        
        # Print the header row
        print(reader.fieldnames)
        
        for row in reader:
            # Convert the 'Value' column to float and store it in the dictionary with 'Name' as key
            data_map[row['Name']] = float(row[' Value'])
    
    return data_map
    
def get_current_cir():

    data_map = read_current_csv()
    total_current = abs(data_map['Vvdd'])

    with open('Circuit.net', 'r') as file:
        lines = file.readlines()
        input_lines = [line.strip() for line in lines if line.startswith('V')]

    # print(input_lines)
    for line in input_lines:
        if(line[-1:] == '1'):
            # print(line[:3], abs(data_map[line[:3]]))
            total_current += abs(data_map[line[:3]])

    return total_current

total_current = get_current_cir()
print(total_current)