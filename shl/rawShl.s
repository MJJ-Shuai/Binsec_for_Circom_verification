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

    .globl rawShl
rawShl:
        mov rbx, rdx
        cmp rdx, 0
        je Fr_rawCopy
        
        cmp rdx, 254
        jae Fr_rawZero

        mov r8, rdx
        shr r8,6
        mov rcx, rdx
        and rcx, 0x3F
        jz rawShl_aligned
        mov ch, 64
        sub ch, cl


        mov r10, 1
        shl r10, cl
        sub r10, 1
        mov r9, r10
        not r9

        mov rdx, rsi
        mov rax, r8
        shl rax, 3
        sub rdx, rax


        cmp r8, 3
        jae rawShl_if2_3

        mov rax, [rdx + 24 ]
        shl rax, cl
        and rax, r9
        mov r11, [rdx + 16 ]
        rol cx, 8
        shr r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11

        mov r12, 0x3fffffffffffffff
        and rax, r12

        
        mov [rdi + 24], rax

        jmp rawShl_endif_3
rawShl_if2_3:
        jne rawShl_else_3

        mov rax, [rdx + 24 ]
        shl rax, cl
        and rax, r9

        mov r12, 0x3fffffffffffffff
        and rax, r12

        
        mov [rdi + 24], rax

        jmp rawShl_endif_3
rawShl_else_3:
        xor rax, rax
        mov [rdi + 24], rax
rawShl_endif_3:

        cmp r8, 2
        jae rawShl_if2_2

        mov rax, [rdx + 16 ]
        shl rax, cl
        and rax, r9
        mov r11, [rdx + 8 ]
        rol cx, 8
        shr r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11

        
        mov [rdi + 16], rax

        jmp rawShl_endif_2
rawShl_if2_2:
        jne rawShl_else_2

        mov rax, [rdx + 16 ]
        shl rax, cl
        and rax, r9

        
        mov [rdi + 16], rax

        jmp rawShl_endif_2
rawShl_else_2:
        xor rax, rax
        mov [rdi + 16], rax
rawShl_endif_2:

        cmp r8, 1
        jae rawShl_if2_1

        mov rax, [rdx + 8 ]
        shl rax, cl
        and rax, r9
        mov r11, [rdx + 0 ]
        rol cx, 8
        shr r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11

        
        mov [rdi + 8], rax

        jmp rawShl_endif_1
rawShl_if2_1:
        jne rawShl_else_1

        mov rax, [rdx + 8 ]
        shl rax, cl
        and rax, r9

        
        mov [rdi + 8], rax

        jmp rawShl_endif_1
rawShl_else_1:
        xor rax, rax
        mov [rdi + 8], rax
rawShl_endif_1:

        cmp r8, 0
        jae rawShl_if2_0

        mov rax, [rdx + 0 ]
        shl rax, cl
        and rax, r9
        mov r11, [rdx + -8 ]
        rol cx, 8
        shr r11, cl
        rol cx, 8
        and r11, r10
        or rax, r11

        
        mov [rdi + 0], rax

        jmp rawShl_endif_0
rawShl_if2_0:
        jne rawShl_else_0

        mov rax, [rdx + 0 ]
        shl rax, cl
        and rax, r9

        
        mov [rdi + 0], rax

        jmp rawShl_endif_0
rawShl_else_0:
        xor rax, rax
        mov [rdi + 0], rax
rawShl_endif_0:



        
        

        # Compare with q

        mov rax, [rdi + 24]
        mov r12, 0x30644e72e131a029
        cmp rax, r12
        jc tmp_109        # q is bigget so done.
        jnz tmp_108         # q is lower

        mov rax, [rdi + 16]
        mov r12, 0xb85045b68181585d
        cmp rax, r12
        jc tmp_109        # q is bigget so done.
        jnz tmp_108         # q is lower

        mov rax, [rdi + 8]
        mov r12, 0x2833e84879b97091
        cmp rax, r12
        jc tmp_109        # q is bigget so done.
        jnz tmp_108         # q is lower

        mov rax, [rdi + 0]
        mov r12, 0x43e1f593f0000001
        cmp rax, r12
        jc tmp_109        # q is bigget so done.
        jnz tmp_108         # q is lower

        # If equal substract q
tmp_108:

        mov r12, 0x43e1f593f0000001
        mov rax, r12
        sub [rdi + 0], rax

        mov r12, 0x2833e84879b97091
        mov rax, r12
        sbb [rdi + 8], rax

        mov r12, 0xb85045b68181585d
        mov rax, r12
        sbb [rdi + 16], rax

        mov r12, 0x30644e72e131a029
        mov rax, r12
        sbb [rdi + 24], rax

tmp_109:

        ret#

rawShl_aligned:
        mov rdx, rsi
        mov rax, r8
        shl rax, 3
        sub rdx, rax


        cmp r8, 3
        ja rawShl_if3_3
        mov rax, [rdx + 24 ]

        mov r12, 0x3fffffffffffffff
        and rax, r12
        
        mov [rdi + 24], rax
        jmp rawShl_endif3_3
rawShl_if3_3:
        xor rax, rax 
        mov [rdi + 24], rax
rawShl_endif3_3:

        cmp r8, 2
        ja rawShl_if3_2
        mov rax, [rdx + 16 ]
        
        mov [rdi + 16], rax
        jmp rawShl_endif3_2
rawShl_if3_2:
        xor rax, rax 
        mov [rdi + 16], rax
rawShl_endif3_2:

        cmp r8, 1
        ja rawShl_if3_1
        mov rax, [rdx + 8 ]
        
        mov [rdi + 8], rax
        jmp rawShl_endif3_1
rawShl_if3_1:
        xor rax, rax 
        mov [rdi + 8], rax
rawShl_endif3_1:

        cmp r8, 0
        ja rawShl_if3_0
        mov rax, [rdx + 0 ]
        
        mov [rdi + 0], rax
        jmp rawShl_endif3_0
rawShl_if3_0:
        xor rax, rax 
        mov [rdi + 0], rax
rawShl_endif3_0:


        
        

        # Compare with q

        mov rax, [rdi + 24]
        mov r12, 0x30644e72e131a029
        cmp rax, r12
        jc tmp_111        # q is bigget so done.
        jnz tmp_110         # q is lower

        mov rax, [rdi + 16]
        mov r12, 0xb85045b68181585d
        cmp rax, r12
        jc tmp_111        # q is bigget so done.
        jnz tmp_110         # q is lower

        mov rax, [rdi + 8]
        mov r12, 0x2833e84879b97091
        cmp rax, r12
        jc tmp_111        # q is bigget so done.
        jnz tmp_110         # q is lower

        mov rax, [rdi + 0]
        mov r12, 0x43e1f593f0000001
        cmp rax, r12
        jc tmp_111        # q is bigget so done.
        jnz tmp_110         # q is lower

        # If equal substract q
tmp_110:

        mov r12, 0x43e1f593f0000001
        mov rax, r12
        sub [rdi + 0], rax

        mov r12, 0x2833e84879b97091
        mov rax, r12
        sbb [rdi + 8], rax

        mov r12, 0xb85045b68181585d
        mov rax, r12
        sbb [rdi + 16], rax

        mov r12, 0x30644e72e131a029
        mov rax, r12
        sbb [rdi + 24], rax

tmp_111:

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

        .type rawShl,@function
        .size rawShl,. - rawShl

