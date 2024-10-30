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

    .globl Fr_rawFromMontgomery
Fr_rawFromMontgomery:
    #push r15
    #push r14
    #push r13
    #push r12
    mov rcx,rdx
    mov r9,0xc2e1f593efffffff
    xor r10,r10

# FirstLoop
    mov r11,[rsi +0]
    mov r12,[rsi +8]
    mov r13,[rsi +16]
    mov r14,[rsi +24]
    mov r15,r10
# SecondLoop
    mov rdx,r9
    mulx rax,rdx,r11
    mov    rbx, 0x43e1f593f0000001 
    mulx r8,rax,rbx
    adcx rax,r11
    mov    rbx, 0x2833e84879b97091 
    mulx rax,r11,rbx
    adcx r11,r8
    adox r11,r12
    mov    rbx, 0xb85045b68181585d
    mulx r8,r12,rbx
    adcx r12,rax
    adox r12,r13
    mov    rbx, 0x30644e72e131a029
    mulx rax,r13,rbx
    adcx r13,r8
    adox r13,r14
    mov r14,r10
    adcx r14,rax
    adox r14,r15

    mov r15,r10
# SecondLoop
    mov rdx,r9
    mulx rax,rdx,r11
    mov    rbx, 0x43e1f593f0000001 
    mulx r8,rax,rbx
    adcx rax,r11
    mov    rbx, 0x2833e84879b97091 
    mulx rax,r11,rbx
    adcx r11,r8
    adox r11,r12
    mov    rbx, 0xb85045b68181585d
    mulx r8,r12,rbx
    adcx r12,rax
    adox r12,r13
    mov    rbx, 0x30644e72e131a029
    mulx rax,r13,rbx
    adcx r13,r8
    adox r13,r14
    mov r14,r10
    adcx r14,rax
    adox r14,r15

    mov r15,r10
# SecondLoop
    mov rdx,r9
    mulx rax,rdx,r11
    mov    rbx, 0x43e1f593f0000001 
    mulx r8,rax,rbx
    adcx rax,r11
    mov    rbx, 0x2833e84879b97091 
    mulx rax,r11,rbx
    adcx r11,r8
    adox r11,r12
    mov    rbx, 0xb85045b68181585d
    mulx r8,r12,rbx
    adcx r12,rax
    adox r12,r13
    mov    rbx, 0x30644e72e131a029
    mulx rax,r13,rbx
    adcx r13,r8
    adox r13,r14
    mov r14,r10
    adcx r14,rax
    adox r14,r15

    mov r15,r10
# SecondLoop
    mov rdx,r9
    mulx rax,rdx,r11
    mov    rbx, 0x43e1f593f0000001 
    mulx r8,rax,rbx
    adcx rax,r11
    mov    rbx, 0x2833e84879b97091 
    mulx rax,r11,rbx
    adcx r11,r8
    adox r11,r12
    mov    rbx, 0xb85045b68181585d
    mulx r8,r12,rbx
    adcx r12,rax
    adox r12,r13
    mov    rbx, 0x30644e72e131a029
    mulx rax,r13,rbx
    adcx r13,r8
    adox r13,r14
    mov r14,r10
    adcx r14,rax
    adox r14,r15

#comparison
    mov    rbx, 0x30644e72e131a029
    cmp r14,rbx
    jc Fr_rawFromMontgomery_done
    jnz Fr_rawFromMontgomery_sq
    mov    rbx, 0xb85045b68181585d
    cmp r13,rbx
    jc Fr_rawFromMontgomery_done
    jnz Fr_rawFromMontgomery_sq
    mov    rbx, 0x2833e84879b97091 
    cmp r12,rbx
    jc Fr_rawFromMontgomery_done
    jnz Fr_rawFromMontgomery_sq
    mov    rbx, 0x43e1f593f0000001 
    cmp r11,rbx
    jc Fr_rawFromMontgomery_done
    jnz Fr_rawFromMontgomery_sq
Fr_rawFromMontgomery_sq:
    mov    rbx, 0x43e1f593f0000001 
    sub r11,rbx
    mov    rbx, 0x2833e84879b97091 
    sbb r12,rbx
    mov    rbx, 0xb85045b68181585d
    sbb r13,rbx
    mov    rbx, 0x30644e72e131a029
    sbb r14,rbx
Fr_rawFromMontgomery_done:
    mov [rdi + 0],r11
    mov [rdi + 8],r12
    mov [rdi + 16],r13
    mov [rdi + 24],r14
    #pop r12
    #pop r13
    #pop r14
    #pop r15
    ret

    .type Fr_rawFromMontgomery,@function
	.size Fr_rawFromMontgomery,. - Fr_rawFromMontgomery

