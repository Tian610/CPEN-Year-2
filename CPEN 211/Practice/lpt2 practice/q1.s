.global _start
_start:
    LDR R0, =data // set base of A = first address of array “data”
    MOV R1, #1 // i=1
    MOV R2, #1 // j=1
    MOV R3, #1 // k=1
    BL func

END: B END // infinite loop; R0 should contain return value of func
.global func
func:

    CMP R1, R2
    BEQ True

    // Else
    LDR R4, [R0]
    SUB R5, R4, R3
    STR R5, [R0, #4]
    B Midexit

    True:
        LDR R4, [R0, #4]
        ADD R5, R4, R3
        STR R5, [R0] 
        B Midexit

    Midexit:
        CMP R1, R3
        BLT Inner
        B Else

    Inner:
        CMP R1, R2
        BLT InnerInner
        B Exit

    InnerInner:
        RSB R4, R2, #0
        STR R4, [R0, #8] 
        B Exit

    Else:
        ADD R5, R2, #1
        STR R5, [R0, #12]
        B Exit

    Exit:
        ADD R6, R1, R2
        SUB R7, R6, R3
        MOV R0, R7
    
    MOV PC, LR

data:
 .word 0
 .word 0
 .word 0
 .word 0