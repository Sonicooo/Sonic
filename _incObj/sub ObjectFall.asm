; ---------------------------------------------------------------------------
; Subroutine to	make an	object fall downwards, increasingly fast
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjectFall:
	if FasterObjMove=1
		move.w	obVelX(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,obX(a0)
		move.w	obVelY(a0),d0
		addi.w	#$38,obVelY(a0)	; increase vertical speed
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,obY(a0)
		rts	
	else
		move.l	obX(a0),d2
		move.l	obY(a0),d3
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	obVelY(a0),d0
		addi.w	#$38,obVelY(a0)	; increase vertical speed
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,obX(a0)
		move.l	d3,obY(a0)
		rts	
	endc
 
; End of function ObjectFall