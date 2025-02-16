#include "packed_vector.h"

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define ELEMSIZE(elem_size) (elem_size + (2*sizeof(int)))



void VectorInit(Vector* v) {
  v->logLen =0;
  v->size=0;
  // IMPLEMENT
}



static char* getSizeP(Vector* v, int offset){
  return (char*)(v)->base + offset;
}
static char* getFreeP(Vector* v, int offset){
  return (char*)(v)->base + offset + sizeof(int);
}
static char* getElemP(Vector* v, int offset){
  return (char*)(v)->base + offset + 2*sizeof(int);
}

static int getOffset(Vector* v, int index){
  int cur =0;
  int curSize =0;
  for(int i =0 ; i<index ;i++){
    curSize = *(int*)getSizeP(v,cur);
    int size = 2*sizeof(int)* curSize;
    cur = cur+ size;
    
  }
  return cur;
}
static void* get(Vector* v, int index){
  return getSizeP( v,  getOffset(v, index)); 
}
static void* getElem(Vector* v, int index){
  return getElemP( v,  getOffset(v, index)); 
}

void VectorDestroy(Vector* v) {
  // IMPLEMENT

   for(int i = 0 ; i< v->logLen;i++){
     int offset= getOffset(v, i);
     FreeFn free = getFreeP( v, offset);
     void* elem = getElemP( v, offset);
     free(elem);
   }
  free(v->base);
  
}


void VectorInsert(Vector* v, int index, int elem_size, void* elem, FreeFn free_fn) {

  if(v->logLen==0){
    int curSize = ELEMSIZE(elem_size);
    v->base =malloc(curSize);
    int* sizeP =(int*)getSizeP(v,0);
    *sizeP = curSize;
    void* freeP = getFreeP(v,0);
    memcpy(freeP,free_fn,sizeof(void*));
    void* elemP = getElemP(v,0);
    memcpy(elemP,elem,elem_size);
    v->size+=curSize;
  }
  else{
    int curSize = ELEMSIZE(elem_size);
    v->base =realloc(v->base,curSize+v->size);
    memmove((char*)get(v,index)+curSize,(char*)get(v,index), v->size-getOffset(v,index));
    int* sizeP =(int*)getSizeP(v,index);
    *sizeP = curSize;
    void* freeP = getFreeP(v,index);
    memcpy(freeP,free_fn,sizeof(void*));
    void* elemP = getElemP(v,0);
    memcpy(elemP,elem,elem_size);
    
    v->size+=curSize;
  }
  v->logLen++;
  // IMPLEMENT
}

void VectorRemove(Vector* v, int index) {
  // IMPLEMENT
  int offset= getOffset(v, index);
  int size = getSizeP( v, offset);
  FreeFn free = getFreeP( v, offset);
  void* elem = getElemP( v, offset);
  free(elem);
  memmove((char*)get(v,index),(char*)get(v,index)+size, size);
  v->logLen++;
}

void* VectorGet(Vector* v, int index, int* elem_size) {
  int size = *(int*)get(v,index);
  memcpy(elem_size,get(v,index), size);
  // IMPLEMENT
  return getElem(v,index);
}

void VectorRotate(Vector* v, int index) {
  // IMPLEMENT
}

void VectorMap(Vector* v, MapFn map_fn, void* aux) {
  // IMPLEMENT
}
