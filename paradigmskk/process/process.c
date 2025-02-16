// MAX

int max(int a) {
  short x = a;
  short y = *(((short*)&a) + 1);
  if (x > y) {
	return x;
  } else {
	return y;
  }
}

// PROCESS

typedef struct {
  double d;
  char c[4];
  int i;
} Work;

typedef int(*TransformFN)(int);

int process(int n, Work* w, TransformFN tfn) {
  int ret = 0;
  for (int i = 0; i < n; i += 2) {
	ret += tfn(*(int*)((short*)w[i].c + 1));
  }
  return ret;
}




process:

#typedef struct {
#  double d; 0 8 
#  char c[4]; 8 4
#  int i;  12 4
#} Work; 16

#typedef int(*TransformFN)(int);

#int process(int n, Work* w, TransformFN tfn) {
#  int ret = 0;
   addi sp ,sp ,-8
   addi x11, x0 ,0 # ret = 0
   addi x12, x0 ,0 # i = 0
   sw x11 4(sp) 
   sw x12 0(sp)
#  for (int i = 0; i < n; i += 2) {

START:
   #	ret += tfn(*(int*)((short*)w[i].c + 1));
   
   lw x11, 4(sp) #ret
   lw x12 , 12(sp) #W
   lw x14, 0(sp) #i
   addi x13 ,x0 , 16 # size
   mul x13, x13, x14 
   add x15 , x12 , x13  #w[i]
   addi x15, x15, 10 # w[i].c
   lw x16, 0(x15) # ((short*)w[i].c + 1)
   jalr x16
   add x11 ,x11 ,x16
   sw x11, 4(sp)

   
   lw x11, 0(sp)
   lw x12 8(sp)

   blt x12, x11 , FIN
   addi x11, x11, 2
   sw x11 0(sp)
   j START
FIN:
lw x10 , 4(sp)
addi sp ,sp ,8
ret


#  }
#  return ret;
#}
