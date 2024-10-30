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

    .globl Fr_toInt
Fr_toInt:
        mov     rax, [rdi]
        bt      rax, 63
        jc      Fr_long
        movsx   rax, eax
        ret

Fr_long:
        push   rbp
        push   rsi
        push   rdx
        mov    rbp, rsp
        bt      rax, 62
        jnc     Fr_longNormal
Fr_longMontgomery:

        sub  rsp, 40
        push rsi
        mov  rsi, rdi
        mov  rdi, rsp
        call Fr_toNormal
        pop  rsi


Fr_longNormal:
        mov     rax, [rdi + 8]
        mov     rcx, rax
        shr     rcx, 31
        jnz     Fr_longNeg

        mov     rcx, [rdi + 16]
        test    rcx, rcx
        jnz     Fr_longNeg

        mov     rcx, [rdi + 24]
        test    rcx, rcx
        jnz     Fr_longNeg

        mov     rcx, [rdi + 32]
        test    rcx, rcx
        jnz     Fr_longNeg

        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret

Fr_longNeg:
        mov     rax, [rdi + 8]
        mov    rbx, 0x43e1f593f0000001 
        sub     rax, rbx
        jnc     Fr_longErr

        mov     rcx, [rdi + 16]
        mov    rbx, 0x2833e84879b97091 
        sbb     rcx, rbx
        jnc     Fr_longErr

        mov     rcx, [rdi + 24]
        mov    rbx, 0xb85045b68181585d
        sbb     rcx, rbx
        jnc     Fr_longErr

        mov     rcx, [rdi + 32]
        mov    rbx, 0x30644e72e131a029
        sbb     rcx, rbx
        jnc     Fr_longErr

        mov     rcx, rax
        sar     rcx, 31
        add     rcx, 1
        jnz     Fr_longErr
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret

Fr_longErr:
        push    rdi
        mov     rdi, 0
        call    Fr_fail
        pop     rdi
        mov rsp, rbp
        pop rdx
        pop rsi
        pop rbp
        ret


Fr_fail:
    xor rbx, rbx
    ret
Fr_toNormal:
    ret
        .type Fr_toInt,@function
	.size Fr_toInt,. - Fr_toInt
