; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to roll in mid-air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_MidAirRoll:			; XREF: Obj01_MdNormal
		cmpi.b	#id_Roll,obAnim(a0)	; is Sonic already rolling?
		bcs.s	MDR_locret	; if yes, branch
		btst	#staAir,obStatus(a0)	; is Sonic in the air?
		beq.s	MDR_locret	; if not, branch
		move.b	(v_jpadpress2).w,d0
		andi.b	#btnABC,d0	; is A, B or C pressed?
		beq.s	MDR_locret	; if not, branch
		bset	#staAir,obStatus(a0)	;Mercury Constants
		bclr	#staPush,obStatus(a0)	;Mercury Constants
		addq.l	#4,sp
		clr.b	obOnWheel(a0)	;Mercury Constants
		
	;Mercury Clear Control Lock When Jump
		clr.w	obLRLock(a0)	;clear horiz control lock	;Mercury Constants
	;end Clear Control Lock When Jump

		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.b	#id_Roll,obAnim(a0) ; use "jumping" animation
		bset	#staSpin,obStatus(a0)	;Mercury Constants
		addq.w	#5,obY(a0)

MDR_locret:
		rts	
; End of function Sonic_MDRoll