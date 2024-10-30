	.globl Fr_rawSwap
Fr_rawSwap:
        movq    0(%rsi), %rax
        movq    0(%rdi), %rcx
        movq    %rax, 0(%rdi)
        movq    %rcx, 0(%rsi)

        movq    8(%rsi), %rax
        movq    8(%rdi), %rcx
        movq    %rax, 8(%rdi)
        movq    %rcx, 8(%rsi)

        movq    16(%rsi), %rax
        movq    16(%rdi), %rcx
        movq    %rax, 16(%rdi)
        movq    %rcx, 16(%rsi)

        movq    24(%rsi), %rax
        movq    24(%rdi), %rcx
        movq    %rax, 24(%rdi)
        movq    %rcx, 24(%rsi)

        ret

    .type Fr_rawSwap,@function
	.size Fr_rawSwap,. - Fr_rawSwap
    