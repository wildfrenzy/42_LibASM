; rdi - begin_list (t_list **)
; rsi - data (void *)

; rbx	will have deref of **begin_list, so *begin_list

		global	ft_list_push_front
		extern	malloc
		section	.text

ft_list_push_front:
		push	rbx
		cmp		rdi, 0
		je		return
		mov		rbx, qword[rdi] 	; loading the address of head t_list* into rbx

		push	rdi					; saving vars
		push	rsi
		push	rbx

		mov		rdi, 16				; 8b - *data; 8b - list->next;
		call	malloc wrt ..plt

		pop		rbx
		pop		rsi
		pop		rdi

		cmp		rax, 0
		je		return

		mov		qword[rax], rsi		; new_node->data = data
		mov		[rax + 8], rbx		; new_node->next = head
		mov		[rdi], rax

return:
		pop		rbx
		ret