	;; load DH sectors to ES:BX from drive Dl
disk_load:
	push dx			; store DX on stack so later we can recall how many sectors
	;; were requested to be read, even if changed
	mov ah, 0x02		; BIOS read sector function
	mov al, dh		; Read DH sectors
	mov ch, 0x00		; Cylinder 0
	mov dh, 0x00		; Head 0
	mov cl, 0x02		; Start reading from the second sector
	int 0x13		; bios interrupt

	jc disk_error		; Carry flag set means no sector was loaded

	pop dx			; restore DX
	cmp dh, al		; !(sectors read == sectors expected)
	jne disk_error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

	;; Variables
DISK_ERROR_MSG db 'Disk read error!", 0	
	
	
	
