mul_l1s2:
        mov    r8, [rsi]
        mov    r9, [rdx]
        bt     r8, 62          ; check if montgomery first
        jc     mul_l1ms2
mul_l1ns2:
        bt     r9, 62          ; check if montgomery second
        jc     mul_l1ns2m
mul_l1ns2n:
        mov r11b, 0xC0           # 将r11d左移24位，结果为0xC0000000
        shl r11d, 24
        mov [rdi+4], r11d

        push rsi
        add rsi, 8
        movsx rdx, r9d
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_5               # 如果rdx为非负数，跳转到tmp_5标签 rdx>=0
        neg rdx                 # 否则，将rdx取反（转换为正数）,做*法 rdx<0
        call Fr_rawMMul1        # long * short * R-1
        mov rsi, rdi
        call rawNegL            #对结果取反
        sub rdi, 8
        pop rsi
        
        jmp tmp_6
tmp_5:
        call Fr_rawMMul1
        sub rdi, 8
        pop rsi
tmp_6:



        push rsi
        add rdi, 8
        mov rsi, rdi
        lea rdx, [R3]
        call Fr_rawMMul         #(long * short * R-1) * R3 * R-1
        sub rdi, 8
        pop rsi

        ret


mul_l1ns2m:
        mov r11b, 0x80          #其中一个是M，经过Fr_rawMMul1后变成普通数
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul         #(long * (short * R) * R-1)
        sub rdi, 8
        sub rsi, 8

        ret


mul_l1ms2:
        bt     r9, 62          ; check if montgomery second
        jc     mul_l1ms2m
mul_l1ms2n:
        mov r11b, 0x80          #其中一个是M，经过Fr_rawMMul1后变成普通数
        shl r11d, 24
        mov [rdi+4], r11d

        push rsi
        add rsi, 8
        movsx rdx, r9d
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_7               # 如果rdx为非负数，跳转到tmp_7标签 rdx>=0
        neg rdx                 # 否则，将rdx取反（转换为正数）,做*法 rdx<0
        call Fr_rawMMul1        # (long * R)* short * R-1
        mov rsi, rdi
        call rawNegL            #对结果取反
        sub rdi, 8
        pop rsi
        
        jmp tmp_8
tmp_7:
        call Fr_rawMMul1
        sub rdi, 8
        pop rsi
tmp_8:


        ret

mul_l1ms2m:
        mov r11b, 0xC0          #两个是m，相乘以后也是m
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul         # (long * R)* (short*R) * R-1
        sub rdi, 8
        sub rsi, 8

        ret