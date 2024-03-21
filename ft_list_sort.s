; rdi - begin_list (t_list **)
; rsi - cmp (int (*)())

; rbx	will have deref of **list, so *list

; r15   counter
; r14   for list len
; r13	for previous node
; r12   for tmp data

	global	ft_list_sort
	extern	ft_list_size
	section	.text

ft_list_sort:
	push	rbx
	push	r14
	push	r13
	push	r12
	push	r15

	cmp		rdi, 0
	je		return
	mov		rbx, qword[rdi]				; loading the current address t_list* into rbx

	mov		r13, rbx					; prev = curr

	push	rdi
	push	rsi
	push	rbx

	mov		rdi, rbx
	call	ft_list_size

	pop		rbx
	pop		rsi
	pop		rdi

	mov		r14, rax					; list size
	inc		r14							; for i < size + 1
	xor		r15, r15					; i = 0

loop:
	cmp		rbx, 0						; while curr != NULL
	je		return
	cmp		r15, r14					; while i < size + 1
	je		return

	push	rdi
	push	rsi
	push	rbx

	mov		r8, rsi						; saving cmp (int (*)())
	mov		rdi, qword[rbx]				; s1 - curr->data
	mov		rsi, qword[r13]				; s2 - prev->data
	call	r8

	pop		rbx
	pop		rsi
	pop		rdi

	cmp		eax, 0						; strcmp returns 32-bit
	jl		swap
	mov		r13, rbx					; prev = curr
	mov		rbx, [rbx + 8]				; curr = curr->next;
	inc		r15							; i++
	jmp		loop

swap:
	mov		r12, qword[rbx]				; tmp = curr->data
	mov		r8, qword[r13]				; r8 = prev->data
	mov		[rbx], r8					; curr->data = prev->data
	mov		[r13], r12					; prev->data = tmp

	mov		rbx, qword[rdi]				; curr = *begin_list
	mov		r13, rbx					; prev = curr
	xor		r15, r15					; i = 0
	jmp		loop

return:
	pop		r15
	pop		r12
	pop		r13
	pop		r14
	pop		rbx
	ret
