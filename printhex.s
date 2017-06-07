	[org 0x7c00]		; Tell the ASM where this code will be loaded
	
	;; mov dx, 0x1fb6
	mov dx, 0x1234
	call print_hex
	jmp $			; Hang

print_hex:
	pusha
	;; Use and and shr
	mov bx, HEX_OUT		; output pointer
	add bx, 5
	;; mov cl, 0		; shift counter

shift_loop:
	cmp dx, 0x0000
	je print_hex_end
	mov ax, dx	
	and ax, 0x000f 
	;; turn into ascii code
	cmp ax, 0x09
	jg digit_gt_9
	add ax, '0'
	jmp digit_out
digit_gt_9:
	sub ax, 10
	add ax, 'a'
digit_out:
	;; Store bytes in descending order
	mov [bx], al
	sub bx, 1
	shr dx, 4
	jmp shift_loop
print_hex_end:	
	mov bx, HEX_OUT
	call print_string
	popa
	ret

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
HEX_OUT:
	db '0x0000',0

	;; Padding
	times 510 - ($ - $$) db 0
	dw 0xAA55
	
