process:
    addi sp sp -16 # sp-is chamoweva
    add x11 x0 x0  # int i
    sw x11 12(sp)  # int i-s shenaxva
    add x12 x0 x0  # int ret
    sw x12 8(sp)   # int ret-s shenaxva
    sw ra  4(sp)   # ra-s shenaxva
    loopStart:
        lw x13 16(sp) # int n-s loadi
        bge x11 x13 loopEnd # for-is checki
        lw x14 8(sp)  # curr int ret
        lw x15 20(sp) # work * w
        addi x16 x0 16  # 16 is shenaxva
        mul x17 x16 x11 # 16 * i
        add x15 x15 x17 # w[i] is misamarti
        addi x15 x15 8  # w[i].c is misamarti
        addi x15 x15 2  # w[i].c + 2 misamarti
        lw x18 0(x15)   # int arg
        sw x18 0(sp)    # argumentis stackze dawera
        lw x19 24(sp)   # tfn
        jalr x19        # funqciis gamodzaxeba
        lw x20 8(sp)    # curr int ret
        add x20 x20 a0  # ret + tfn
        sw x20 8(sp)    # ret-is shenaxva stackze
        lw x11 12(sp)   # curr int i
        addi x11 x11 2     # i+=2
        sw x11 12(sp)    # i-is shenaxva stackze
        j loopStart        # loopis shemdegi iteracia
    loopEnd:
        lw a0 8(sp)    # pasuxis shenaxva
        lw ra 4(sp)    # ra-s dabruneba
        addi sp sp 16  # sp-s aweva
        ret               # dasasruli






        process:

#typedef struct {
#  double d; 0 8 
#  char c[4]; 8 4
#  int i;  12 4
#} Work; 16

#typedef int(*TransformFN)(int);
   addi sp ,sp ,-8
   addi x11, x0 ,0 # ret = 0
   addi x12, x0 ,0 # i = 0
   sw x11 4(sp) 
   sw x12 0(sp)
#  for (int i = 0; i < n; i += 2) {

START:
   #	ret += tfn(*(int*)((short*)w[i].c + 1));
   lw x18, 0(sp)
   lw x19 8(sp)

   bge x18, x19 , FIN
   lw x11, 4(sp) #ret
   lw x12 , 12(sp) #W
   lw x14, 0(sp) #i
   addi x13 ,x0 , 16 # size
   mul x13, x13, x14 
   add x15 , x12 , x13  #w[i]
   addi x15, x15, 10 # w[i].c
   lw x16, 0(x15) # ((short*)w[i].c + 1)
   mv  x10, x16  
   lw x17, 16(sp)
   jalr x17
   lw x11,  4(sp)  
   add x11 ,x11 ,x10
   sw x11, 4(sp)

   lw x14, 0(sp) 
   addi x14, x14, 2
   sw x14 0(sp)
   j START

FIN:
 lw x10 , 4(sp)
 addi sp ,sp ,8
 ret
