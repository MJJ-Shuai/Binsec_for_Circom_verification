.intel_syntax noprefix
    .globl rawShr
rawShr:
        cmp rdx, 0
        je Fr_rawCopy

        cmp rdx, 254
        jae Fr_rawZero

rawShr_nz:
        mov r8, rdx
        shr r8,6
        mov rcx, rdx
        and rcx, 0x3F
        jz rawShr_aligned
        mov ch, 64
        sub ch, cl

        mov r9, 1
        rol cx, 8
        shl r9, cl
        rol cx, 8
        sub r9, 1
        mov r10, r9
        not r10


        cmp r8, 3
        jae rawShr_if2_0

        mov rax, [rsi + r8*8 + 0 ]
        shr rax, cl
        and rax, r9
        mov r11, [rsi + r8*8 + 8 ]
        rol cx, 8
        shl r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11
        mov [rdi + 0], rax

        jmp rawShr_endif_0
rawShr_if2_0:
        jne rawShr_else_0

        mov rax, [rsi + r8*8 + 0 ]
        shr rax, cl
        and rax, r9
        mov [rdi + 0], rax

        jmp rawShr_endif_0
rawShr_else_0:
        xor  rax, rax
        mov [rdi + 0], rax
rawShr_endif_0:

        cmp r8, 2
        jae rawShr_if2_1

        mov rax, [rsi + r8*8 + 8 ]
        shr rax, cl
        and rax, r9
        mov r11, [rsi + r8*8 + 16 ]
        rol cx, 8
        shl r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11
        mov [rdi + 8], rax

        jmp rawShr_endif_1
rawShr_if2_1:
        jne rawShr_else_1

        mov rax, [rsi + r8*8 + 8 ]
        shr rax, cl
        and rax, r9
        mov [rdi + 8], rax

        jmp rawShr_endif_1
rawShr_else_1:
        xor  rax, rax
        mov [rdi + 8], rax
rawShr_endif_1:

        cmp r8, 1
        jae rawShr_if2_2

        mov rax, [rsi + r8*8 + 16 ]
        shr rax, cl
        and rax, r9
        mov r11, [rsi + r8*8 + 24 ]
        rol cx, 8
        shl r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11
        mov [rdi + 16], rax

        jmp rawShr_endif_2
rawShr_if2_2:
        jne rawShr_else_2

        mov rax, [rsi + r8*8 + 16 ]
        shr rax, cl
        and rax, r9
        mov [rdi + 16], rax

        jmp rawShr_endif_2
rawShr_else_2:
        xor  rax, rax
        mov [rdi + 16], rax
rawShr_endif_2:

        cmp r8, 0
        jae rawShr_if2_3

        mov rax, [rsi + r8*8 + 24 ]
        shr rax, cl
        and rax, r9
        mov r11, [rsi + r8*8 + 32 ]
        rol cx, 8
        shl r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11
        mov [rdi + 24], rax

        jmp rawShr_endif_3
rawShr_if2_3:
        jne rawShr_else_3

        mov rax, [rsi + r8*8 + 24 ]
        shr rax, cl
        and rax, r9
        mov [rdi + 24], rax

        jmp rawShr_endif_3
rawShr_else_3:
        xor  rax, rax
        mov [rdi + 24], rax
rawShr_endif_3:


        ret

rawShr_aligned:

        cmp r8, 3
        ja rawShr_if3_0
        mov rax, [rsi + r8*8 + 0 ]
        mov [rdi + 0], rax
        jmp rawShr_endif3_0
rawShr_if3_0:
        xor rax, rax
        mov [rdi + 0], rax
rawShr_endif3_0:

        cmp r8, 2
        ja rawShr_if3_1
        mov rax, [rsi + r8*8 + 8 ]
        mov [rdi + 8], rax
        jmp rawShr_endif3_1
rawShr_if3_1:
        xor rax, rax
        mov [rdi + 8], rax
rawShr_endif3_1:

        cmp r8, 1
        ja rawShr_if3_2
        mov rax, [rsi + r8*8 + 16 ]
        mov [rdi + 16], rax
        jmp rawShr_endif3_2
rawShr_if3_2:
        xor rax, rax
        mov [rdi + 16], rax
rawShr_endif3_2:

        cmp r8, 0
        ja rawShr_if3_3
        mov rax, [rsi + r8*8 + 24 ]
        mov [rdi + 24], rax
        jmp rawShr_endif3_3
rawShr_if3_3:
        xor rax, rax
        mov [rdi + 24], rax
rawShr_endif3_3:

        ret

Fr_rawCopy:

        mov     rax, [rsi + 0]
        mov     [rdi + 0], rax

        mov     rax, [rsi + 8]
        mov     [rdi + 8], rax

        mov     rax, [rsi + 16]
        mov     [rdi + 16], rax

        mov     rax, [rsi + 24]
        mov     [rdi + 24], rax

        ret

Fr_rawZero:
        xor     rax, rax

        mov     [rdi + 0], rax

        mov     [rdi + 8], rax

        mov     [rdi + 16], rax

        mov     [rdi + 24], rax

        ret        
        .type rawShr,@function
        .size rawShr,. - rawShr
