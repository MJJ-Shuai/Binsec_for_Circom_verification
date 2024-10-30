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

    .globl square_s1
square_s1:                       # Both operands are short
        mov    r8, [rsi]
        xor    rax, rax
        mov    eax, r8d
        imul   eax
        jo     square_manageOverflow   # rsi already is the 64bits result

        mov    [rdi], rax       # not necessary to adjust so just save and return

square_manageOverflow:                 # Do the operation in 64 bits
        #push   rsi
        movsx  rax, r8d
        imul   rax
        mov    [rsi], rax
        call   rawCopyS2L
        #pop    rsi

        ret
        
        .type square_s1,@function
        .size square_s1,. - square_s1

rawCopyS2L:
        ret
