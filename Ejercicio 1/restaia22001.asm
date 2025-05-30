section .data
    valA dw 50
    valB dw 12
    valC dw 8
    res dw 0
    txt db "Resultado de 50 - 12 - 8 es: ", 0
    txt_len equ $ - txt
    nl db 10

section .bss
    temp resb 4

section .text
    global _start

_start:
    mov ax, [valA]
    sub ax, [valB]
    sub ax, [valC]
    mov [res], ax

    mov ax, [res]
    mov edi, temp + 3
    mov byte [edi], 10
    dec edi

    mov cx, 10
.to_ascii:
    xor dx, dx
    div cx
    add dl, '0'
    mov [edi], dl
    dec edi
    test ax, ax
    jnz .to_ascii

    mov eax, 4
    mov ebx, 1
    mov ecx, txt
    mov edx, txt_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    lea ecx, [edi + 1]
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
