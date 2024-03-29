; rdi - first arg
; rax - return

		global		ft_strdup

		extern		malloc
		extern		ft_strlen
		extern		ft_strcpy

		section		.text

ft_strdup:
		mov			rax, 0
		call		ft_strlen
		inc			rax
		push		rdi
		mov			rdi, rax
		call		malloc wrt ..plt
		cmp			rax, 0
		je			exit
		mov			rdi, rax
		pop			rsi
		call		ft_strcpy

exit:
	ret