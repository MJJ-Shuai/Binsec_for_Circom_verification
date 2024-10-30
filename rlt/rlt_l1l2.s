.intel_syntax noprefix
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#0xa1f0fac9f8000000,0x9419f4243cdcb848,0xdc2822db40c0ac2e,0x183227397098d014
#.section .text

    .globl rlt_l1l2
rlt_l1l2:
        mov    r8, [rsi]
        mov    r9, [rdx]
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

Fr_toNormal:
        ret
rltL1L2:


        ret



        .type rlt_l1l2,@function
	    .size rlt_l1l2,. - rlt_l1l2
