.section .data
.globl q
q:
.quad 0x43e1f593f0000001, 0x2833e84879b97091, 0xb85045b68181585d, 0x30644e72e131a029
.section .text
.globl rawCopyS2L
rawCopyS2L:
        movb    $0x80, %al
        shlq    $56, %rax
        movq    %rax, (%rdi)    # set the result to LONG normal

        cmpq    $0, %rsi
        js      u64toLong_adjust_neg

        movq    %rsi, 8(%rdi)
        xorq    %rax, %rax

        movq    %rax, 16(%rdi)
        movq    %rax, 24(%rdi)
        movq    %rax, 32(%rdi)
        ret
.globl u64toLong_adjust_neg
u64toLong_adjust_neg:
        addq    q(%rip), %rsi         # Set the first digit
        movq    %rsi, 8(%rdi)

        movq    $-1, %rsi             # all ones

        movq    %rsi, %rax            # Add to q
        adcq    8+q(%rip), %rax
        movq    %rax, 16(%rdi)

        movq    %rsi, %rax            # Add to q
        adcq    16+q(%rip), %rax
        movq    %rax, 24(%rdi)

        movq    %rsi, %rax            # Add to q
        adcq    24+q(%rip), %rax
        movq    %rax, 32(%rdi)
        ret

    .type rawCopyS2L,@function
	.size rawCopyS2L,. - rawCopyS2L

