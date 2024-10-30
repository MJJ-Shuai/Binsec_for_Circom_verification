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

    .globl rawSubLL
rawSubLL:
        # Substract first digit

        mov rax, [rsi + 0]
        sub rax, [rdx + 0]
        mov [rdi + 0], rax

        mov rax, [rsi + 8]
        sbb rax, [rdx + 8]
        mov [rdi + 8], rax

        mov rax, [rsi + 16]
        sbb rax, [rdx + 16]
        mov [rdi + 16], rax

        mov rax, [rsi + 24]
        sbb rax, [rdx + 24]
        mov [rdi + 24], rax

        jnc rawSubLL_done   # if overflow, add q

        # Add q
rawSubLL_aq:

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

rawSubLL_done:
        ret

    .type rawSubLL,@function
	.size rawSubLL,. - rawSubLL
