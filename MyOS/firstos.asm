        BITS 16

start:
        mov ax, 07C0h           ; Standard commands
        add ax, 288
        mov ss, ax
        mov sp, 4096            ; standard commands finish

        mov ax, 07C0h
        mov ds, ax
        xor bx, bx
        push bx

        call read_keyboard

        jmp $


read_keyboard:
.reading:
        mov ah, 00h  ; Get the keyboard values
        int 16h

        cmp al, '/'
        je .done

        ; push values in stack
        sub ax, 0x0030
        pop bx
        ; mov ah, 0x00
        ; mov bh, 0x00
        add ax, bx
        push ax

        add al, 0x0030
        mov ah, 0Eh   ; Print ans
        int 10h
        sub ax, 0x0030

        jmp .reading


.done:
        pop ax
        add ax, 0x0030
        mov ah, 0Eh   ; Print ans
        int 10h
        ret

        times 510-($-$$) db 0
        dw 0xAA55

print_al_value:
        mov ah, 0Eh   ; Print keyboard values
        int 10h
        ret
