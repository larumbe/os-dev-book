	;; A boot sector that prints a string using our function
	[org 0x7c00]		; Tell the ASM where this code will be loaded

	mov bx, HELLO_MSG
	call print_string

	mov bx, GOODBYE_MSG
	call print_string

	jmp $			;Hang

print_string:
	pusha
	mov ah, 0x0e
	;; bx has the address
check:	mov al, [bx]
	cmp al, 0
	je print_string_end
	int 0x10
	add bx, 1
	jmp check
print_string_end:	
	popa
	ret
	

	
	;; Data
HELLO_MSG:
	db 'Hello, World! ', 0
GOODBYE_MSG:
	db 'Goodbye!',0

	;; Padding
	times 510 - ($ - $$) db 0
	dw 0xAA55
