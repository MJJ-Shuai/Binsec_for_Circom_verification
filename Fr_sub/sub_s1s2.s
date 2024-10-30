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

    .globl sub_s1s2
sub_s1s2:                       # Both operands are short
        mov    rax, [rsi]
        mov    rcx, [rdx]
        xor    rdx, rdx
        mov    edx, eax
        sub    edx, ecx
        jo     sub_manageOverflow   # rsi already is the 64bits result

        mov    [rdi], rdx       # not necessary to adjust so just save and return

        jmp     tmp_end

sub_manageOverflow:                 # Do the operation in 64 bits

        movsx  r12, eax
        movsx  r13, ecx
        sub    r12, r13
        mov    [rsi], r12
        call   rawCopyS2L
        
        #movsx  rsi, eax
        #movsx  rdx, ecx
        #sub    rsi, rdx
        #call   rawCopyS2L

        ret


        .type sub_s1s2,@function
        .size sub_s1s2,. - sub_s1s2

rawCopyS2L:
        ret
tmp_end:
        ret
