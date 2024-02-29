; rdi - is our arg

		global		ft_strlen
		section		.text
ft_strlen:
		mov			rax, 0

loop:
		cmp			byte [rdi + rax], 0
		je			ret
		inc			rax
		jne			loop

ret:
		ret
