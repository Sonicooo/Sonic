; ---------------------------------------------------------------------------
; Unused floor/wall subroutine - logs something	to do with collision
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FloorLog_Unk:				; XREF: GM_Level
		rts	

		lea	(CollArray1).l,a1
		lea	(CollArray1).l,a2
		move.w	#$FF,d3

loc_14C5E:
		moveq	#$10,d5
		move.w	#$F,d2

loc_14C64:
		moveq	#0,d4
		move.w	#$F,d1

loc_14C6A:
		move.w	(a1)+,d0
		lsr.l	d5,d0
		addx.w	d4,d4
		dbf	d1,loc_14C6A

		move.w	d4,(a2)+
		suba.w	#$20,a1
		subq.w	#1,d5
		dbf	d2,loc_14C64

		adda.w	#$20,a1
		dbf	d3,loc_14C5E

		lea	(CollArray1).l,a1
		lea	(CollArray2).l,a2
		bsr.s	FloorLog_Unk2
		lea	(CollArray1).l,a1
		lea	(CollArray1).l,a2

; End of function FloorLog_Unk

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FloorLog_Unk2:				; XREF: FloorLog_Unk
		move.w	#$FFF,d3

loc_14CA6:
		moveq	#0,d2
		move.w	#$F,d1
		move.w	(a1)+,d0
		beq.s	loc_14CD4
		bmi.s	loc_14CBE

loc_14CB2:
		lsr.w	#1,d0
		bcc.s	loc_14CB8
		addq.b	#1,d2

loc_14CB8:
		dbf	d1,loc_14CB2

		bra.s	loc_14CD6
; ===========================================================================

loc_14CBE:
		cmpi.w	#-1,d0
		beq.s	loc_14CD0

loc_14CC4:
		lsl.w	#1,d0
		bcc.s	loc_14CCA
		subq.b	#1,d2

loc_14CCA:
		dbf	d1,loc_14CC4

		bra.s	loc_14CD6
; ===========================================================================

loc_14CD0:
		move.w	#$10,d0

loc_14CD4:
		move.w	d0,d2

loc_14CD6:
		move.b	d2,(a2)+
		dbf	d3,loc_14CA6

		rts	

; End of function FloorLog_Unk2