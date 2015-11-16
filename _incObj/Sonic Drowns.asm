; ---------------------------------------------------------------------------
; Sonic when he's drowning
; ---------------------------------------------------------------------------
 
; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
 
 
Sonic_Drowned:
		bsr.w	SpeedToPos		; make Sonic able to move
		addi.w	#$10,obVelY(a0)		; apply gravity
		bsr.w	Sonic_RecordPosition	; record position
		bsr.s	Sonic_Animate		; animate Sonic
		bsr.w	Sonic_LoadGfx		; load Sonic's DPLCs
		bra.w	DisplaySprite		; and finally, display Sonic