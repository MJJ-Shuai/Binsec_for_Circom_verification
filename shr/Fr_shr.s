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

    .globl Fr_shr
Fr_shr:


        mov    rcx, [rbx]
        bt     rcx, 63          # Check if is short second operand
        jnc     tmp_112

        # long 2
        bt     rcx, 62          # Check if is montgomery second operand
        jnc     tmp_113


        call Fr_toNormal


tmp_113:
        mov rcx, [rbx + 8]
        cmp rcx, 254
        jae  tmp_114
        xor rax, rax
        
        cmp [rbx + 16], rax
        jnz tmp_114
        
        cmp [rbx + 24], rax
        jnz tmp_114
        
        cmp [rbx + 32], rax
        jnz tmp_114
        
        mov rbx, rcx
        jmp do_shr

tmp_114:
        mov rcx, 0x43e1f593f0000001
        sub rcx, [rbx+8]
        cmp rcx, 254
        jae  setzero
        mov rax, 0x43e1f593f0000001
        sub rax, [rbx+8]
        
        mov rax, 0x2833e84879b97091 
        sbb rax, [rbx + 16]
        jnz setzero
        
        mov rax, 0xb85045b68181585d
        sbb rax, [rbx + 24]
        jnz setzero
        
        mov rax, 0x30644e72e131a029
        sbb rax, [rbx + 32]
        jnz setzero
        
        mov rdx, rcx
        jmp do_shl

tmp_112:
        cmp ecx, 0
        jl  tmp_115
        cmp ecx, 254
        jae  setzero
        movsx rdx, ecx 
        jmp do_shr
tmp_115:
        neg ecx
        cmp ecx, 254
        jae  setzero
        movsx rdx, ecx 
        jmp do_shl

setzero:
        xor rax, rax
        mov [rdi], rax

        ret

        .type Fr_shr,@function
        .size Fr_shr,. - Fr_shr


Fr_toNormal:
        ret

do_shl:
        ret

do_shr:
        ret
