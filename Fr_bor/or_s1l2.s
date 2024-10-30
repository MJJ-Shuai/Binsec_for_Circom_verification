#same as 'and_l1ns2' & 'and_l1ms2'


or_s1l2:
        bt     rcx, 62          ; check if montgomery first
        jc     or_s1l2m
or_s1l2n:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        mov    eax, [rsi]
        cmp    eax, 0
        
        js     tmp_57
        or rax, [rdx +8]
        mov    [rdi+8], rax

        xor    rax, rax
        or rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        xor    rax, rax
        or rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        xor    rax, rax
        or rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_59        ; q is bigget so done.
        jnz tmp_58         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_59        ; q is bigget so done.
        jnz tmp_58         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_59        ; q is bigget so done.
        jnz tmp_58         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_59        ; q is bigget so done.
        jnz tmp_58         ; q is lower

        ; If equal substract q
tmp_58:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_59:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret

tmp_57:

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rdx
        push r8
        call Fr_toLongNormal
        mov  rsi, rdi
        pop  rdi
        pop  rdx

        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d


        mov rax, [rsi + 8]
        or rax, [rdx + 8]

        mov    [rdi + 8 ], rax

        mov rax, [rsi + 16]
        or rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        mov rax, [rsi + 24]
        or rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        mov rax, [rsi + 32]
        or rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_61        ; q is bigget so done.
        jnz tmp_60         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_61        ; q is bigget so done.
        jnz tmp_60         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_61        ; q is bigget so done.
        jnz tmp_60         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_61        ; q is bigget so done.
        jnz tmp_60         ; q is lower

        ; If equal substract q
tmp_60:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_61:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret




or_s1l2m:
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


        mov    eax, [rsi]
        cmp    eax, 0
        
        js     tmp_62
        or rax, [rdx +8]
        mov    [rdi+8], rax

        xor    rax, rax
        or rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        xor    rax, rax
        or rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        xor    rax, rax
        or rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_64        ; q is bigget so done.
        jnz tmp_63         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_64        ; q is bigget so done.
        jnz tmp_63         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_64        ; q is bigget so done.
        jnz tmp_63         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_64        ; q is bigget so done.
        jnz tmp_63         ; q is lower

        ; If equal substract q
tmp_63:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_64:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret

tmp_62:

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rdx
        push r8
        call Fr_toLongNormal
        mov  rsi, rdi
        pop  rdi
        pop  rdx

        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d


        mov rax, [rsi + 8]
        or rax, [rdx + 8]

        mov    [rdi + 8 ], rax

        mov rax, [rsi + 16]
        or rax, [rdx + 16]

        mov    [rdi + 16 ], rax

        mov rax, [rsi + 24]
        or rax, [rdx + 24]

        mov    [rdi + 24 ], rax

        mov rax, [rsi + 32]
        or rax, [rdx + 32]

        and    rax, [lboMask]

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_66        ; q is bigget so done.
        jnz tmp_65         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_66        ; q is bigget so done.
        jnz tmp_65         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_66        ; q is bigget so done.
        jnz tmp_65         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_66        ; q is bigget so done.
        jnz tmp_65         ; q is lower

        ; If equal substract q
tmp_65:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_66:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret
