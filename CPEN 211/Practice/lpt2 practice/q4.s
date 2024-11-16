.global _start
_start:
    MOV R0, #2 // n=2
    LDR R1, =input // base of A = ftrst address of array “input”
    LDR R2, =output // base of B = ftrst address of array “output”
    BL loopy
END: B END // Infinite loop; R0 should contatn return value of loopy

.global loopy
loopy:
    MOV R3, #0 // L1norm 
    MOV R4, #0 // tmp

    Loop:
    LDR R5, [R1, R4, LSL #2]

    CMP R5, #0
    BGE Else

    RSB R5, R5, #0
    
    Else:
    STR R5, [R2, R4, LSL #2]
    ADD R3, R3, R5
    ADD R4, R4, #1

    CMP R4, R0
    BLT Loop

    MOV R0, R3

    MOV PC, LR

input:
 .word -1
 .word 1
output:
 .word 0
 .word 0