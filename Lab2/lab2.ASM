        org 100h

Start:
        mov     ax, 0c0ah
        mov     dx, Input
        int     21h

        xor     bx, bx
        mov     bl, [Input + 1]

        cmp     bx, 6
        jb      .NoAns

        mov     ah, [Input + 5]
        cmp     ah, [Input + 6]
        jne     .NoAns

        cmp     ah, 'a'
        jb      .NoAns
        cmp     ah, 'z'
        ja      .NoAns

        mov     ah, [Input + bx - 2]
        cmp     ah, '0'
        jb      .NoAns
        cmp     ah, '9'
        ja      .NoAns

        mov     ah, 09h
        mov     dx, Yes
        int     21h
        jmp     .Finish

.NoAns:
        mov     ah, 09h
        mov     dx, No
        int     21h
        jmp     .Finish

.Finish:
        mov     ah, 08h
        int     21h
        ret

Input   db      10, 0, 10 dup(?)
Yes     db      13, 10, 'Yes', 13, 10, '$'
No      db      13, 10, 'No', 13, 10, '$'