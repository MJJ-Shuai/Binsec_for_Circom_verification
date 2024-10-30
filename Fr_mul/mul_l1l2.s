mul_l1l2:
        mov    r8, [rsi]
        mov    r9, [rdx]
        bt     r8, 62          ; check if montgomery first
        jc     mul_l1ml2
mul_l1nl2:
        bt     r9, 62          ; check if montgomery second
        jc     mul_l1nl2m
mul_l1nl2n:
        mov r11b, 0xC0          # 将r11d左移24位，结果为0xC0000000
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul         # long * long * R-1
        sub rdi, 8
        sub rsi, 8


        push rsi
        add rdi, 8
        mov rsi, rdi
        lea rdx, [R3]
        call Fr_rawMMul         # (long * long * R-1) * R3 * R-1
        sub rdi, 8
        pop rsi

        ret

mul_l1nl2m:
        mov r11b, 0x80          #其中一个是M，经过Fr_rawMMul后变成普通数
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul         # (long * R)* long * R-1
        sub rdi, 8
        sub rsi, 8

        ret

mul_l1ml2:
        bt     r9, 62          ; check if montgomery second
        jc     mul_l1ml2m
mul_l1ml2n:
        mov r11b, 0x80          #其中一个是M，经过Fr_rawMMul后变成普通数
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul         # (long * R)* long * R-1
        sub rdi, 8
        sub rsi, 8

        ret

mul_l1ml2m:
        mov r11b, 0xC0          #两个是m，相乘以后也是m
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call Fr_rawMMul         # (long * R) * (long * R) * R-1
        sub rdi, 8
        sub rsi, 8

        ret

