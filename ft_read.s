; rdi - first arg [fd]
; rsi - second arg [buf]
; rdx - third arg [count]
; rax - return

		global			ft_read
		extern			__errno_location

		section			.text

ft_read:
		mov				rax, 0 ; system call for read
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
