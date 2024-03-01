; rdi - first arg
; rsi - second arg
; rax - return

		global		ft_strcpy
		section		.text

ft_strcpy:
		mov			rax, rdi
		xor			r8, r8 		; loop counter, set to 0
		xor			r10, r10	; temp variable to store 1 char,
								; r10b - r10b refers to the lowest 8 bits of the r10 register
								; to avoid mismatch in operand sizes

loop:
		cmp			byte[rsi + r8], 0
		je			return
		mov			r10b, byte[rsi + r8]
		mov			byte[rdi + r8], r10b
		inc			r8
		jne			loop

return:
		mov			byte[rdi + r8], 0
		ret
