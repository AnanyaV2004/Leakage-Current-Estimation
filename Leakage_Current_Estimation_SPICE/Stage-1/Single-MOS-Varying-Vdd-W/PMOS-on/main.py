import os
width = 45
base_width = 45
multiply = [1,2,4,6,8]
for multiple in multiply:
    
    width = base_width * multiple
    file_ptr = open("pmos_on.net" , "r")
    file_ptr_write = open("ass_python.net" , "w")

    for line in file_ptr:
        #read replace the string and write to output file
        str = f".PARAM Wmin={width}n"
        # print(str)
        file_ptr_write.write(line.replace('.PARAM Wmin=45n', str))
      
    file_ptr_write.close()
    file_ptr.close()

    # file_ptr_write2 = open("ass_python2.cir" , "w")
    # file_ptr_read2 = open("ass_python.cir","r")

    # for line in file_ptr_read2:
    #     #read replace the string and write to output file
    #     str = f"let t = {t}"
   
    #     file_ptr_write2.write(line.replace("let t = 0", str))
      
    # file_ptr_write2.close()
    # file_ptr_read2.close()
    
    cmd = "ngspice ass_python.net"
    os.system(cmd)
    #os.ngspice.system("quit") 