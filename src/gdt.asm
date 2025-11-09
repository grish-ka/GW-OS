GDT_START:
    null_descriptor:
        dd 0
        dd 0

    code_descriptor:
        dw 0xFFFF          ; Limit Low
        dw 0               ; Base Low
        db 0               ; Base Middle
        db 10011010b      ; Access