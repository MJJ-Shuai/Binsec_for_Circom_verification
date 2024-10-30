sub_l1s2:
        mov    rax, [rsi]
        mov    rcx, [rdx]
        bt     rax, 62          ; check if montgomery first
        jc     sub_l1ms2
sub_l1ns2:
        mov r11b, 0x80          # 将r11d左移24位，结果为0x80000000
        shl r11d, 24
        mov [rdi+4], r11d

        add rsi, 8
        movsx rdx, ecx
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_3               # 如果rdx为非负数，跳转到tmp_3标签 rdx>=0
        neg rdx                 # 否则，将rdx取反（转换为正数）,做+法 rdx<0
        call rawAddLS
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret
tmp_3:
        call rawSubLS
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


sub_l1ms2:
        bt     rcx, 62          ; 检查rcx的第62位（倒数第3位）是否为1，判断是否为蒙哥马利形式
        jc     sub_l1ms2m       ; 如果是蒙哥马利形式，跳转到sbb_l1ms2m
sub_l1ms2n:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rsi
        mov  rsi, rdx
        push r8
        call Fr_toMontgomery    #将 rdx 转换为蒙哥马利形式。
        mov  rdx, rdi
        pop  rdi
        pop  rsi


        add rdi, 8
        add rsi, 8
        add rdx, 8
        call rawSubLL
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


sub_l1ms2m:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call rawSubLL
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret