; ---------------------------------------------------------------------------
; Oscillating number subroutines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

; Initialise the values

OscillateNumInit:			; XREF: GM_Level
		lea	(v_oscillate).w,a1
		lea	(@baselines).l,a2
		moveq	#$20,d1

	@loop:
		move.w	(a2)+,(a1)+	; copy baseline values to RAM
		dbf	d1,@loop
		rts	


; ===========================================================================
@baselines:	dc.b %00000000		; oscillation direction bitfield
		dc.b %01111100
		incbin	"misc\Oscillating Number Baselines.bin"
		even

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

; Oscillate values

OscillateNumDo:				; XREF: GM_Level
	if DontFreezeOnDeath=0
		cmpi.b	#6,(v_player+obRoutine).w ; has Sonic just died?
		bcc.s	@end		; if yes, branch
	endc
		lea	(v_oscillate).w,a1
		lea	(@settings).l,a2
		move.w	(a1)+,d3	; get oscillation direction bitfield
		moveq	#$F,d1

@loop:
		move.w	(a2)+,d2	; get frequency
		move.w	(a2)+,d4	; get amplitude
		btst	d1,d3		; check oscillation direction
		bne.s	@down		; branch if 1

	@up:
		move.w	2(a1),d0
		add.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,0(a1)
		cmp.b	0(a1),d4
		bhi.s	@next
		bset	d1,d3
		bra.s	@next

	@down:
		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,0(a1)
		cmp.b	0(a1),d4
		bls.s	@next
		bclr	d1,d3

	@next:
		addq.w	#4,a1
		dbf	d1,@loop
		move.w	d3,(v_oscillate).w

@end:
		rts	
; End of function OscillateNumDo

; ===========================================================================
@settings:	dc.w 2,	$10	; frequency, amplitude
		dc.w 2,	$18
		dc.w 2,	$20
		dc.w 2,	$30
		dc.w 4,	$20
		dc.w 8,	8
		dc.w 8,	$40
		dc.w 4,	$40
		dc.w 2,	$50
		dc.w 2,	$50
		dc.w 2,	$20
		dc.w 3,	$30
		dc.w 5,	$50
		dc.w 7,	$70
		dc.w 2,	$10
		dc.w 2,	$10
		even
