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

    .globl or_s1s2
or_s1s2:
        mov    rax, [rsi]
        mov    rcx, [rdx]

        cmp    eax, 0
        
        js     tmp_44

        cmp    ecx, 0
        js     tmp_44
        xor    rdx, rdx         # both ops are positive so do the op and return
        mov    edx, eax
        or    edx, ecx
        mov    [rdi], rdx       # not necessary to adjust so just save and return

        jmp   tmp_46

tmp_44:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d


        call Fr_toLongNormal



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


        
        

        # Compare with q

        mov rax, [rdi + 32]
        mov r12, 0x30644e72e131a029
        cmp rax, r12
        jc tmp_46        # q is bigget so done.
        jnz tmp_45         # q is lower

        mov rax, [rdi + 24]
        mov r12, 0xb85045b68181585d
        cmp rax, r12
        jc tmp_46        # q is bigget so done.
        jnz tmp_45         # q is lower

        mov rax, [rdi + 16]
        mov r12, 0x2833e84879b97091
        cmp rax, r12
        jc tmp_46        # q is bigget so done.
        jnz tmp_45         # q is lower

        mov rax, [rdi + 8]
        mov r12, 0x43e1f593f0000001
        cmp rax, r12
        jc tmp_46        # q is bigget so done.
        jnz tmp_45         # q is lower

        # If equal substract q
tmp_45:

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

tmp_46:
        ret

        .type or_s1s2,@function
        .size or_s1s2,. - or_s1s2

Fr_toLongNormal:
        ret
