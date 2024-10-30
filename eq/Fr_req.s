.intel_syntax noprefix
    .globl Fr_req
Fr_req:
        mov    r8, [rsi]
        mov    r9, [rdx]
        bt     r8, 63          # Check if is short first operand
        jc     req_l1
        bt     r9, 63          # Check if is short second operand
        jc     req_s1l2

req_s1s2:                       # Both operands are short
        cmp    r8d, r9d
        je     req_ret1
        jmp    req_ret0


req_l1:
        bt     r9, 63          # Check if is short second operand
        jc     req_l1l2


req_l1s2:
        bt     r8, 62          # check if montgomery first
        jc     req_l1ms2
req_l1ns2:


        call Fr_toLongNormal


        jmp reqL1L2

req_l1ms2:


        call Fr_toMontgomery


        jmp reqL1L2


req_s1l2:
        bt     r9, 62          # check if montgomery second
        jc     req_s1l2m
req_s1l2n:


        call Fr_toLongNormal


        jmp reqL1L2

req_s1l2m:


        call Fr_toMontgomery


        jmp reqL1L2

req_l1l2:
        bt     r8, 62          # check if montgomery first
        jc     req_l1ml2
req_l1nl2:
        bt     r9, 62          # check if montgomery second
        jc     req_l1nl2m
req_l1nl2n:
        jmp reqL1L2

req_l1nl2m:


        call Fr_toMontgomery


        jmp reqL1L2

req_l1ml2:
        bt     r9, 62          # check if montgomery second
        jc     req_l1ml2m
req_l1ml2n:


        call Fr_toMontgomery


        jmp reqL1L2

req_l1ml2m:
        jmp reqL1L2

reqL1L2:

        mov     rax, [rsi + 8]
        cmp     [rdx + 8], rax
        je     req_ret1
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

        mov     rax, [rsi + 16]
        cmp     [rdx + 16], rax
        je     req_ret1
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

        mov     rax, [rsi + 24]
        cmp     [rdx + 24], rax
        je     req_ret1
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

        mov     rax, [rsi + 32]
        cmp     [rdx + 32], rax
        je     req_ret1
        jne     req_ret0                      # rsi<rdi => 1st > 2nd

req_ret1:
        mov    rax, 1

        ret

req_ret0:
        xor    rax, rax

        ret

Fr_toLongNormal:
        ret

Fr_toMontgomery:
        ret



        .type Fr_req,@function
	.size Fr_req,. - Fr_req
