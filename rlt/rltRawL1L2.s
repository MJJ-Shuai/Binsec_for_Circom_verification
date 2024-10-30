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

    .globl rltRawL1L2
rltRawL1L2:

        mov     rax, [rsi + 32]
        cmp     [rdx + 32], rax     # comare with (q-1)/2
        jc rlt_ret0                 # rsi<rdx => 1st > 2nd
        jnz rlt_ret1

        mov     rax, [rsi + 24]
        cmp     [rdx + 24], rax     # comare with (q-1)/2
        jc rlt_ret0                 # rsi<rdx => 1st > 2nd
        jnz rlt_ret1

        mov     rax, [rsi + 16]
        cmp     [rdx + 16], rax     # comare with (q-1)/2
        jc rlt_ret0                 # rsi<rdx => 1st > 2nd
        jnz rlt_ret1

        mov     rax, [rsi + 8]
        cmp     [rdx + 8], rax      # comare with (q-1)/2
        jc rlt_ret0                 # rsi<rdx => 1st > 2nd
        jnz rlt_ret1


rlt_ret0:
        xor    rax, rax

        ret
rlt_ret1:
        mov    rax, 1

        ret
        
        .type rltRawL1L2,@function
	.size rltRawL1L2,. - rltRawL1L2
