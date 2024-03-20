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
		push	rbx						;Preserved register: don't use it without saving it
		cmp		rdi, 0
		je		return
		mov		rbx, qword[rdi] 		; loading the address t_list* into rbx
		push	r13
		mov		r13, rbx

loop:
		cmp		rbx, 0
		je		return

		push	rdi	 			; saving all args
		push	rsi
		push	rbx
		push	rcx
		push	rdx

		mov		rdi, qword[rbx]	; moving list->data to rdi

		call	rdx				; trying to call cmp function

		pop		rdx				; bringing back all args
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
		push	rdi	 				; saving all args
		push	rsi
		push	rbx
		push	rcx
		push	rdx

		mov		rdi, qword[rbx]
		call	rcx					; trying to call free_fct(); data is already in rdi

		pop		rdx
		pop		rcx
		pop		rbx
		pop		rsi
		pop		rdi

		cmp		[rdi], rbx
		je		head
		jmp		connect_nodes
head:
		push	rdi	 				; saving all args
		push	rsi
		push	rcx
		push	rdx

		mov		rdi, rbx			; saving current node in rdi, prepared to free
		mov		rbx, [rbx + 8]		; curr = curr->next

		push	rbx

		call	free				; trying to free node

		pop		rbx
		pop		rdx
		pop		rcx
		pop		rsi
		pop		rdi

		mov		[rdi], rbx
		jmp		loop

connect_nodes:
		push	rdi	 				; saving all args
		push	rsi
		push	rcx
		push	rdx

		mov		rdi, rbx			; saving current node in rdi, prepared to free
		mov		rbx, [rbx + 8] 		; placing next node on the position of current

		push	rbx

		call	free 				; trying to free node

		pop		rbx
		pop		rdx
		pop		rcx
		pop		rsi
		pop		rdi

		mov		[r13 + 8], rbx		; prev->next = curr->next
		jmp		loop
