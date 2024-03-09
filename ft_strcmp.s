; rdi - first arg
; rsi - second arg
; rax - return
; r8 - tmp

		global		ft_strcmp
		section		.text

ft_strcmp:
		mov			rax, 0
		mov			r8, 0

loop:
		mov			al, byte[rdi] ; lowest 8-bits of rax
		mov			r8b, byte[rsi]
		cmp			al, r8b
		jne			return
		cmp			al, 0
		je			return
		inc			rdi
		inc			rsi
		jmp			loop

return:
		sub			rax, r8
		ret
