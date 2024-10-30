.intel_syntax noprefix
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#lboMask dq      0x3fffffffffffffff
#0xa1f0fac9f8000000,0x9419f4243cdcb848,0xdc2822db40c0ac2e,0x183227397098d014
#.section .text

    .globl and_l1ns2
#如果short是正数，就将其符号扩展到rax，与第二个操作数低八字节比较
#如果short是负数，就将其转换成long型（Fr_tolongnormal）,在进行正常的比较
or_l1ns2:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        mov    rcx, [rdx]
        cmp    ecx, 0
        
        js     tmp_47
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

        mov     r12, 0x3fffffffffffffff
        and    rax, r12 #

        mov    [rdi + 32 ], rax;


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        mov r12, 0x30644e72e131a029
        cmp rax, r12
        jc tmp_49        ; q is bigget so done.
        jnz tmp_48         ; q is lower

        mov rax, [rdi + 24]
        mov r12, 0xb85045b68181585d
        cmp rax, r12
        jc tmp_49        ; q is bigget so done.
        jnz tmp_48         ; q is lower

        mov rax, [rdi + 16]
        mov r12, 0x2833e84879b97091 
        cmp rax, r12
        jc tmp_49        ; q is bigget so done.
        jnz tmp_48         ; q is lower

        mov rax, [rdi + 8]
        mov r12, 0x43e1f593f0000001
        cmp rax, r12
        jc tmp_49        ; q is bigget so done.
        jnz tmp_48         ; q is lower

        ; If equal substract q
tmp_48:

        mov r12, 0x43e1f593f0000001
        mov rax, r12
        sub [rdi + 8], rax

        mov r12, 0x2833e84879b97091
        mov rax, r12
        sbb [rdi + 16], rax

        mov r12, 0xb85045b68181585d
        mov rax, r12
        sbb [rdi + 24], rax

        mov r12, 0x30644e72e131a029
        mov rax, r12
        sbb [rdi + 32], rax



tmp_47:


        call Fr_toLongNormal


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

        mov r12, 0x3fffffffffffffff
        and rax, r12

        mov    [rdi + 32 ], rax


        
        

        ; Compare with q

        mov rax, [rdi + 32]
        cmp rax, [q + 24]
        jc tmp_51        ; q is bigget so done.
        jnz tmp_50         ; q is lower

        mov rax, [rdi + 24]
        cmp rax, [q + 16]
        jc tmp_51        ; q is bigget so done.
        jnz tmp_50         ; q is lower

        mov rax, [rdi + 16]
        cmp rax, [q + 8]
        jc tmp_51        ; q is bigget so done.
        jnz tmp_50         ; q is lower

        mov rax, [rdi + 8]
        cmp rax, [q + 0]
        jc tmp_51        ; q is bigget so done.
        jnz tmp_50         ; q is lower

        ; If equal substract q
tmp_50:

        mov r12, 0x43e1f593f0000001
        mov rax, r12
        sub [rdi + 8], rax

        mov r12, 0x2833e84879b97091
        mov rax, r12
        sbb [rdi + 16], rax

        mov r12, 0xb85045b68181585d
        mov rax, r12
        sbb [rdi + 24], rax

        mov r12, 0x30644e72e131a029
        mov rax, r12
        sbb [rdi + 32], rax

        .type and_l1ns2,@function
        .size and_l1ns2,. - and_l1ns2

Fr_toLongNormal:
        ret
        
tmp_49:

        ret

tmp_51:

        ret

