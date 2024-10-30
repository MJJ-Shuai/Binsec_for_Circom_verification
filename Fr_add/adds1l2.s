add_s1l2:
        mov    rax, [rsi]
        mov    rcx, [rdx]
        bt     rcx, 62          ; check if montgomery second
        jc     add_s1l2m
add_s1l2n:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        lea rsi, [rdx + 8]  #设置指针 rsi，指向 rdx 所指向内存位置之后的某个偏移量
        movsx rdx, eax      #rsi与rdx数据交换
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_2           # 如果rdx为非负数，跳转到tmp_2标签 rdx>=0
        neg rdx             # 否则，将rdx取反（转换为正数）,做减法 rdx<0
        call rawSubLS
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret
tmp_2:
        call rawAddLS
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


add_s1l2m:
        bt     rax, 62          ; 检查rcx的第62位（倒数第3位）是否为1，判断是否为蒙哥马利形式
        jc     add_s1ml2m       ; 如果是蒙哥马利形式，跳转
add_s1nl2m:
        mov r11b, 0xC0          #将 r11d 左移24位，结果为 0xC0000000
        shl r11d, 24
        mov [rdi+4], r11d

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rdx
        push r8
        call Fr_toMontgomery
        mov  rsi, rdi
        pop  rdi
        pop  rdx


        add rdi, 8
        add rsi, 8
        add rdx, 8
        call rawAddLL
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


add_s1ml2m:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        add rdx, 8
        call rawAddLL
        sub rdi, 8
        sub rsi, 8
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret
