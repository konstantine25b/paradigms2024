#include "sum_3bit.h"
#include <stdio.h>


int each(void* d, int index){

  char byte = *((char*)d + index);
  
  char sign;
  sign = byte & 0b00000011;
 
  char x;
  x = (byte>>5) & 0b00000111; 

  char y;
  y = (byte>>2) & 0b00000111;
 
  if(sign ==0){
    return x+y;
  }
  if(sign ==1){
    return x-y;
  }
  if(sign ==2){
    return x*y;
  }
  if(sign ==3){
    if(y==0 || x==0){
      return 0;
    }
    return x/y;
  }

}

int sum_3bit(void* d) {
  int sum = 0;
  int i=0;
  while(1){
   char byte = *((char*)d + i);

   if(byte==0){
     break;
   }
   
   sum+=each(d,i);

   i++;
  }
  return sum;
}