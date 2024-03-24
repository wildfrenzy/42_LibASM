;rdi	begin_list (t_list **)
;rsi	data_ref (void *)
;rdx	cmp (int (*)())
;rcx	free_fct (void (*)(void *))

;rbx	will have deref of **list, so *list
;r13	tmp for previous node

		global	ft_list_remove_if
		extern	free
		section	.text

ft_list_remove_if:
		push	rbx					;Preserved register: don't use it without saving it
		cmp		rdi, 0
		je		return
		mov		rbx, qword[rdi] 	; loading the address t_list* into rbx
		push	r13
		mov		r13, rbx

loop:
		cmp		rbx, 0
		je		return

		push	rdi	 				; saving all args
		push	rsi
		push	rbx
		push	rcx
		push	rdx

		mov		rdi, qword[rbx]		; moving list->data to rdi
		call	rdx					; trying to call cmp function

		pop		rdx					; bringing back all args
		pop		rcx
		pop		rbx
		pop		rsi
		pop		rdi

		cmp		rax, 0				; check result
		je		delete_data
		mov		r13, rbx			;saving curr node
		mov		rbx, qword[rbx + 8] ; moving to next node
		jmp		loop

return:
		pop		r13
		pop		rbx
		ret

delete_data:
		xor		r8, r8
		cmp		[rdi], rbx			; check if current node is in head
		setz	r8b					; saving cmp result in r8

		push	rdi	 				; saving all args
		push	rsi
		push	rcx
		push	rdx
		push	r8
	; ----------- free data
		mov		rdi, qword[rbx]
		push	rbx					; saving curr node
		call	rcx					; trying to call free_fct(); data is already in rdi
	; ----------- free node
		pop		rbx

		mov		rdi, rbx			; saving current node in rdi, prepared to free
		mov		rbx, [rbx + 8]		; curr = curr->next
		push	rbx
		call	free wrt ..plt		; trying to free node
	; -----------
		pop		rbx
		pop		r8
		pop		rdx
		pop		rcx
		pop		rsi
		pop		rdi

		cmp		r8b, 1
		je		head
		mov		[r13 + 8], rbx		; prev->next = curr->next
		jmp		loop

head:
		mov		[rdi], rbx
		jmp		loop
