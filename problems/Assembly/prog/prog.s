main:
    # grow stack for locals
    addi sp sp -12

    sw x0 4(sp) # res = 0
    sw x0 8(sp) # cur = 0
    sw x0 0(sp) # i = 0


    # for(int i=0;i<5;i++)
    for_start:
    li x11 5 # x11 = 5
    lw x12 0(sp) # x12 = i
    bge x12 x11 for_end
    
    # iter(&s);
    addi x11 sp 4 # x11 = &s

    # grow stack for params
    addi sp sp -4
    sw x11 0(sp)
    call iter
    addi sp sp 4
    # shrink stack for params

    # s.res+=s.cur;
    lw x11 8(sp) # x11 = cur
    lw x12 4(sp) # x12 = res
    add x12 x12 x11
    sw x12 4(sp)

    lw x12 0(sp)
    addi x12 x12 1
    sw x12 0(sp)
    j for_start
    for_end:

    # print
    lw x11 8(sp)
    addi sp sp -4
    sw x11 0(sp)
    call print
    addi sp sp 4

    #shrink stack
    addi sp sp 12
    
    # exit
    li x10 10
    ecall

iter:
    addi sp sp -8
    sw ra 4(sp)

    # j = 0
    sw x0 0(sp)

    for2_start:
    li x11 5
    lw x12 0(sp) # x12 = j
    bge x12 x11 for2_end

    # upgrade
    addi sp sp -8
    lw x11 16(sp) # x11 = s*
    lw x12 8(sp) # x12 = j

    sw x11 4(sp)
    sw x12 0(sp)
    call upgrade
    addi sp sp 8
    
    # j++
    lw x11 0(sp)
    addi x11 x11 1
    sw x11 0(sp)
    j for2_start
    for2_end:


    lw ra 4(sp)
    addi sp sp 8
    ret


upgrade:
    lw x11 4(sp) # x11 = s*
    lw x12 0(sp) # x12  = j
    lw x13 4(x11) # x13 = curr
    add x13 x13 x12 # x13 = curr + j
    sw x13 4(x11) # cur = x13
    ret

print:
    li x10 1
    lw x11 0(sp)
    ecall

    li x10 11
    li x11 10
    ecall

    ret
