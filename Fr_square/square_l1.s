square_l1:
        mov    r8, [rsi]
        bt     r8, 62          ; check if montgomery first
        jc     square_l1m
square_l1n:
        mov r11b, 0xC0          # 将r11d左移24位，结果为0xC0000000
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        call Fr_rawMSquare      # long * long * R-1
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

square_l1m:
        mov r11b, 0xC0          #两个是m，相乘以后也是m
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        call Fr_rawMSquare      # (long * R) * (long * R) * R-1
        sub rdi, 8
        sub rsi, 8

        ret

