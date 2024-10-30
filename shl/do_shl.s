.intel_syntax noprefix
#.section .data
#q:
#    .quad 0x43e1f593f0000001
#    .quad 0x2833e84879b97091
#    .quad 0xb85045b68181585d
#    .quad 0x30644e72e131a029
#lboMask dq      0x3fffffffffffffff
#0xa1f0fac9f8000000,0x9419f4243cdcb848,0xdc2822db40c0ac2e,0x183227397098d014
#.section .text

    .globl do_shl
do_shl: 
        mov    rcx, [rsi]
        bt     rcx, 63          # Check if is short second operand
        jc     do_shll
do_shls:

        movsx rax, ecx
        cmp rax, 0
        jz  setzero
        jl  do_shlcl

        cmp rdx, 31
        jae do_shlcl

        mov cl, dl 
        shl rax, cl
        mov rcx, rax
        shr rcx, 31
        jnz do_shlcl
        mov [rdi], rax
        jmp temp_end

do_shlcl:


        call Fr_toLongNormal


        jmp do_shlln

do_shll:
        bt      rcx, 62          # Check if is short second operand
        jnc     do_shlln


        call Fr_toNormal


do_shlln:
        mov r11b, 0x80
        shl r11d, 24
        mov [rdi+4], r11d
        add     rdi, 8
        add     rsi, 8
        call    rawShl

        jmp     temp_end

setzero:
        xor rax, rax
        mov [rdi], rax

        ret

        .type do_shl,@function
        .size do_shl,. - do_shl

Fr_toLongNormal:
        ret

Fr_toNormal:
        ret

rawShl:
        ret

temp_end:
        ret


