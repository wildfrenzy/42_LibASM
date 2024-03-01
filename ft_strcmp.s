; rdi - first arg
; rsi - second arg
; rax - return
; r10 - tmp

		global		ft_strcmp
		section		.text

ft_strcmp:
		cmp			rdi, rsi
		jne			return
		inc			rdi
		inc			rsi
		je 			ft_strcmp

return:
		mov			r10, [rdi]
		sub			r10, [rsi]
		mov			rax, r10
		ret
