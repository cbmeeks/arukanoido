; Test on collision with foreground char.
;
; A: X position
; Y: Y position
; Returns: A
get_soft_collision:
    lsr
    lsr
    lsr
    sta scrx
    tya
    lsr
    lsr
    lsr
    sta scry
get_hard_collision:
    jsr scrcoladdr
    lda (scr),y
    cmp #bg_minivaus    ; Ignore miniature Vaus displaying # of lifes.
    beq +n
    and #foreground
    cmp #foreground
r:  rts
n:  lda #1
    rts

reflect_h:
    ; Bounce back left.
    lda sprites_d,x         ; Moving to the left?
    bpl +n                  ; No…
    ldy ball_x
    dey
    tya
    ldy ball_y
    jsr get_soft_collision
    bne +r
    beq +j

    ; Bounce back right.
n:  ldy ball_x
    iny
    tya
    ldy ball_y
    jsr get_soft_collision
    bne +r
j:  lda #64
    jmp +l

reflect:
    ldy sprites_x,x
    iny
    sty ball_x
    tya
    ldy sprites_y,x
    iny
    iny
    sty ball_y
    jsr reflect_h

reflect_v:
    ; Bounce back from top.
    lda sprites_d,x         ; Are we flying upwards?
    clc
    adc #64
    bpl +n                  ; No…
    lda ball_x
    ldy ball_y
    dey
    jsr get_soft_collision
    bne +r
    beq +j

    ; Bounce back from bottom.
n:  lda ball_x
    ldy ball_y
    iny
    jsr get_soft_collision
    bne +r
j:  lda #128
l:  clc
    adc side_degrees
    sta side_degrees
    inc has_collision
    jsr hit_brick
    bcs +r
    inc has_hit_brick

r:  rts
