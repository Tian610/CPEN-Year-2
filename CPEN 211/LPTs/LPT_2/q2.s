.global clunky
clunky:

    MOV R1, #0 // R1 = result
    MOV R2, #0 // R2 = next

    LDR R3, [R0, R2, LSL #2] // Load array at next
    CMP R3, #-1
    BNE Loop
    B Exit

    Loop:
        // tmp = A[next]
        LDR R3, [R0, R2, LSL #2]
        MOV R7, R3 // R7 = tmp

        // result += A[next+1]
        ADD R4, R2, #1 // R2 + 1
        LDR R3, [R0, R4, LSL #2]
        ADD R1, R1, R3

        MOV R5, R7, LSR #1
        AND R5, #1 // R7/2 & 1
        CMP R5, #1 // if above
        BNE Else

        // A[R2] = -1;
        MOV R6, #-1
        STR R6, [R0, R2, LSL #2] 
        B LoopCondition

        Else:
            MOV R6, #-2
            STR R6, [R0, R2, LSL #2] 
            B LoopCondition

        LoopCondition:
            MOV R2, R7 // next = tmp
            LDR R3, [R0, R2, LSL #2]
            CMP R3, #-1
            BNE Loop
            B Exit

    Exit:
        MOV R0, R1
        MOV PC, LR

.global _start
_start:
    LDR R0,=A // Array A
    BL clunky
end: B end // infinite loop; R0 should contain return value of clunky

A: .word 4,1,6,2,2,3,-1,4