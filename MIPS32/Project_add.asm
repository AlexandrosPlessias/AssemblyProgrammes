.text
main:

#start of code Project_add.

addi $s0,$zero,10     # s0=0+10=10,      a(hex).
sw   $s0,0($gp)	      # Store $s0 to (Global Pointer + 0).

addi $s1,$s0,1        # s1=s0+1=10+1=11, b(hex).
sw   $s1,4($gp)       # Store $s1 to (Global Pointer + 4).

addi $s2,$s1,1        # s2=s1+1=11+1=12, c(hex).
sw   $s2,8($gp)       # Store $s2 to (Global Pointer + 8).

addi $s3,$s2,1	      # s3=s2+1=12+1=13, d(hex).
sw   $s3,12($gp)      # Store $s3 to (Global Pointer + 12).

addi $s4,$s3,1        # s4=s3+1=13+1=14, e(hex).
sw   $s4,16($gp)      # Store $s4 to (Global Pointer + 16).

addi $s5,$s4,1        # s5=s4+1=14+1=15, f(hex).
sw   $s5,20($gp)      # Store $s5 to (Global Pointer + 20).


add $t0,$s0,$s1       # t0=s0+s1=10+11=21, 15(hex).
add $t1,$s2,$s3       # t1=s2+s3=12+13=25, 19(hex).
add $t2,$s4,$s5       # t2=s4+s5=14+15=29, 1d(hex).

add $t3,$t0,$t1       # t3=t0+t1=21+25=46, 2e(hex).
add $s6,$t3,$t2       # s6=t3+t2=46+29=75, 4b(hex).

sw  $s6,24($gp)       # Store $s6 to (Global Pointer + 24).

#end of code Project_add.