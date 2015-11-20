; ---------------------------------------------------------------------------
; Object 10 - rings bouncing around
; ---------------------------------------------------------------------------

RingBounce:				; XREF: Obj_Index
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	RBounce_Index(pc,d0.w),d1
		jmp	RBounce_Index(pc,d1.w)
; ===========================================================================
RBounce_Index:	dc.w RBounce_Count-RBounce_Index
		dc.w RBounce_Bounce-RBounce_Index
		dc.w RBounce_Collect-RBounce_Index
		dc.w RBounce_Sparkle-RBounce_Index
		dc.w RBounce_Delete-RBounce_Index
; ===========================================================================

RBounce_Count:	; Routine 0
		movea.l	a0,a1
		moveq	#0,d5
		move.w	obInertia(a1),d5	; check number of rings you have
		subq.w	#1,d5
		move.w	#$288,d4
		bra.s	@makerings
; ===========================================================================

	@loop:
		jsr	FindFreeObj
		bne.w	@resetcounter

@makerings:
		move.b	#id_RingLoss,0(a1) ; load bouncing ring object
		addq.b	#2,obRoutine(a1)
		move.b	#8,obHeight(a1)
		move.b	#8,obWidth(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#$27B2,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#$47,obColType(a1)
		move.b	#8,obActWid(a1)
	if FixedRingTimers=0
		move.b	#-1,(v_ani3_time).w
	endc
		tst.w	d4
		bmi.s	@loc_9D62
		move.w	d4,d0
		jsr	CalcSine
		move.w	d4,d2
		lsr.w	#8,d2
	if UnderwaterRingPhysics=1
		tst.b	(f_water).w		; Does the level have water?
		beq.s	@skiphalvingvel		; If not, branch and skip underwater checks
		move.w	(v_waterpos1).w,d6	; Move water level to d6
		cmp.w	obY(a0),d6		; Is the ring object underneath the water level?
		bgt.s	@skiphalvingvel		; If not, branch and skip underwater commands
		asr.w	d0			; Half d0. Makes the ring's x_vel bounce to the left/right slower
		asr.w	d1			; Half d1. Makes the ring's y_vel bounce up/down slower
@skiphalvingvel:
	endc
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	@loc_9D62
		subi.w	#$80,d4
		bcc.s	@loc_9D62
		move.w	#$288,d4

	@loc_9D62:
		move.w	d2,obVelX(a1)
		move.w	d3,obVelY(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,@loop	; repeat for number of rings (max 31)

@resetcounter:
	if FixedRingTimers=1
		moveq   #-1,d0                  ; Move #-1 to d0
                move.b  d0,obDelayAni(a0)       ; Move d0 to new timer
		move.b	d0,(v_ani3_time).w	; Move d0 to old timer (for animated purposes)
	else
		nop
	endc

RBounce_Bounce:	; Routine 2
		move.b	(v_ani3_frame).w,obFrame(a0)
		jsr	SpeedToPos
		addi.w	#$18,obVelY(a0)
	if UnderwaterRingPhysics=1
		tst.b	(f_water).w		; Does the level have water?
		beq.s	@skipbounceslow		; If not, branch and skip underwater checks
		move.w	(v_waterpos1).w,d6	; Move water level to d6
		cmp.w	obY(a0),d6		; Is the ring object underneath the water level?
		bgt.s	@skipbounceslow		; If not, branch and skip underwater commands
		subi.w	#$E,obVelY(a0)		; Reduce gravity by $E ($18-$E=$A), giving the underwater effect
@skipbounceslow:
	endc
		bmi.s	@chkdel
		move.b	(v_vbla_byte).w,d0
		add.b	d7,d0
		andi.b	#3,d0
		bne.s	@chkdel
		
	if RingsBounceAtZoneBottom=1 ;Mercury Rings Bounce At Zone Bottom
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has object moved below level boundary?
		blt.s	@bounce		; if yes, branch
	endc	;end Rings Bounce At Zone Bottom
		
		jsr	ObjFloorDist
		tst.w	d1
		bpl.s	@chkdel
		add.w	d1,obY(a0)
		
	if RingsBounceAtZoneBottom=1 ;Mercury Rings Bounce At Zone Bottom
	@bounce:
	endc	;end Rings Bounce At Zone Bottom
	
		move.w	obVelY(a0),d0
		asr.w	#2,d0
		sub.w	d0,obVelY(a0)
		neg.w	obVelY(a0)

	@chkdel:
	if FixedRingTimers=1
		subq.b  #1,obDelayAni(a0)	; Subtract 1
                beq.w   RBounce_Delete	; If 0, delete
	else
		tst.b	(v_ani3_time).w
		beq.w	RBounce_Delete
	endc
		
	if RingsBounceAtZoneBottom=0 ;Mercury Rings Bounce At Zone Bottom
		cmpi.w	#$FF00,(v_limittop2).w		; is vertical wrapping enabled?
		beq.w	RBounce_Display			; if so, branch
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has object moved below level boundary?
		bcs.s	RBounce_Delete	; if yes, branch
	endc	;end Rings Bounce At Zone Bottom
	
	if MagneticRings=1	;Mercury Magnetic Rings
		tst.b	(v_shield).w
		beq.s	@skip
		tst.b	obRender(a0)
		bpl.s	@skip
		
		lea	(v_player).w,a1
		
		move.w	obX(a1),d0	; load Sonic's x-axis position
		sub.w	obX(a0),d0
		bpl.s	@a1
		neg.w	d0
		
	@a1:
		cmpi.w	#$A0,d0
		bhi.s	@skip
		
		move.w	obY(a1),d0	; load Sonic's y-axis position
		sub.w	obY(a0),d0
		bpl.s	@a2
		neg.w	d0
		
	@a2:
		cmpi.w	#$A0,d0
		bhi.s	@skip
		
		move.b	#$A,obRoutine(a0)
		move.b	#id_Rings,0(a0)
		
	@skip:
	endc	;end  Magnetic Rings

	if LostRingsFlash=1	;Mercury Lost Rings Flash
		if FixedRingTimers=1
		move.b	obDelayAni(a0),d0
		else
		move.b	(v_ani3_time).w,d0
		endc
		btst	#0,d0
		beq.w	RBounce_Display
		cmpi.b	#LostRingsFlashTime,d0
		bhi.w	RBounce_Display
		rts
	else
		jmp	DisplaySprite
	endc	;end Lost Rings Flash
	
; ===========================================================================

RBounce_Collect:	; Routine 4
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		move.b	#1,obPriority(a0)
		jsr	CollectRing

RBounce_Sparkle:	; Routine 6
		lea	(Ani_Ring).l,a1
		jsr	AnimateSprite
		jmp	DisplaySprite
; ===========================================================================

RBounce_Delete:	; Routine 8
		jmp	DeleteObject

RBounce_Display:
		jmp	DisplaySprite
		
		even
		even
		even
