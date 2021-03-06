; ---------------------------------------------------------------------------
; Level Headers
; ---------------------------------------------------------------------------

LevelHeaders:

lhead:	macro plc1,lvlgfx,plc2,sixteen,twofivesix,pal
	dc.l (plc1<<24)+lvlgfx
	dc.l (plc2<<24)+sixteen
	dc.l twofivesix
	dc.b 0, $8D, pal, pal
	endm

; 1st PLC, level gfx, 2nd PLC, 16x16 data, 256x256 data,
; palette

;		1st PLC				2nd PLC				256x256 data
;				level gfx			16x16 data			palette

	if S2ArtLoader=1
		if CompInsteadOfKos=1
	lhead	plcid_GHZ,	Comp_GHZ,	plcid_GHZ2,	Blk16_GHZ,	Blk256_GHZ,	palid_GHZ	; Green Hill
	lhead	plcid_LZ,	Comp_LZ,	plcid_LZ2,	Blk16_LZ,	Blk256_LZ,	palid_LZ	; Labyrinth
	lhead	plcid_MZ,	Comp_MZ,	plcid_MZ2,	Blk16_MZ,	Blk256_MZ,	palid_MZ	; Marble
	lhead	plcid_SLZ,	Comp_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk256_SLZ,	palid_SLZ	; Star Light
	lhead	plcid_SYZ,	Comp_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk256_SYZ,	palid_SYZ	; Spring Yard
	lhead	plcid_SBZ,	Comp_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk256_SBZ,	palid_SBZ1	; Scrap Brain
	lhead	0,		Comp_GHZ,	0,		Blk16_GHZ,	Blk256_GHZ,	palid_GHZ	; Ending
		else
	lhead	plcid_GHZ,	Kos_GHZ,	plcid_GHZ2,	Blk16_GHZ,	Blk256_GHZ,	palid_GHZ	; Green Hill
	lhead	plcid_LZ,	Kos_LZ,		plcid_LZ2,	Blk16_LZ,	Blk256_LZ,	palid_LZ	; Labyrinth
	lhead	plcid_MZ,	Kos_MZ,		plcid_MZ2,	Blk16_MZ,	Blk256_MZ,	palid_MZ	; Marble
	lhead	plcid_SLZ,	Kos_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk256_SLZ,	palid_SLZ	; Star Light
	lhead	plcid_SYZ,	Kos_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk256_SYZ,	palid_SYZ	; Spring Yard
	lhead	plcid_SBZ,	Kos_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk256_SBZ,	palid_SBZ1	; Scrap Brain
	lhead	0,		Kos_GHZ,	0,		Blk16_GHZ,	Blk256_GHZ,	palid_GHZ	; Ending
		endc
	else
	lhead	plcid_GHZ,	Nem_GHZ_2nd,	plcid_GHZ2,	Blk16_GHZ,	Blk256_GHZ,	palid_GHZ	; Green Hill
	lhead	plcid_LZ,	Nem_LZ,		plcid_LZ2,	Blk16_LZ,	Blk256_LZ,	palid_LZ	; Labyrinth
	lhead	plcid_MZ,	Nem_MZ,		plcid_MZ2,	Blk16_MZ,	Blk256_MZ,	palid_MZ	; Marble
	lhead	plcid_SLZ,	Nem_SLZ,	plcid_SLZ2,	Blk16_SLZ,	Blk256_SLZ,	palid_SLZ	; Star Light
	lhead	plcid_SYZ,	Nem_SYZ,	plcid_SYZ2,	Blk16_SYZ,	Blk256_SYZ,	palid_SYZ	; Spring Yard
	lhead	plcid_SBZ,	Nem_SBZ,	plcid_SBZ2,	Blk16_SBZ,	Blk256_SBZ,	palid_SBZ1	; Scrap Brain
	lhead	0,		Nem_GHZ_2nd,	0,		Blk16_GHZ,	Blk256_GHZ,	palid_GHZ	; Ending
	endc
	even
