add_l1ms2:
        mov    rax, [rsi]
        mov    rcx, [rdx]
        bt     rcx, 62          ; 检查rcx的第62位（倒数第3位）是否为1，判断是否为蒙哥马利形式
        jc     add_l1ms2m       ; 如果是蒙哥马利形式，跳转到add_l1ms2m
add_l1ms2n:
        mov r11b, 0xC0
        shl r11d, 24            #将 r11d 左移24位，结果为 0xC0000000。
        mov [rdi+4], r11d


        call Fr_toMontgomery    #将 rdx 转换为蒙哥马利形式。



        add rdi, 8
        add rsi, 8
        add rdx, 8
        call rawAddLL
        sub rdi, 8
        sub rsi, 8

        ret


add_l1ms2m:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call rawAddLL
        sub rdi, 8
        sub rsi, 8

        ret