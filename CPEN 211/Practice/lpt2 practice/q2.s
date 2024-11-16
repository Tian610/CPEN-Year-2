.global funky
funky:

    MOV R2, #0 // result = 0
    MVN R3, #0 // Top = -1
    MOV R4, #0 // next = 0

    B Loop

    Loop:
        LDR R5, [R0, R4, LSL #2] // A[next]
        CMP R5, #0
        BNE True
        B False
        
        True:
            ADD R3, R3, #1
            ADD R9, R4, #2
            LDR R6, [R0, R9, LSL #2]
            STR R6, [R1, R3, LSL #2]
            ADD R9, R4, #1
            LDR R4, [R0, R9, LSL #2]
            B Midexit

        False:
            ADD R9, R4, #1
            LDR R5, [R0, R9, LSL #2]
            ADD R2, R2, R5

            CMP R3, #0
            BGT InnerTrue
            B InnerFalse

            InnerTrue:
                LDR R5, [R1, R3, LSL #2]
                MOV R4, R5
                SUB R3, R3, #1
                B Midexit

            InnerFalse:
                MVN R4, #0 // Top = -1
                B Midexit

        Midexit:
            CMP R4, #0
            BGT Loop
            B Exit

    Exit:
        MOV R0, R2
        MOV PC, LR

.global _start
_start:
    LDR R0,=A
    LDR R1,=B
    BL funky
end: B end // infinite loop; R0 should contain return value of funky

A: .word 1,3,6, 1,9,12, 0,1,0, 0,2,0, 0,3,0
B: .word 0,0,0,0,0