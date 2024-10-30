sub_s1l2:
        mov    rax, [rsi]
        mov    rcx, [rdx]
        bt     rcx, 62          ; check if montgomery first
        jc     sub_s1l2m
sub_s1l2n:
        mov r11b, 0x80          # 将r11d左移24位，结果为0x80000000
        shl r11d, 24
        mov [rdi+4], r11d

        cmp eax, 0
        
        js tmp_4                 # 如果eax为负数，跳转到tmp_4标签 rsi<0

                                ; First Operand is positive
        push rsi
        add rdi, 8
        movsx rsi, eax           
        add rdx, 8
        call rawSubSL           #rsi - [rdx + 8, 32]
        sub rdi, 8
        pop rsi
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret

tmp_4:                          ; First operand is negative
        push rsi
        lea rsi, [rdx + 8]      #将rdx与rsi指向的值交换
        movsx rdx, eax
        add rdi, 8
        neg rdx                 # -rsi
                                #Fr_rawq - rdx: rsi on field q
        call rawNegLS           #Result = Fr_rawq - rdx - [rsi + 8,32]，如果有进位，则 Result += Fr_rawq
        sub rdi, 8
        pop rsi
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


sub_s1l2m:
        bt     rax, 62          ; check if montgomery second
        jc     sub_s1ml2m
sub_s1nl2m:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rdx
        push r8
        call Fr_toMontgomery     #将 rsi 转换为蒙哥马利形式。
        mov  rsi, rdi
        pop  rdi
        pop  rdx


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


sub_s1ml2m:
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