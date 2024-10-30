.intel_syntax noprefix
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
    .globl Fr_square
Fr_square:
        mov    r8, [rsi]
        bt     r8, 63          ; Check if is short first operand
        jc     square_l1

square_s1:                       ; Both operands are short

        xor    rax, rax
        mov    eax, r8d
        imul   eax
        jo     square_manageOverflow   ; rsi already is the 64bits result

        mov    [rdi], rax       ; not necessary to adjust so just save and return

square_manageOverflow:                 ; Do the operation in 64 bits
        push   rsi
        movsx  rax, r8d
        imul   rax
        mov    rsi, rax
        call   rawCopyS2L
        pop    rsi

        ret

square_l1:
        bt     r8, 62          ; check if montgomery first
        jc     square_l1m
square_l1n:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        call Fr_rawMSquare
        sub rdi, 8
        sub rsi, 8


        push rsi
        add rdi, 8
        mov rsi, rdi
        lea rdx, [R3]
        call Fr_rawMMul
        sub rdi, 8
        pop rsi

        ret

square_l1m:
        mov r11b, 0xC0
        shl r11d, 24
        mov [rdi+4], r11d

        add rdi, 8
        add rsi, 8
        call Fr_rawMSquare
        sub rdi, 8
        sub rsi, 8

        ret
        
    .type Fr_square,@function
	.size Fr_square,. - Fr_square