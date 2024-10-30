
    .globl Fr_rawCopy
Fr_rawCopy:

        movq    0(%rsi), %rax
        movq    %rax, 0(%rdi)

        movq    8(%rsi), %rax
        movq    %rax, 8(%rdi)

        movq    16(%rsi), %rax
        movq    %rax, 16(%rdi)

        movq    24(%rsi), %rax
        movq    %rax, 24(%rdi)

        ret
    .type Fr_rawCopy,@function
    .size Fr_rawCopy,. - Fr_rawCopy
    
