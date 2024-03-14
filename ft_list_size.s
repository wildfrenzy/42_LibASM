; rdi - is our arg
; rax - len

		global		ft_list_size
		section		.text
ft_list_size:
		mov			rax, 0

loop:
        inc			rax
        cmp			qword[rdi + 8], 0
		je			ret
        mov         rdi, [rdi + 8]
		jmp			loop

ret:
		ret