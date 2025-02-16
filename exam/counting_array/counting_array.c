#include "counting_array.h"
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define NBASE(a,index) ((char*)(a)->base + (index)*(a)->elemSize)
#define NCOUNT(a,index) ((int*)(a)->count + (index))

void CountingArrayInit(CountingArray* a, int elem_size, CmpFn cmp_fn, FreeFn free_fn) {
  a->alocLen =8;
  a->logLen = 0;
  a->cmpFn = cmp_fn;
  a->freeFn = free_fn;
  a->elemSize = elem_size;
  a->base = malloc(a->elemSize * a->alocLen);
  a->count =malloc(a->alocLen* sizeof(int));
  assert(a->base);
  assert(a->count);
  
}

void CountingArrayDestroy(CountingArray* a) {

  if(a->freeFn){
    for(int i = 0 ;i< a->logLen;i++){
     void* elem=NBASE(a,i);
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
  return NBASE(a,index);
}

static void grow(CountingArray* a){
  if(a->alocLen==a->logLen){
    a->alocLen=a->alocLen*2;
    a->base = realloc(a->base,a->elemSize * a->alocLen);
    a->count = realloc(a->count,a->alocLen* sizeof(int));
    assert(a->base);
    assert(a->count);
  }

}

int isIn(CountingArray* a, void* elem){
  for(int i =0 ; i< a->logLen;i++){
   if(a->cmpFn(NBASE(a,i), elem)==0){
    return i;
   }
  }
  return -1;
}

int findPlace(CountingArray* a, void* elem){
  for(int i =0 ; i< a->logLen;i++){
   if(a->cmpFn( elem,NBASE(a,i))<0){
    return i;
   }
  }
  return a->logLen;
}

bool CountingArrayInsert(CountingArray* a, void* elem) {
  // IMPLEMENT
  grow(a);

  int isin = isIn(a,elem);

  if(isin==-1){
     int index = findPlace(a, elem);
        char* currBase = NBASE(a, index);
        int* currCount = NCOUNT(a, index);
        int size = a->elemSize * (a->logLen - index);
        int size1 = sizeof(int) * (a->logLen - index);

        // Only shift elements if necessary
        if (index < a->logLen) {  
            memmove(currBase + a->elemSize, currBase, size);
            memmove(currCount + 1, currCount, size1);
        }

        // Copy new element and initialize count
        memcpy(currBase, elem, a->elemSize);
        *currCount = 1;
        a->logLen++;
        return true;
  }else{
    int cur = *NCOUNT(a,isin);
    cur =cur+1;
    *NCOUNT(a,isin) =cur;
    return false;
  }

}

void CountingArrayRemove(CountingArray* a, void* elem) {
    int index = isIn(a, elem);
    if (index == -1) return; // Element not found, do nothing.

    int* count = NCOUNT(a, index);
    
    if (*count > 1) {
        (*count)--; // Decrease count
        return;
    }

    // If count == 1, remove the element entirely.
    char* currBase = NBASE(a, index);
    int* currCount = NCOUNT(a, index);
    
    int size = a->elemSize * (a->logLen - index - 1);
    int size1 = sizeof(int) * (a->logLen - index - 1);
    
    // Shift elements to the left to remove the element.
    if (index < a->logLen - 1) {
        memmove(currBase, currBase + a->elemSize, size);
        memmove(currCount, currCount + 1, size1);
    }

    a->logLen--; // Reduce the size of the array.
}

void CountingArrayMerge(CountingArray* a, CountingArray* o) {
    for (int i = 0; i < o->logLen; i++) {
        void* elem = NBASE(o, i);
        int count = *NCOUNT(o, i);

        int isin = isIn(a, elem);

        if (isin == -1) {
            // Insert a new element with count
            CountingArrayInsert(a, elem);
            *NCOUNT(a, findPlace(a, elem)) = count; // Set the correct count
        } else {
            // Add counts if element exists
            *NCOUNT(a, isin) += count;
        }
    }
}