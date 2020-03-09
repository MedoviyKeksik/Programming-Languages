        org 100h

Start:
        mov     ah, 09h
        mov     dx, strHello
        int     21h

        mov     ah, 0ah
        mov     dx, strInput
        int     21h

        mov     ah, 09h
        mov     dx, newStr
        int     21h

        mov     ah, 09h
        mov     bh, 0
        mov     bl, [strInput + 1]
        mov     [strInput + bx + 2], '$'
        mov     dx, strInput
        add     dx, 2
        int     21h

        mov     ah, 08h
        int     21h
        ret


strHello        db      "Enter your name: ", '$'

newStr          db      13, 10, 'Preved, ', '$'

strInput        db      21, 0, 21 dup (?), 0
