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

    .globl Fr_toMontgomery
Fr_toMontgomery:
    mov     rax, [rsi]
    bt      rax, 62                     # check if montgomery
    jc      toMontgomery_doNothing
    bt      rax, 63
    jc      toMontgomeryLong

toMontgomeryShort:
    movsx   rdx, eax
    mov     [rdi], rdx
    add     rdi, 8
    lea     rsi, [R2]
    cmp     rdx, 0
    js      negMontgomeryShort
posMontgomeryShort:
    call    Fr_rawMMul1
    sub     rdi, 8          
            mov r11b, 0x40
        shl r11d, 24
        mov [rdi+4], r11d
    ret

negMontgomeryShort:
    neg     rdx              # Do the multiplication positive and then negate the result.
    call    Fr_rawMMul1
    mov     rsi, rdi
    call    rawNegL         # False didnt run the codes below
    sub     rdi, 8
            mov r11b, 0x40
        shl r11d, 24
        mov [rdi+4], r11d
    ret


toMontgomeryLong:
    mov     [rdi], rax
    add     rdi, 8
    add     rsi, 8
    lea     rdx, [R2]
    call    Fr_rawMMul
    sub     rsi, 8
    sub     rdi, 8
    mov     r11b, 0xC0
    shl     r11d, 24
    mov     [rdi+4], r11d
    ret


toMontgomery_doNothing:
    call   Fr_copy
    ret

Fr_rawMMul:
    ret

Fr_rawMMul1:
    ret    
rawNegL:
Fr_rawNeg:
        # Compare is zero
        xor rax, rax

        cmp [rsi + 0], rax
        jnz doNegate

        cmp [rsi + 8], rax
        jnz doNegate

        cmp [rsi + 16], rax
        jnz doNegate

        cmp [rsi + 24], rax
        jnz doNegate

        # it's zero so just set to zero

        mov [rdi + 0], rax

        mov [rdi + 8], rax

        mov [rdi + 16], rax

        mov [rdi + 24], rax

        ret
doNegate:

        mov    rbx, 0x43e1f593f0000001
        mov rax, rbx
        sub rax, [rsi + 0]
        mov [rdi + 0], rax

        mov    rbx, 0x2833e84879b97091
        mov rax, rbx
        sbb rax, [rsi + 8]
        mov [rdi + 8], rax

        mov    rbx, 0xb85045b68181585d
        mov rax, rbx
        sbb rax, [rsi + 16]
        mov [rdi + 16], rax

        mov    rbx, 0x30644e72e131a029
        mov rax, rbx
        sbb rax, [rsi + 24]
        mov [rdi + 24], rax

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


    .type Fr_toMontgomery,@function
	.size Fr_toMontgomery,. - Fr_toMontgomery
