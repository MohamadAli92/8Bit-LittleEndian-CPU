def float_bin(number, places=3):
    whole, dec = str(number).split(".")

    whole = int(whole)
    dec = int(dec)

    res = bin(whole).lstrip("0b") + "."

    for x in range(places):
        whole, dec = str((decimal_converter(dec)) * 2).split(".")

        dec = int(dec)

        res += whole

    return res


def decimal_converter(num):
    while num > 1:
        num /= 10
    return num


def bin_digits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % bits).format(s)


def binaryToDecimal(bin_w):
    if bin_w == 0:
        return 0
    else:
        bin_w = int("0b" + str(bin_w), 2)
        decimal, ic, n = 0, 0, 0
        while bin_w != 0:
            dec = bin_w % 10
            decimal = decimal + dec * pow(2, i)
            bin_w = bin_w // 10
            ic += 1
        return decimal


registers = {0: 0, 1: 0, 2: 0, 3: 0}


def cal_res(command, reg1, reg_op):
    result = 0
    if command == 0:
        registers[reg1] = reg_op
        result = reg_op
    elif command == 1:
        registers[reg1] = registers[reg_op]
        result = registers[reg1]
    elif command == 2:
        registers[reg1] += reg_op
        result = registers[reg1]
    elif command == 3:
        registers[reg1] += registers[reg_op]
        result = registers[reg1]
    elif command == 4:
        registers[reg1] -= reg_op
        result = registers[reg1]
    elif command == 5:
        registers[reg1] -= registers[reg_op]
        result = registers[reg1]
    elif command == 6:
        temp = bin_digits(registers[reg1] * reg_op, 16)
        registers[3] = binaryToDecimal(int(temp[0:8]))
        registers[0] = binaryToDecimal(int(temp[8:16]))
        result = registers[reg1] * reg_op
    elif command == 7:
        temp = bin_digits(registers[reg1] * registers[reg_op], 16)
        registers[3] = binaryToDecimal(int(temp[0:8]))
        registers[0] = binaryToDecimal(int(temp[8:16]))
        result = registers[reg1] * registers[reg_op]
    elif command == 8:
        registers[reg1] = registers[reg1] >> reg_op
        result = registers[reg1]
    elif command == 9:
        registers[reg1] = registers[reg1] << reg_op
        result = registers[reg1]
    elif command == 10:
        number = float(str(binaryToDecimal(bin_digits(reg1, 8))) + "." + str(binaryToDecimal(bin_digits(reg_op, 8))))
        temp = float_bin(number, places=7)
        temp2 = ""
        for char in temp:
            if char != '.':
                temp2 += char

        if reg1 < 0:
            result = "11000000" + temp2
        else:
            result = "01000000" + temp2

        registers[1] = binaryToDecimal(str(result)[0] + str(result)[9:16])
        registers[2] = binaryToDecimal(str(result[1:9]))

    for reg_n in registers:
        print(str(reg_n) + " : " + bin_digits(registers[reg_n], 8))
        f2.write(str(reg_n) + " : " + bin_digits(registers[reg_n], 8) + '\n')
    if command != 10:
        f2.write('Result : ' + bin_digits(result, 8) + '\n')
    else:
        f2.write('Result : ' + result[0:17] + '\n')


f = open("code.txt", "w")
f2 = open("results.txt", "w")

codes = ['0001', '0010',
         '0011', '0100',
         '0101', '0110',
         '0111', '1000',
         '1011', '1100',
         '1101']

regs = ['00000001',
        '00000010',
        '00000100',
        '00001000']

commands = ['Reg = Operand', 'Reg1 = Reg2',
            'Reg += Operand', 'Reg1 += Reg2',
            'Reg -= Operand', 'Reg1 -= Reg2',
            'RegD = (Reg * Operand)[15:8] && RegA = (Reg * Operand)[7:0]',
            'RegD = (Reg1 * Reg2)[15:8] && RegA = (Reg1 * Reg2)[7:0]',
            'Reg = Reg >> Operand', 'Reg = Reg >> Operand',
            'RegC = Exponent && RegB = Sign,Mantissa']

reg_name = ['RegA', 'RegB', 'RegC', 'RegD']

operand_operators = [1, 3, 5, 7, 9, 10]

c = 0

while c < 24:
    code = ''
    for i in range(11):
        print(f'{i+1} - {commands[i]}\n')
    op = int(input("Type from 1 - 10 for operation or 0 to exit: "))
    if op == 0:
        break
    elif op == 11:
        num1 = int(input("Enter natural part of number: "))
        num2 = int(input("Enter mantissa part of number: "))

        code += codes[op-1] + bin_digits(num1, 8) + bin_digits(num2, 8)

        cal_res(op-1, num1, num2)
    else:
        code += codes[op-1]
        code += '_'

        print('\n')
        for i in range(4):
            print(f'{i+1} - {regs[i]}\n')
        reg = int(input("Type from 1 - 4 for registers or 0 to exit: "))
        if reg == 0:
            break
        code += regs[reg-1]
        code += '_'

        if op in operand_operators:
            operand = int(input("Type operand value : "))
            code += bin_digits(operand, 8)

            cal_res(op-1, reg-1, operand)
        else:
            print('\n')
            for i in range(4):
                print(f'{i + 1} - {regs[i]}\n')
            reg2 = int(input("Type form 1 - 4 for registers or 0 to exit: "))
            if reg2 == 0:
                break
            code += regs[reg2-1]

            cal_res(op, reg-1, reg2-1)

    print(f'\nThe Code is : {code}\n')
    confirm = int(input("Do you confirm it? (1:Yes 0:No)\n"))
    if confirm == 1:
        f.write(code + '\n')
        c += 1

f2.close()
f.close()
