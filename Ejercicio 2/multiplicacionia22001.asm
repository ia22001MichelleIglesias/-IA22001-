section .data
    op1 db 7
    op2 db 5
    msg_mult db "El resultado de 7 por 5 es: ", 0
    msg_mult_len equ $ - msg_mult
    salto db 10

section .bss
    temp resb 4

section .text
    global _start

_start:
    mov al, [op2]        ; al = 5
    mul byte [op1]       ; ax = 5 * 7 = 35
    mov [temp], al       ; guardar solo el byte bajo

    movzx eax, byte [temp]
    mov edi, temp + 3
    mov byte [edi], 10
    dec edi

    mov ecx, 10
.loop_ascii:
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz .loop_ascii

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mult
    mov edx, msg_mult_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    lea ecx, [edi + 1]
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
