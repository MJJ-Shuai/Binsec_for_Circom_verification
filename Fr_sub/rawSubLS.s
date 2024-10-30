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

    .globl rawSubLS
rawSubLS:
        # Substract first digit

        mov rax, [rsi]
        sub rax, rdx
        mov [rdi] ,rax
        mov rdx, 0

        mov rax, [rsi + 8]
        sbb rax, rdx
        mov [rdi + 8], rax

        mov rax, [rsi + 16]
        sbb rax, rdx
        mov [rdi + 16], rax

        mov rax, [rsi + 24]
        sbb rax, rdx
        mov [rdi + 24], rax

        jnc rawSubLS_done   # if overflow, add q

        # Add q
rawSubLS_aq:

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

rawSubLS_done:
        ret


    .type rawSubLS,@function
	.size rawSubLS,. - rawSubLS
