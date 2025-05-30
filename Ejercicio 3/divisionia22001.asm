section .data
    a dd 144
    b dd 12
    texto db "Resultado de 144 / 12 es: ", 0
    texto_len equ $ - texto
    lf db 10

section .bss
    num_ascii resb 12

section .text
    global _start

_start:
    mov eax, [a]
    xor edx, edx
    div dword [b]      ; eax = 12

    mov edi, num_ascii + 10
    mov byte [edi], 0
    dec edi
    mov byte [edi], 10

    test eax, eax
    jz .cero

    mov ecx, 10
.a_decimal:
    dec edi
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .a_decimal
    jmp .listo

.cero:
    dec edi
    mov byte [edi], '0'

.listo:
    ; Escribir texto
    mov eax, 4
    mov ebx, 1
    mov ecx, texto
    mov edx, texto_len
    int 0x80

    ; Escribir resultado
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi]
    mov edx, num_ascii + 11
    sub edx, ecx
    int 0x80

    ; Nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, lf
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
