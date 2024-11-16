.globl binary_search
binary_search:
  // r1 is the key
  // final answer i is stored in r0
  
  // r0 is the array
  // r0 changes to the return Index
  // r1 is the key  
  // r2 is the length
  // r8 is the key Index initially -1
  // r9 is numIters
  // r4 is the start index
  // r5 is the middle index
  // r6 is the end index
  // r10 is numbers[middleIndex]
  // r11 is temp negative register for -NumIters

  mov r4, #0
  sub r6, r2, #1
  mov r5, r6, LSR #1
  mov r8, #-1
  mov r9, #1

  // Basic Loop Structure - Tian
  // Conditional Statements - Iain
  // Else Statement - Tian
  // Branches - Both

  Loop: CMP r8, #-1 // Exit if keyIndex is found  
        BNE Exit
        
        // Exit if Start Index is greater than End Index
        CMP r4, r6
        BGT Exit

        // Load middle value to r10
        LDR r10, [r0, r5, LSL #2] // Iain

        // Check for equality
        CMP r10, r1
        BEQ conEq

        // Check if greater than
        CMP r10, r1
        BGT conGt

        // Check if less than
        CMP r10, r1
        BLT conLt

        Else: // Tian
        // Set Middle value of array to -NumIters 
        RSB r11, r9, #0
        STR r11, [r0, r5, LSL #2] 

        // Find new middle Index
        SUB r11, r6, r4  
        ADD r5, r4, r11, LSR #1 

        // Increase NumIters
        ADD r9, r9, #1
        B Loop
  Exit:
  mov r0, r8 // Iain
  mov pc,lr

conEq: // Iain
  mov r8, r5 
  B Else

conGt: // Iain
  sub r6, r5, #1 
  B Else

conLt:
  add r4, r5, #1 // Tian
  B Else