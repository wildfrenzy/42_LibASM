; rdi - first arg [fd]
; rsi - second arg [string]
; rdx - third arg [size]
; rax - return

		global			ft_write
		extern			__errno_location

		section			.text

ft_write:
		mov				rax, 1 ; system call for write
		syscall
		cmp				rax, 0
		jl				negative
		ret

negative:
		neg				rax
		mov				r8, rax
		call			__errno_location
		mov				[rax], r8
		mov				rax, -1
		ret
