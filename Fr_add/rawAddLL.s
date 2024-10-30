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

    .globl rawAddLL
rawAddLL:
        # Add component by component with carry

        mov rax, [rsi + 0]
        add rax, [rdx + 0]
        mov [rdi + 0], rax

        mov rax, [rsi + 8]
        adc rax, [rdx + 8]
        mov [rdi + 8], rax

        mov rax, [rsi + 16]
        adc rax, [rdx + 16]
        mov [rdi + 16], rax

        mov rax, [rsi + 24]
        adc rax, [rdx + 24]
        mov [rdi + 24], rax

        jc rawAddLL_sq   # if overflow, substract q

        # Compare with q

        mov    rbx, 0x30644e72e131a029
        cmp rax, rbx
        jc rawAddLL_done        # q is bigget so done.
        jnz rawAddLL_sq         # q is lower


        mov rax, [rdi + 16]

        mov    rbx, 0xb85045b68181585d
        cmp rax, rbx
        jc rawAddLL_done        # q is bigget so done.
        jnz rawAddLL_sq         # q is lower


        mov rax, [rdi + 8]

        mov    rbx, 0x2833e84879b97091 
        cmp rax, rbx
        jc rawAddLL_done        # q is bigget so done.
        jnz rawAddLL_sq         # q is lower


        mov rax, [rdi + 0]

        mov    rbx, 0x43e1f593f0000001 
        cmp rax, rbx
        jc rawAddLL_done        # q is bigget so done.
        jnz rawAddLL_sq         # q is lower

        # If equal substract q
rawAddLL_sq:

        mov    rbx, 0x43e1f593f0000001 
        mov rax, rbx
        sub [rdi + 0], rax
        
        mov    rbx, 0x2833e84879b97091 
        mov rax, rbx
        sbb [rdi + 8], rax

        mov    rbx, 0xb85045b68181585d
        mov rax, rbx
        sbb [rdi + 16], rax
        
        mov    rbx, 0x30644e72e131a029
        mov rax, rbx
        sbb [rdi + 24], rax

rawAddLL_done:
        ret

    .type rawAddLL,@function
    .size rawAddLL,. - rawAddLL
    