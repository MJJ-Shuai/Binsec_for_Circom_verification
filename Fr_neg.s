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

    .globl Fr_neg
Fr_neg:
        mov    rax, [rsi]
        bt     rax, 63          # Check if is short first operand
        jc     neg_l

neg_s:                          # Operand is short

        neg    eax
        jo     neg_manageOverflow   # Check if overflow. (0x80000000 is the only case)

        mov    [rdi], rax           # not necessary to adjust so just save and return
        ret

neg_manageOverflow:                 # Do the operation in 64 bits
        push   rsi
        movsx  rsi, eax
        neg    rsi
        call   rawCopyS2L
        pop    rsi
        ret



neg_l:
        mov [rdi], rax          # Copy the type

        add rdi, 8
        add rsi, 8
        call rawNegL
        sub rdi, 8
        sub rsi, 8
        ret

rawCopyS2L:
        mov     al, 0x80
        shl     rax, 56
        mov     [rdi], rax    # set the result to LONG normal

        cmp     rsi, 0
        js      u64toLong_adjust_neg

        mov     [rdi + 8], rsi
        xor     rax, rax

        mov     [rdi + 16], rax

        mov     [rdi + 24], rax

        mov     [rdi + 32], rax

        ret

u64toLong_adjust_neg:
        mov    rbx, 0x43e1f593f0000001   
        add    rsi, rbx         # Set the first digit
        mov    [rdi + 8], rsi   #

        mov    rsi, -1          # all ones

        mov    rbx, 0x2833e84879b97091 
        mov    rax, rsi                       # Add to q
        adc    rax, rbx
        mov    [rdi + 16], rax

        mov    rbx, 0xb85045b68181585d
        mov    rax, rsi                       # Add to q
        adc    rax, rbx
        mov    [rdi + 24], rax

        mov    rbx, 0x30644e72e131a029
        mov    rax, rsi                       # Add to q
        adc    rax, rbx
        mov    [rdi + 32], rax

        ret

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

    .type Fr_neg,@function
	.size Fr_neg,. - Fr_neg
    