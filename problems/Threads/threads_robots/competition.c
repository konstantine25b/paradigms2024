#include "competition.h"

#include <stdlib.h>

#include "robot.h"

void CompetitionInit(Competition* comp) {
  // IMPLEMENT
  comp->availableRobotsCount = 0;
  comp->canAccept = true;
  comp->newSpaceIdx = 0;
  comp->currentlyAvailable = 0;
  for(int i=0;i<1000;i++){
    (comp->robotArr)[i].isAvailable = false;
  }
  pthread_mutex_init(&(comp->lock),NULL);
  pthread_cond_init(&(comp->cond),NULL);
}

void CompetitionStart(Competition* comp) {
  // // IMPLEMENT
  pthread_t manageTh;
  pthread_create(&manageTh,NULL,startFn,comp);
  pthread_detach(manageTh);
}

const Robot* CompetitionStop(Competition* comp) {
  // IMPLEMENT

  pthread_mutex_lock(&(comp->lock));
  comp->canAccept = false;
  while(comp->availableRobotsCount>1){
    pthread_cond_wait(&(comp->cond),&(comp->lock));
  }
  // signal start
  pthread_cond_broadcast(&(comp->cond));
  
  if(comp->availableRobotsCount==0){
    pthread_mutex_unlock(&(comp->lock));
    return NULL;
  }

  for(int i=0;i<1000;i++){
    if((comp->robotArr)[i].isAvailable==true){
      pthread_mutex_unlock(&(comp->lock));
      return (comp->robotArr)[i].robot;
    }
  }
}

bool CompetitionAddParticipant(Competition* comp, const Robot* robot) {
  // IMPLEMENT
  pthread_mutex_lock(&(comp->lock));
  if(comp->canAccept==false){
    pthread_mutex_unlock(&(comp->lock));
    return false;
  } 

  (comp->robotArr)[comp->newSpaceIdx].robot = robot;
  (comp->robotArr)[comp->newSpaceIdx].isAvailable = true;
  comp->newSpaceIdx++;
  comp->currentlyAvailable++;
  // printf("added\n");
  comp->availableRobotsCount++;
  // signal start
  pthread_cond_broadcast(&(comp->cond));
  pthread_mutex_unlock(&(comp->lock));
  return true;
}


void* startFn(void* args){
  Competition* comp = (Competition*)args;

  while (true)
  {
    pthread_mutex_lock(&(comp->lock));
    if(comp->availableRobotsCount<=1 && comp->canAccept==false){
      // signal stop
      pthread_cond_broadcast(&(comp->cond));
      pthread_mutex_unlock(&(comp->lock));
      break;
    }

    while(comp->currentlyAvailable<2){
      if(comp->availableRobotsCount<=1) {
        pthread_mutex_unlock(&(comp->lock));
        break;
      }
      // sleep
      pthread_cond_wait(&(comp->cond),&(comp->lock));
    }

    RoboWraper* X = NULL;
    RoboWraper* Y = NULL;

    // choose two robots;

    for(int i=0;i<1000;i++){
      if((comp->robotArr)[i].isAvailable==true){

        if(X==NULL){
          X = &(comp->robotArr)[i];
        }else{
          Y = &(comp->robotArr)[i];
          break;
        }
      }
    }

    // create fight thread
    if(X!=NULL && Y!=NULL){
      X->isAvailable = false;
      Y->isAvailable = false;
      comp->currentlyAvailable-=2;
      fightArgs* fArgs = malloc(sizeof(fightArgs));
      fArgs->x = X;
      fArgs->y = Y;
      fArgs->comp = comp;
      pthread_t th;
      pthread_create(&th,NULL,fightFn,fArgs);
      pthread_detach(th);
    }
    pthread_mutex_unlock(&(comp->lock));
  }
}

void* fightFn(void* args){
  fightArgs* fighters = (fightArgs*)args;
  bool value = RobotFightWith(fighters->x->robot,fighters->y->robot);
  pthread_mutex_lock(&(fighters->comp->lock));
  if(value==true){
    fighters->x->isAvailable = true;
  }else{
    fighters->y->isAvailable = true;
  }
  fighters->comp->currentlyAvailable++;
  fighters->comp->availableRobotsCount--;
  //signal start
  //signal stop
  pthread_cond_broadcast(&(fighters->comp->cond));

  pthread_mutex_unlock(&(fighters->comp->lock));
  free(args);
}