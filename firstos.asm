        BITS 16

start:
        mov ax, 07C0h           ; Standard commands
        add ax, 288
        mov ss, ax
        mov sp, 4096            ; standard commands finish

        mov ax, 07C0h
        mov ds, ax

        mov si, text_string
        call read_keyboard

        jmp $

        text_string db 'This my OS!', 0

read_keyboard:
.reading:
        mov ah, 00h  ; Get the keyboard values
        int 16h

        mov ah, 0Eh   ; Print keyboard values
        int 10h

        cmp al, '/'
        je .done

        jmp .reading


.done:

        mov ah,53h            ;this is an APM command
        mov al,00h            ;installation check command
        mov bx,0001h          ; all devices
        int 15h               ;call the BIOS function through interrupt 15h
        ; jc APM_error

        mov ah,53h               ;this is an APM command
        mov al,04h               ;interface disconnect command
        mov bx,0001h             ; all devices
        int 15h                  ;call the BIOS function through interrupt 15h

        mov ah,53h               ;this is an APM command
        mov al,[01h]             ;connect in real mode
        mov bx,0001h             ; all devices
        int 15h                  ;call the BIOS function through interrupt 15h

        mov ah,53h              ;this is an APM command
        mov al,08h              ;Change the state of power management...
        mov bx,0001h            ;...on all devices to...
        mov cx,0001h            ;...power management on.
        int 15h                 ;call the BIOS function through interrupt 15h

        mov ah,53h              ;this is an APM command
        mov al,07h              ;Set the power state...
        mov bx,0001h            ;...on all devices to...
        mov cx,[03h]    ;see above
        int 15h                 ;call the BIOS function through interrupt 15h

        ret

        times 510-($-$$) db 0
        dw 0xAA55

