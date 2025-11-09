[org 0x7c00]
jmp initStack
main:
mov ah, 0x0e


mov al, 10
int 0x10
mov al, 13

int 0x10


mov al, 0
; use BL as the loop counter because AL gets clobbered by int 0x10 calls
xor bl, bl
xor si, si          ; SI = column counter
ascii_loop:
    inc bl
    mov bh, bl        ; save current value in BH
    mov dl, bh        ; temp value for decimal conversion
    xor cx, cx        ; CX = 0  ; CL = hundreds, CH = tens

hundreds_loop:
    cmp dl, 100
    jb tens_loop
    sub dl, 100
    inc cl
    jmp hundreds_loop

tens_loop:
    cmp dl, 10
    jb print_digits
    sub dl, 10
    inc ch
    jmp tens_loop

print_digits:
    mov ah, 0x0e      ; BIOS teletype

    cmp cl, 0
    jne print_hundreds
    cmp ch, 0
    jne print_tens

    ; ones only -> print two leading spaces then digit
    mov al, ' '
    int 0x10
    mov al, ' '
    int 0x10
    mov al, dl
    add al, '0'
    int 0x10
    jmp after_digits

print_tens:
    ; one leading space then two digits
    mov al, ' '
    int 0x10
    mov al, ch
    add al, '0'
    int 0x10
    mov al, dl
    add al, '0'
    int 0x10
    jmp after_digits

print_hundreds:
    ; three digits
    mov al, cl
    add al, '0'
    int 0x10
    mov al, ch
    add al, '0'
    int 0x10
    mov al, dl
    add al, '0'
    int 0x10

after_digits:
    ; print ": " then the character
    mov al, ':'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, bh
    int 0x10

    ; separator between columns
    mov al, ' '
    int 0x10
    mov al, ' '
    int 0x10

    inc si
    cmp si, 4         ; columns per row (change to desired number)
    jne skip_newline

    ; newline (LF then CR) and reset column counter
    mov al, 10
    int 0x10
    mov al, 13
    int 0x10
    xor si, si

skip_newline:
    cmp bh, 255
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


call printString

mov al, 10
int 0x10
mov al, 13 
int 0x10

mov bx, msg1
call printString
; mov ah, 2
; mov al, 1

; mov ch, 0
; mov cl, 2
; mov dh, 0
; ; mov dl, [driveNum]
; mov ax, 0
; mov es, ax
; mov bx, 0x7e00

; int 0x13
; mov ah, 0x0e
; call printString
jmp $
; Subroutines
printString:
    mov al, [bx]
    cmp al, 0
    je .done_print       ; if zero, return
    mov ah, 0x0e   ; teletype BIOS func (ensure AH is set)
    int 0x10
    inc bx
    jmp printString
.done_print:
    ret

initStack: ; Initialize stack
    cli                 ; disable interrupts while switching SS
    xor ax, ax
    mov ss, ax          ; SS = 0x0000
    mov sp, 0x8000      ; SP = 0x8000 (stack top)
    sti                 ; re-enable interrupts

    ; make DS point to our code/data segment
    push cs
    pop ax
    mov ds, ax

    mov bx, stackPrintMsg
    call printString
    jmp main
; Data Section

myVar:
    db "Look ma I'm a variable printed out", 0

stackPrintMsg:
    db "Stack initialized to 0x8000", 10, 13 0

msg1:
    db 176, 177, 178, "Hello, World!", 178, 177, 176,0

times 510-($-$$) db 0
db 0x55, 0xaa
