.intel_syntax noprefix
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#0xa1f0fac9f8000000,0x9419f4243cdcb848,0xdc2822db40c0ac2e,0x183227397098d014
#.section .text

    .globl Fr_rlt
Fr_rlt:
        mov    r8, [rsi]
        mov    r9, [rdx]
        bt     r8, 63          # Check if is short first operand
        jc     rlt_l1
        bt     r9, 63          # Check if is short second operand
        jc     rlt_s1l2

rlt_s1s2:                       # Both operands are short
        cmp    r8d, r9d
        jl     rlt_ret1
        jmp    rlt_ret0


rlt_l1:
        bt     r9, 63          # Check if is short second operand
        jc     rlt_l1l2


rlt_l1s2:
        bt     r8, 62          # check if montgomery first
        jc     rlt_l1ms2
rlt_l1ns2:


        call Fr_toLongNormal


        jmp rltL1L2

rlt_l1ms2:


        call Fr_toLongNormal




        call Fr_toNormal


        jmp rltL1L2



rlt_s1l2:
        bt     r9, 62          # check if montgomery second
        jc     rlt_s1l2m
rlt_s1l2n:


        call Fr_toLongNormal


        jmp rltL1L2

rlt_s1l2m:


        call Fr_toLongNormal




        call Fr_toNormal


        jmp rltL1L2
        
rlt_l1l2:
        bt     r8, 62          # check if montgomery first
        jc     rlt_l1ml2
rlt_l1nl2:
        bt     r9, 62          # check if montgomery second
        jc     rlt_l1nl2m
rlt_l1nl2n:
        jmp rltL1L2

rlt_l1nl2m:


        call Fr_toNormal


        jmp rltL1L2

rlt_l1ml2:
        bt     r9, 62          # check if montgomery second
        jc     rlt_l1ml2m
rlt_l1ml2n:


        call Fr_toNormal


        jmp rltL1L2

rlt_l1ml2m:


        call Fr_toNormal


        jmp rltL1L2

Fr_toLongNormal:
        ret

Fr_toNormal:
        ret

rltL1L2:
        ret

rlt_ret0:
        xor    rax, rax

        ret
rlt_ret1:
        mov    rax, 1

        ret


        .type Fr_rlt,@function
	    .size Fr_rlt,. - Fr_rlt
