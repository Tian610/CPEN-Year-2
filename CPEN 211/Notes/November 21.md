# Notes

## Control HAzards

### Option 1: Stall

Some terms:

BNE - Label - Branch Instruction
ADD R1, R2, R3 - branch successor

### Option 2: Not Taken

Many "forward" branches are weakly biased meaning they they are taken and taken roughly the same number of times. This means half the time, we could just guess that the branch was not taken and we would be right.

That way, we wouldn't stall about half the time! But what about the other half? We sould need to correct our mistake somehow.

Branch Prediction is much better than just random guessing, Intel and AMD use tons of method to try and predict branches to increase 