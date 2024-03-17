;rdi	begin_list (t_list **)
;rsi	data_ref (void *)
;rdx	cmp (int (*)())
;rcx	free_fct (void (*)(void *))

;rbx	will have deref of **list, so *list
;r10	tmp for previous node


		global	ft_list_remove_if
		extern	free
		section	.text

ft_list_remove_if:
		cmp		rdi, 0
		je		return
		mov		rbx, [rdi] 		; loading the address t_list* into rbx
		mov		r10, rbx

loop:
		cmp		rbx, 0
		je		return

		push	rdi	 			; saving all args
		push	rsi
		push	rbx
		push	rcx
		push	rdx
		push	r10

		mov		rdi, qword[rbx]	; moving list->data to rdi

		call	rdx				; trying to call cmp function

		pop		r10
		pop		rdx				; bringing back all args
		pop		rcx
		pop		rbx
		pop		rsi
		pop		rdi

		cmp		rax, 0				; check result
		je		delete_data
		mov		r10, rbx			;saving curr node
		mov		rbx, qword[rbx + 8] ; moving to next node
		jmp		loop

return:
		ret

delete_data:
		push	rdi	 			; saving all args
		push	rsi
		push	rbx
		push	rcx
		push	rdx
		push	r10

		mov		rdi, qword[rbx]
		call	rcx			; trying to call free_fct(); data is already in rdi

		pop		r10
		pop		rdx
		pop		rcx
		pop		rbx
		pop		rsi
		pop		rdi

		cmp		[rdi], rbx
		je		head
		jmp		connect_nodes
head:
		mov		r10, qword[rbx + 8]

		push	rdi	 				; saving all args
		push	rsi
		push	rbx
		push	rcx
		push	rdx
		push	r10

		mov		rdi, rbx			; saving current node in rdi, prepared to free

		call	free				; trying to free node

		pop		r10
		pop		rdx
		pop		rcx
		pop		rbx
		pop		rsi
		pop		rdi

		mov		rbx, r10
		mov		[rdi], rbx
		jmp		loop

connect_nodes:
		push	rdi	 				; saving all args
		push	rsi
		;push	rbx
		push	rcx
		push	rdx
		push	r10

		mov		rdi, rbx			; saving current node in rdi, prepared to free
		mov		rbx, [rbx + 8] 		; placing next node on the position of current

		push	rbx

		call	free 				; trying to free node

		pop		rbx
		pop		r10
		pop		rdx
		pop		rcx
		;pop		rbx
		pop		rsi
		pop		rdi

		mov		[r10 + 8], rbx		; prev->next = curr->next
		jmp		loop
