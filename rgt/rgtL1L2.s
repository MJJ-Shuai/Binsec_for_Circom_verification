.intel_syntax noprefix
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#0xa1f0fac9f8000000,0x9419f4243cdcb848,0xdc2822db40c0ac2e,0x183227397098d014
#.section .text

    .globl rgtL1L2
rgtL1L2:
        mov     rax, [rsi + 32]
        mov     rbx, 0x183227397098d014
        cmp     rbx, rax     # comare with (q-1)/2
        jc rgtl1l2_n1                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgtl1l2_p1                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rsi + 24]
        mov     rbx, 0xdc2822db40c0ac2e
        cmp     rbx, rax      # comare with (q-1)/2
        jc rgtl1l2_n1                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgtl1l2_p1                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rsi + 16]
        mov     rbx, 0x9419f4243cdcb848
        cmp     rbx, rax      ## comare with (q-1)/2
        jc rgtl1l2_n1                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgtl1l2_p1                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rsi + 8]
        mov     rbx, 0xa1f0fac9f8000000
        cmp     rbx, rax      ## comare with (q-1)/2
        jc rgtl1l2_n1                           # half<rax => e1-e2 is neg => e1 < e2

        jmp rgtl1l2_p1



rgtl1l2_p1:


        mov     rax, [rdx + 32]
        mov     rbx, 0x183227397098d014
        cmp     rbx, rax      ## comare with (q-1)/2
        jc rgt_ret1                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgtRawL1L2                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rdx + 24]
        mov     rbx, 0xdc2822db40c0ac2e
        cmp     rbx, rax     ## comare with (q-1)/2
        jc rgt_ret1                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgtRawL1L2                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rdx + 16]
        mov     rbx, 0x9419f4243cdcb848
        cmp     rbx, rax     ## comare with (q-1)/2
        jc rgt_ret1                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgtRawL1L2                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rdx + 8]
        mov     rbx, 0xa1f0fac9f8000000
        cmp     rbx, rax     # comare with (q-1)/2
        jc rgt_ret1                           # half<rax => e1-e2 is neg => e1 < e2

        jmp rgtRawL1L2




rgtl1l2_n1:


        mov     rax, [rdx + 32]
        mov     rbx, 0x183227397098d014
        cmp     rbx, rax     # comare with (q-1)/2
        jc rgtRawL1L2                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgt_ret0                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rdx + 24]
        mov     rbx, 0xdc2822db40c0ac2e
        cmp     rbx, rax     # comare with (q-1)/2
        jc rgtRawL1L2                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgt_ret0                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rdx + 16]
        mov     rbx, 0x9419f4243cdcb848
        cmp     rbx, rax     # comare with (q-1)/2
        jc rgtRawL1L2                           # half<rax => e1-e2 is neg => e1 < e2

        jnz rgt_ret0                       # half>rax => e1 -e2 is pos => e1 > e2


        mov     rax, [rdx + 8]
        mov     rbx, 0xa1f0fac9f8000000
        cmp     rbx, rax      # comare with (q-1)/2
        jc rgtRawL1L2                           # half<rax => e1-e2 is neg => e1 < e2

        jmp rgt_ret0





rgtRawL1L2:

        mov     rax, [rsi + 32]
        cmp     [rdx + 32], rax     # comare with (q-1)/2
        jc rgt_ret1                      # rsi<rdx => 1st > 2nd

        jnz rgt_ret0


        mov     rax, [rsi + 24]
        cmp     [rdx + 24], rax     # comare with (q-1)/2
        jc rgt_ret1                      # rsi<rdx => 1st > 2nd

        jnz rgt_ret0


        mov     rax, [rsi + 16]
        cmp     [rdx + 16], rax     # comare with (q-1)/2
        jc rgt_ret1                      # rsi<rdx => 1st > 2nd

        jnz rgt_ret0


        mov     rax, [rsi + 8]
        cmp     [rdx + 8], rax     # comare with (q-1)/2
        jc rgt_ret1                      # rsi<rdx => 1st > 2nd



rgt_ret0:
        xor    rax, rax

        ret
rgt_ret1:
        mov    rax, 1

        ret
        
        .type rgtL1L2,@function
	    .size rgtL1L2,. - rgtL1L2
