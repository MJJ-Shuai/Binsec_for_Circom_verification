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

    .globl mul_s1s2
mul_s1s2:                       # Both operands are short
        mov    r8, [rsi]
        mov    r9, [rdx]
        xor    rax, rax
        mov    eax, r8d
        imul   r9d
        jo     mul_manageOverflow   # rsi already is the 64bits result

        mov    [rdi], rax       # not necessary to adjust so just save and return

mul_manageOverflow:                 # Do the operation in 64 bits
        movsx  rax, r8d
        movsx  rcx, r9d
        imul   rcx
        mov    [rsi], rax
        call   rawCopyS2L        
        
        #push   rsi
        #movsx  rax, r8d
        #movsx  rcx, r9d
        #imul   rcx
        #mov    rsi, rax
        #call   rawCopyS2L
        #pop    rsi

        ret

        .type mul_s1s2,@function
        .size mul_s1s2,. - mul_s1s2

rawCopyS2L:
        ret
        