"""
Hexadecimal string to Binary file converterr

Author(s):
- Chase Timmins `chase.timmins@gmail.com`

Description:
    Convert hexadecimal string from command line argument into binary and write the result to a file
    defined by hex input
"""
### Import Statements
## Built-In Libraries
import sys

## Internal Libraries

## External Libraries

### Constant Definitions

### Function Definitions

### Class Definitions

### Main

def hex_to_bin(file_name, hex_string):
    # Convert hex string to bytes
    print("Generating Binary Data from Hex string...")
    bin_data = bytes.fromhex(hex_string)
    
    # Write bytes to a .bin file
    with open(file_name, 'wb') as bin_file:
        print(f"Writing Binary Data to {file_name}")
        bin_file.write(bin_data)

def main():
    # Check if the user provided a hex string as a command line argument
    if len(sys.argv) != 3:
        print("Usage: python script.py <file_name> <hex_string>")
        sys.exit(1)
    
    file_name = sys.argv[1]
    hex_string = sys.argv[2]
    hex_to_bin(file_name, hex_string)

if __name__ == '__main__':
    main()
