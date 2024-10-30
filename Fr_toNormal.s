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

    .globl Fr_toNormal
Fr_toNormal:
    mov     rax, [rsi]
    bt      rax, 62                     # check if montgomery
    jnc     toNormal_doNothing
    bt      rax, 63                     # if short, it means it's converted
    jnc     toNormal_doNothing

toNormalLong:
    add     rdi, 8
    add     rsi, 8
    call    Fr_rawFromMontgomery
    sub     rsi, 8
    sub     rdi, 8
    mov     r11b, 0x80
    shl     r11d, 24
    mov     [rdi+4], r11d
    ret

Fr_rawFromMontgomery:
        ret

toNormal_doNothing:
    call   Fr_copy
    ret

Fr_copy:

        mov     rax, [rsi + 0]
        mov     [rdi + 0], rax

        mov     rax, [rsi + 8]
        mov     [rdi + 8], rax

        mov     rax, [rsi + 16]
        mov     [rdi + 16], rax

        mov     rax, [rsi + 24]
        mov     [rdi + 24], rax

        mov     rax, [rsi + 32]
        mov     [rdi + 32], rax

        ret
    .type Fr_toNormal,@function
	.size Fr_toNormal,. - Fr_toNormal

