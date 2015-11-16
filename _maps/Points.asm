; ---------------------------------------------------------------------------
; Sprite mappings - points that	appear when you	destroy	something
; ---------------------------------------------------------------------------
Map_Poi:	dc.w @100p-Map_Poi, @200p-Map_Poi
		dc.w @500p-Map_Poi, @1kp-Map_Poi
		dc.w @10p-Map_Poi, @10kp-Map_Poi
		dc.w @100kp-Map_Poi
@100p:		dc.b 1
		dc.b $FC, 4, 0,	0, $F8	; 100 points
@200p:		dc.b 1
		dc.b $FC, 4, 0,	2, $F8	; 200 points
@500p:		dc.b 1
		dc.b $FC, 4, 0,	4, $F8	; 500 points
@1kp:		dc.b 1
		dc.b $FC, 8, 0,	6, $F8	; 1000 points
@10p:		dc.b 1
		dc.b $FC, 0, 0,	6, $FC	; 10 points
@10kp:		dc.b 2
		dc.b $FC, 8, 0,	6, $F4	; 10,000 points
		dc.b $FC, 4, 0,	7, 1
@100kp:		dc.b 2
		dc.b $FC, 8, 0,	6, $F4	; 100,000 points
		dc.b $FC, 4, 0,	7, 6
		even
