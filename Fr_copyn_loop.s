	.globl Fr_copyn_loop
Fr_copyn_loop:
        mov     %rsi, %r8
        mov     %rdi, %r9
        mov     $5,   %rax
        mul     %rdx
        mov     %rax, %rcx
        cld
   rep  movsq
        mov     %r8, %rsi
        mov     %r9, %rdi
        ret
	.type Fr_copyn_loop,@function
	.size Fr_copyn_loop,. - Fr_copyn_loop
    