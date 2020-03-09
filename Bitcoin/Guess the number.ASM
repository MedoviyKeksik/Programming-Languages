        org 100h

Start:
        ; Getting current time as start random number

        mov     ah, 2ch
        int     21h
        inc     dl
        mov     [Number], dl

        mov     cx, 10

.GuessLoop:
        mov     ah, 09h
        mov     dx, strEnterNumber
        int     21h

        mov     ax, 0c0ah
        mov     dx, InputNumber
        int     21h

        mov     di, [InputNumber + 1]
        and     di, 00FFh
        mov     si, 0
        mov     ax, 0
        mov     bl, 10

@@:
        mov     dh, [InputNumber + si + 2]
        sub     dh, '0'
        jb      .InvalidInput
        cmp     dh, 9
        ja      .InvalidInput
        mul     bl
        add     al, dh
        inc     si
        cmp     si, di
        jnz     @B

        cmp     ax, 100
        ja      .InvalidNumber

        cmp     ax, [Number]
        je      .Guessed
        ja      .NumberAbove
        jb      .NumberBelow

.NumberBelow:
        mov     ah, 09h
        mov     dx, strBelow
        int     21h
        jmp     .Continue

.NumberAbove:
        mov     ah, 09h
        mov     dx, strAbove
        int     21h
        jmp     .Continue

.InvalidInput:
        mov     ah, 09h
        mov     dx, strInvalidInput
        int     21h
        jmp     .GuessLoop

.InvalidNumber:
        mov     ah, 09h
        mov     dx, strInvalidNumber
        int     21h
        jmp     .GuessLoop

.Guessed:
        mov     ah, 09h
        mov     dx, strGuessed
        int     21h
        jmp     .Finish

.Continue:
        loop    .GuessLoop

        mov     ax, [Number]
        div     bl
        test    ah, ah
        jz      @F
        add     ah, '0'

@@:
        mov     byte [Number + 2], ah
        mov     ah, 0
        div     bl
        test    ah, ah
        jz      @F
        add     ah, '0'

@@:
        mov     byte [Number + 1], ah
        test    al, al
        jz      @F
        add     al, '0'

@@:
        mov     byte [Number], al

        mov     ah, 09h
        mov     dx, Number
        int     21h

        mov     ah, 09h
        mov     dx, strSorry
        int     21h

.Finish:
        mov     ax, 0c08h
        int     21h
        test    al, al
        jnz     @f
        mov     ah, 08h
        int     21h

@@:
        ret

Number:
        db      0, 0, 0, '$'

strEnterNumber:
        db      'Enter your number:', 13, 10, '$'

InputNumber:
        db      4, 0, 3 dup('?')

strInvalidInput:
        db      13, 10, 'Invalid input. Try again', 13, 10, '$'

strInvalidNumber:
        db      13, 10, 'Invaliid number. Try again', 13, 10, '$'

strAbove:
        db      13, 10, 'Above', 13, 10, '$'

strBelow:
        db      13, 10, 'Below', 13, 10, '$'

strGuessed:
        db      13, 10, 'Congratulations! You guessed the number!', 13, 10, '$'

strSorry:
        db      ' - guessed number. Sorry, you lose$'