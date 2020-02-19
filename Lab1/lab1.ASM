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

        mov     bh, [strInput + 7]
        mov     bl, [strInput + 8]
        mov     [strInput + 7], bl
        mov     [strInput + 8], bh

        mov     bh, [strInput + 3]
        sub     bh, [strInput + 9]
        mov     bl, [strInput + 4]
        sub     bl, bh
        mov     [strInput + 10], bl

        mov     ah, 09h
        mov     bx, 0
        mov     bl, [strInput + 1]
        mov     [strInput + bx + 2], '$'
        mov     dx, strInput
        add     dx, 2
        int     21h

        mov     ah, 08h
        int     21h
        ret


strHello        db      "Enter your string: ", 10, 13, '$'

newStr          db      10, 13, '$'

strInput        db      20, 0, 20 dup (?)
