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

    .globl Fr_bnot
Fr_bnot:

                mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d

        mov     rax, [rsi]
        bt      rax, 63          # Check if is long operand
        jc      bnot_l1
bnot_s:
        

        call Fr_toLongNormal


        jmp     bnot_l1n

bnot_l1:
        bt     rax, 62          # check if montgomery first
        jnc    bnot_l1n

bnot_l1m:


        call Fr_toNormal


bnot_l1n:

        mov    rax, [rsi + 8]
        not    rax

        mov    [rdi + 8], rax

        mov    rax, [rsi + 16]
        not    rax

        mov    [rdi + 16], rax

        mov    rax, [rsi + 24]
        not    rax

        mov    [rdi + 24], rax

        mov    rax, [rsi + 32]
        not    rax

        mov r12, 0x3fffffffffffffff
        and rax, r12

        mov    [rdi + 32], rax


        
        

        # Compare with q

        mov rax, [rdi + 32]
        mov r12, 0x30644e72e131a029
        cmp rax, r12
        jc tmp_107        # q is bigget so done.
        jnz tmp_106         # q is lower

        mov rax, [rdi + 24]
        mov r12, 0xb85045b68181585d
        cmp rax, r12
        jc tmp_107        # q is bigget so done.
        jnz tmp_106         # q is lower

        mov rax, [rdi + 16]
        mov r12, 0x2833e84879b97091
        cmp rax, r12
        jc tmp_107        # q is bigget so done.
        jnz tmp_106         # q is lower

        mov rax, [rdi + 8]
        mov r12, 0x43e1f593f0000001
        cmp rax, r12
        jc tmp_107        # q is bigget so done.
        jnz tmp_106         # q is lower

        # If equal substract q
tmp_106:

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

tmp_107:
        ret

        .type Fr_bnot,@function
        .size Fr_bnot,. - Fr_bnot
Fr_toNormal:
        ret

Fr_toLongNormal:
        ret


