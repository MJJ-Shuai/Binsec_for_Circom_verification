mul_s1l2:
        mov    r8, [rsi]
        mov    r9, [rdx]
        bt     r8, 62          ; check if montgomery first
        jc     mul_s1ml2
mul_s1nl2:
        bt     r9, 62          ; check if montgomery second
        jc     mul_s1nl2m
mul_s1nl2n:
        mov r11b, 0xC0          # 将r11d左移24位，结果为0xC0000000
        shl r11d, 24
        mov [rdi+4], r11d

        push rsi
        lea rsi, [rdx + 8]      #交换rsi与rdx的值
        movsx rdx, r8d
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_9               # 如果rdx为非负数，跳转到tmp_9标签 rdx>=0
        neg rdx                 # 否则，将rdx取反（转换为正数）,做*法 rdx<0
        call Fr_rawMMul1        # long * short * R-1
        mov rsi, rdi
        call rawNegL            #对结果取反
        sub rdi, 8
        pop rsi
        
        jmp tmp_10
tmp_9:
        call Fr_rawMMul1
        sub rdi, 8
        pop rsi
tmp_10:



        push rsi
        add rdi, 8
        mov rsi, rdi
        lea rdx, [R3]
        call Fr_rawMMul         #(long * short * R-1) * R3 * R-1
        sub rdi, 8
        pop rsi

        ret

mul_s1nl2m:
        mov r11b, 0x80          #其中一个是M，经过Fr_rawMMul1后变成普通数
        shl r11d, 24
        mov [rdi+4], r11d

        push rsi
        lea rsi, [rdx + 8]      #交换rsi与rdx的值
        movsx rdx, r8d
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_11              # 如果rdx为非负数，跳转到tmp_11标签 rdx>=0
        neg rdx                 # 否则，将rdx取反（转换为正数）,做*法 rdx<0
        call Fr_rawMMul1        # (long * R)* short * R-1
        mov rsi, rdi
        call rawNegL            #对结果取反
        sub rdi, 8
        pop rsi
        
        jmp tmp_12
tmp_11:
        call Fr_rawMMul1
        sub rdi, 8
        pop rsi
tmp_12:


        ret

mul_s1ml2:
        bt     r9, 62          ; check if montgomery first
        jc     mul_s1ml2m
mul_s1ml2n:
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

mul_s1ml2m:
        mov r11b, 0xC0          #两个是m，相乘以后也是m
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul          # (long * R)* (short*R) * R-1
        sub rdi, 8
        sub rsi, 8

        ret