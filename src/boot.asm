[org 0x7c00]
mov ah, 0x0e

mov al, 0xb0
int 0x10

mov al, 0xb1
int 0x10

mov al, 0xb2
int 0x10

mov al, 'H'

int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ','
int 0x10
mov al, ' '
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

mov al, 0xb2
int 0x10

mov al, 0xb1
int 0x10

mov al, 0xb0
int 0x10

mov al, 10
int 0x10
mov al, 13

int 0x10


mov al, 0
int 0x10
ascii_loop:
    inc al
    int 0x10
    cmp al, 255
    jne ascii_loop



mov bx, 0

loop2:
    mov al, 6
    int 0x10
    inc bx
    cmp bx, 200
    jne loop2


mov al, 10
int 0x10
mov al, 13

int 0x10

; mov al, [myVar]
; int 0x10
mov bx, myVar

printString:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp printString


end:
jmp $

myVar:
    db "Look ma I'm a variable printed out", 0

times 510-($-$$) db 0
db 0x55, 0xaa
