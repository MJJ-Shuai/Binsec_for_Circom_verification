.intel_syntax noprefix
#.globl q
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#np      dq      0xc2e1f593efffffff
#.section .text

    .globl rawNegL
rawNegL:
        # Compare is zero

        xor rax, rax

        cmp [rsi + 0], rax
        jnz doNegate

        cmp [rsi + 8], rax
        jnz doNegate

        cmp [rsi + 16], rax
        jnz doNegate

        cmp [rsi + 24], rax
        jnz doNegate

        # it's zero so just set to zero

        mov [rdi + 0], rax

        mov [rdi + 8], rax

        mov [rdi + 16], rax

        mov [rdi + 24], rax

        ret
doNegate:

        mov    rbx, 0x43e1f593f0000001
        mov rax, rbx
        sub rax, [rsi + 0]
        mov [rdi + 0], rax

        mov    rbx, 0x2833e84879b97091
        mov rax, rbx
        sbb rax, [rsi + 8]
        mov [rdi + 8], rax

        mov    rbx, 0xb85045b68181585d
        mov rax, rbx
        sbb rax, [rsi + 16]
        mov [rdi + 16], rax

        mov    rbx, 0x30644e72e131a029
        mov rax, rbx
        sbb rax, [rsi + 24]
        mov [rdi + 24], rax

        ret

    .type rawNegL,@function
	.size rawNegL,. - rawNegL
