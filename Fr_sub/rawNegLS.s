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

    .globl rawNegLS
rawNegLS:
        mov    rbx, 0x43e1f593f0000001
        mov rax, rbx
        sub rax, rdx
        mov [rdi], rax

        mov    rbx, 0x2833e84879b97091
        mov rax, rbx
        sbb rax, 0
        mov [rdi + 8], rax

        mov    rbx, 0xb85045b68181585d
        mov rax, rbx
        sbb rax, 0
        mov [rdi + 16], rax

        mov    rbx, 0x30644e72e131a029
        mov rax, rbx
        sbb rax, 0
        mov [rdi + 24], rax

        setc dl


        mov rax, [rdi + 0 ]
        sub rax, [rsi + 0]
        mov [rdi + 0], rax

        mov rax, [rdi + 8 ]
        sbb rax, [rsi + 8]
        mov [rdi + 8], rax

        mov rax, [rdi + 16 ]
        sbb rax, [rsi + 16]
        mov [rdi + 16], rax

        mov rax, [rdi + 24 ]
        sbb rax, [rsi + 24]
        mov [rdi + 24], rax


        setc dh
        or dl, dh
        jz rawNegSL_done

        # it is a negative value, so add q

        mov    rbx, 0x43e1f593f0000001
        mov rax, rbx
        add [rdi + 0], rax

        mov    rbx, 0x2833e84879b97091
        mov rax, rbx
        adc [rdi + 8], rax

        mov    rbx, 0xb85045b68181585d
        mov rax, rbx
        adc [rdi + 16], rax

        mov    rbx, 0x30644e72e131a029
        mov rax, rbx
        adc [rdi + 24], rax


rawNegSL_done:
        ret

    .type rawNegLS,@function
	.size rawNegLS,. - rawNegLS
