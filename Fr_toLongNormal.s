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

    .globl Fr_toLongNormal
Fr_toLongNormal:
    mov     rax, [rsi]
    bt      rax, 63                     # check if long
    jnc     toLongNormal_fromShort
    bt      rax, 62                     # check if montgomery
    jc      toLongNormal_fromMontgomery
    call    Fr_copy              # It is already long
    ret

toLongNormal_fromMontgomery:
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

toLongNormal_fromShort:
    mov     r8, rsi                     # save rsi
    movsx   rsi, eax
    call    rawCopyS2L
    mov     rsi, r8                     # recover rsi
    mov     r11b, 0x80
    shl     r11d, 24
    mov     [rdi+4], r11d
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

rawCopyS2L:
        mov     al, 0x80
        shl     rax, 56
        mov     [rdi], rax    # set the result to LONG normal

        cmp     rsi, 0
        js      u64toLong_adjust_neg

        mov     [rdi + 8], rsi
        xor     rax, rax

        mov     [rdi + 16], rax

        mov     [rdi + 24], rax

        mov     [rdi + 32], rax

        ret

u64toLong_adjust_neg:
        mov    rbx, 0x43e1f593f0000001   
        add    rsi, rbx         # Set the first digit
        mov    [rdi + 8], rsi   #

        mov    rsi, -1          # all ones

        mov    rbx, 0x2833e84879b97091 
        mov    rax, rsi                       # Add to q
        adc    rax, rbx
        mov    [rdi + 16], rax

        mov    rbx, 0xb85045b68181585d
        mov    rax, rsi                       # Add to q
        adc    rax, rbx
        mov    [rdi + 24], rax

        mov    rbx, 0x30644e72e131a029
        mov    rax, rsi                       # Add to q
        adc    rax, rbx
        mov    [rdi + 32], rax

        ret


    .type Fr_toLongNormal,@function
	.size Fr_toLongNormal,. - Fr_toLongNormal
