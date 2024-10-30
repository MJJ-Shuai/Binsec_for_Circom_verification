#先把蒙哥马利数转成普通长整型，
#如果short是正数，就将其符号扩展到rax，与第二个操作数低八字节比较
#如果short是负数，就将其转换成long型（Fr_tolongnormal）,在进行正常的比较

or_l1ms2:
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


        mov    rcx, [rdx]
        cmp    ecx, 0
        
        js     tmp_52
        movsx  rax, ecx
        or rax, [rsi +8]
        mov    [rdi+8], rax

        xor    rax, rax
        or rax, [rsi + 16];

        mov    [rdi + 16 ], rax;

        xor    rax, rax
        or rax, [rsi + 24];

        mov    [rdi + 24 ], rax;

        xor    rax, rax
        or rax, [rsi + 32];

        and    rax, [lboMask] ;

        mov    [rdi + 32 ], rax;


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_54        ; q is bigget so done.
        jnz tmp_53         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_54        ; q is bigget so done.
        jnz tmp_53         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_54        ; q is bigget so done.
        jnz tmp_53         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_54        ; q is bigget so done.
        jnz tmp_53         ; q is lower

        ; If equal substract q
tmp_53:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_54:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret

tmp_52:

        mov  r8, rdi
        sub  rsp, 40
        mov  rdi, rsp
        push rsi
        mov  rsi, rdx
        push r8
        call Fr_toLongNormal
        mov  rdx, rdi
        pop  rdi
        pop  rsi

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
        jc tmp_56        ; q is bigget so done.
        jnz tmp_55         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_56        ; q is bigget so done.
        jnz tmp_55         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_56        ; q is bigget so done.
        jnz tmp_55         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_56        ; q is bigget so done.
        jnz tmp_55         ; q is lower

        ; If equal substract q
tmp_55:

        mov rax, [q + 0]
        sub [rdi + 8], rax

        mov rax, [q + 8]
        sbb [rdi + 16], rax

        mov rax, [q + 16]
        sbb [rdi + 24], rax

        mov rax, [q + 24]
        sbb [rdi + 32], rax

tmp_56:

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret
