    .globl Fr_rawZero
Fr_rawZero:
        xorq    %rax, %rax

        movq    %rax, 0(%rdi)

        movq    %rax, 8(%rdi)

        movq    %rax, 16(%rdi)

        movq    %rax, 24(%rdi)

        ret

    .type Fr_rawZero,@function
    .size Fr_rawZero,. - Fr_rawZero