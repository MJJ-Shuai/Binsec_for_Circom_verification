.intel_syntax noprefix
#.globl q
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#.section .text
    .globl rawCopyS2L
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

    .type rawCopyS2L,@function
	.size rawCopyS2L,. - rawCopyS2L

