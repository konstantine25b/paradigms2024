#include "counting_array.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define getItem(a,i)  ((char*)(a)->base + (i) *(a)->elemSize)
#define get(a,i)  ((char*)(a)->count + (i) *sizeof(int) )

void CountingArrayInit(CountingArray* a, int elem_size, CmpFn cmp_fn, FreeFn free_fn) {
  a->alocLen =8;
  a->logLen = 0;
  a->cmpFn = cmp_fn;
  a->freeFn = free_fn;
  a->elemSize = elem_size;
  a->base = malloc(a->elemSize*a->alocLen);
  a->count = malloc(sizeof(int) * a->alocLen);
  for(int i = 0 ; i< a->alocLen;i++){
    *(int*)get(a,i)=0;
  }
}

void CountingArrayDestroy(CountingArray* a) {
  if(a->freeFn!=NULL){
   for(int i = 0 ; i< a->logLen;i++){
     void* elem = getItem(a,i);
     a->freeFn(elem);
   }
  }
  free(a->base);
  free(a->count);
}

int CountingArraySize(CountingArray* a) {
  // IMPLEMENT
  return a->logLen;
}

void* CountingArrayGet(CountingArray* a, int index) {
  // IMPLEMENT
  return  getItem(a,index);
}

bool CountingArrayInsert(CountingArray* a, void* elem) {
  // IMPLEMENT
  if(a->logLen == a->alocLen){
    a->alocLen*=2;
    a->base = realloc(a->base ,a->elemSize * a->alocLen);
    a->count = realloc(a->count , sizeof(int) * a->alocLen);
  }
  int i=0;
  for( i = 0 ; i< a->logLen;i++){
    if(a->cmpFn(getItem(a,i), elem)>=0){
      break;
    } 
  }

  if( i < a->logLen && a->cmpFn(getItem(a,i), elem)==0){

    int cur =  *(int*)get(a,i);
    cur+=1;
    *(int*)get(a,i)=cur;
    return false;

  }else{

    void* elemPlace= getItem(a,i);
    void* countPlace = get(a,i);
    memmove(((char*)elemPlace + a->elemSize),(char*) elemPlace, a->elemSize *(a->logLen -i ));
    memmove((char*)countPlace +sizeof(int),(char*) countPlace, sizeof(int) *(a->logLen -i ));
    *(int*)countPlace =1;
    printf("%d", 23);
    memcpy( elemPlace, elem, a->elemSize);
     printf("%d", 343);
    a->logLen +=1;
    return true;
  }
  

}

void CountingArrayRemove(CountingArray* a, void* elem) {
  // IMPLEMENT
}

void CountingArrayMerge(CountingArray* a, CountingArray* o) {
  // IMPLEMENT
}