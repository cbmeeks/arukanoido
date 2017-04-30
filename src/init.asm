if @*shadowvic?*
    org $2000
end

relocated_start = @(+ charset 3840)

relocation_offset = @(- relocated_start loaded_start)
loaded_end = @(- relocated_end relocation_offset)

main:
if @*shadowvic?*
    jmp loaded_start
end

    lda #<loaded_end
    sta s
    lda #>loaded_end
    sta @(++ s)
    lda #<relocated_end
    sta d
    lda #>relocated_end
    sta @(++ d)
    ldy #0
l:  lda (s),y
    sta (d),y
    ldx #s
    jsr dec_zp
    ldx #d
    jsr dec_zp
    lda s
    cmp #@(low (-- loaded_start))
    bne -l
    lda @(++ s)
    cmp #@(high (-- loaded_start))
    bne -l
    jmp relocated_start

dec_zp:
    dec 0,x
    pha
    lda 0,x
    cmp #255
    bne +n
    dec 1,x
n:  pla
    rts

loaded_start:
if @(not *shadowvic?*)
    org relocated_start
end

music_player_size = @(length (fetch-file "sound-beamrider/MusicTester.prg"))
loaded_music_player_end = @(+ loaded_music_player (-- music_player_size))
music_player_end = @(+ music_player (-- music_player_size))

    lda #<loaded_music_player_end
    sta s
    lda #>loaded_music_player_end
    sta @(++ s)
    lda #<music_player_end
    sta d
    lda #>music_player_end
    sta @(++ d)
    ldx #<music_player_size
    lda #@(++ (high music_player_size))
    sta @(++ c)

copy_backwards:
    ldy #0
l2: lda (s),y
    sta (d),y
    dec s
    lda s
    cmp #$ff
    beq m2
n2: dec d
    lda d
    cmp #$ff
    beq j2
q2: dex
    bne l2
    dec @(++ c)
    bne l2

    jmp start

m2: dec @(++ s)
    jmp n2

j2: dec @(++ d)
    jmp q2
