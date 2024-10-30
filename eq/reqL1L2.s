.intel_syntax noprefix
    .globl reqL1L2
reqL1L2:

        mov     rax, [rsi + 8]
        cmp     [rdx + 8], rax
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

        mov     rax, [rsi + 16]
        cmp     [rdx + 16], rax
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

        mov     rax, [rsi + 24]
        cmp     [rdx + 24], rax
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

        mov     rax, [rsi + 32]
        cmp     [rdx + 32], rax
        jne     req_ret0                      # rsi<rdi => 1st > 2nd


req_ret1:
        mov    rax, 1

        ret

req_ret0:
        xor    rax, rax

        ret

        .type reqL1L2,@function
	    .size reqL1L2,. - reqL1L2
