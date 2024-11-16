.global _start
_start:
    MOV R0, #1 // i=1
    MOV R1, #1 // j=1
    MOV R2, #1 // k=1
    LDR R3, =data // set base of A = first address of array “data”
    BL func
END: B END // infinite loop; R0 should contain return value of func

.global func
func:
    LDR R5, [R3, #0]
    LDR R6, [R3, #4]
    ADD R4, R5, R6 // R4 = result
    MOV R5, #42
    STR R5, [R3, #0]
    // if ( i & 1 )
    AND R6, R0, #1
    CMP R6, #1
    BNE Next
    // Inner Statement
    MOV R5, #1
    STR R5, [R3, #0]
    // Next If Statement
    Next:
        CMP R1, R2
        BLE Else
        // Inner Statement
        MOV R5, #2
        STR R5, [R3, #4]
        B Exit
    // Else
    Else:
        MOV R5, #3
        STR R5, [R3, #8]
        CMP R0, #0
        BGE Exit
        CMP R2, #10
        BLE Exit
        RSB R6, R1, #0
        STR R6, [R3, #12]

    Exit:
        MOV R0, R4
        MOV PC, LR

data:
 .word 0, 0, 0, 0