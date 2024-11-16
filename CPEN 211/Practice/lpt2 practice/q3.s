.global _start
_start:
    MOV R0, #1 // i=1
    MOV R1, #2 // j=2
    MOV R2, #1 // k=1
    LDR R3, =data // set base of A = first address of array “data”
    BL func
END: B END // infinite loop; R0 should contain return value of func
.global func

func:
    CMP R0, R1
    BGE Else
    MOV R6, #1
    STR R6, [R3, #0]

    Else:
    CMP R0, R2
    BNE ElseElse

    MOV R6, #2
    STR R6, [R3, #4]

    LDR R4, [R3, #8]
    CMP R4, R1
    BLE ElseElse

    MOV R6, #4
    STR R6, [R3, #12]

    ElseElse:
    ADD R0, R0, R1
    MOV PC, LR
data:
 .word 0
 .word 0
 .word 3
 .word 0