add_l1ns2:
        mov    rax, [rsi]
        mov    rcx, [rdx]
        mov r11b, 0x80  # 将r11d左移24位，结果为0x80000000
        shl r11d, 24
        mov [rdi+4], r11d

        add rsi, 8
        movsx rdx, ecx
        add rdi, 8
        cmp rdx, 0
        
        jns tmp_1   # 如果rdx为非负数，跳转到tmp_1标签 rdx>=0
        neg rdx     # 否则，将rdx取反（转换为正数）,做减法 rdx<0
        call rawSubLS
        sub rdi, 8
        sub rsi, 8

        ret
tmp_1:
        call rawAddLS
        sub rdi, 8
        sub rsi, 8

        ret

    .type add_l1ns2,@function
	.size add_l1ns2,. - add_l1ns2
