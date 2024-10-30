#还是先判断是否是蒙哥马利数，有其中之一是的话，
#就要转成普通长整型数，
#如果都不是的话，可以直接进行长整型的与运算
and_l1l2:
        bt     rax, 62          ; check if montgomery first
        jc     and_l1ml2
        bt     rcx, 62          ; check if montgomery first
        jc     and_l1nl2m
and_l1nl2n:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d


        mov rax, [rsi + 8]
        and rax, [rdx + 8]

        mov    [rdi + 8 ], rax

        mov rax, [rsi + 16]
        and rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        mov rax, [rsi + 24]
        and rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        mov rax, [rsi + 32]
        and rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_37        ; q is bigget so done.
        jnz tmp_36         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_37        ; q is bigget so done.
        jnz tmp_36         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_37        ; q is bigget so done.
        jnz tmp_36         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_37        ; q is bigget so done.
        jnz tmp_36         ; q is lower

        ; If equal substract q
tmp_36:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_37:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


and_l1nl2m:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rsi
        mov  rsi, rdx
        push r8
        call Fr_toNormal
        mov  rdx, rdi
        pop  rdi
        pop  rsi



        mov rax, [rsi + 8]
        and rax, [rdx + 8]

        mov    [rdi + 8 ], rax

        mov rax, [rsi + 16]
        and rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        mov rax, [rsi + 24]
        and rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        mov rax, [rsi + 32]
        and rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_39        ; q is bigget so done.
        jnz tmp_38         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_39        ; q is bigget so done.
        jnz tmp_38         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_39        ; q is bigget so done.
        jnz tmp_38         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_39        ; q is bigget so done.
        jnz tmp_38         ; q is lower

        ; If equal substract q
tmp_38:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_39:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


and_l1ml2:
        bt     rcx, 62          ; check if montgomery first
        jc     and_l1ml2m
and_l1ml2n:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rdx
        push r8
        call Fr_toNormal
        mov  rsi, rdi
        pop  rdi
        pop  rdx



        mov rax, [rsi + 8]
        and rax, [rdx + 8]

        mov    [rdi + 8 ], rax

        mov rax, [rsi + 16]
        and rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        mov rax, [rsi + 24]
        and rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        mov rax, [rsi + 32]
        and rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_41        ; q is bigget so done.
        jnz tmp_40         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_41        ; q is bigget so done.
        jnz tmp_40         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_41        ; q is bigget so done.
        jnz tmp_40         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_41        ; q is bigget so done.
        jnz tmp_40         ; q is lower

        ; If equal substract q
tmp_40:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_41:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


and_l1ml2m:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rdx
        push r8
        call Fr_toNormal
        mov  rsi, rdi
        pop  rdi
        pop  rdx


        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rsi
        mov  rsi, rdx
        push r8
        call Fr_toNormal
        mov  rdx, rdi
        pop  rdi
        pop  rsi



        mov rax, [rsi + 8]
        and rax, [rdx + 8]

        mov    [rdi + 8 ], rax

        mov rax, [rsi + 16]
        and rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        mov rax, [rsi + 24]
        and rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        mov rax, [rsi + 32]
        and rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_43        ; q is bigget so done.
        jnz tmp_42         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_43        ; q is bigget so done.
        jnz tmp_42         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_43        ; q is bigget so done.
        jnz tmp_42         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_43        ; q is bigget so done.
        jnz tmp_42         ; q is lower

        ; If equal substract q
tmp_42:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_43:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret