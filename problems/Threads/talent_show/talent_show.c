#include "talent_show.h"

#include <stdlib.h>
#include <stdio.h>

void* JurorStart(void* args) {
  JurorArgs* juror = args;
  Jury* jury = juror->jury;
  // Fill in.
#pragma region greeting
  // wait jury to greet
  sem_wait(&jury->juror_wait_jury_greet);

  // greeting
  AudienceJurorGreet(jury->audience,juror->id);

  // awake jury
  sem_post(&juror->jury_wait_juror_to_greet);
#pragma endregion
  while(1){
    // if there is no participants and accepting is closed => break
    sem_wait(&jury->data_lock);
    if(jury->take_no_new_participants && jury->num_participants==0){
      sem_post(&jury->data_lock);
      break;
    }
    sem_post(&jury->data_lock);

    // wait jury to accept participant
    sem_wait(&juror->wait_for_part_estimate);
    if(jury->num_participants==0) break;

    // evaluate participant
    bool res = jury->evaluator(jury->cur_participant,juror->id);
    if(res){
      jury->num_yes++;
    }
    AudienceJurorEvaluatedParticipant(jury->audience,juror->id,jury->cur_participant,res);
    // awake jury
    sem_post(&juror->jury_wait_for_verdict);
  }

  AudienceJurorDone(jury->audience,juror->id);
  sem_post(&juror->jury_wait_to_finish);

  return NULL;
}

void* JuryStart(void* args) {
  Jury* jury = args;
  // Fill in.

#pragma region greeting 
  // greeting
  AudienceJuryGreet(jury->audience);

  // awake jurors
  for(int i=0;i<jury->num_jurors;i++){
    sem_post(&jury->juror_wait_jury_greet);
  }

  // wait for jurors to greet
  for(int i=0;i<jury->num_jurors;i++){
    sem_wait(&jury->jurors[i].jury_wait_juror_to_greet);
  }
#pragma endregion
  while(1){
    // if there is no participants and accepting is closed => break
    sem_wait(&jury->data_lock);
    if(jury->take_no_new_participants && jury->num_participants==0){
      sem_post(&jury->data_lock);
      break;
    }
    sem_post(&jury->data_lock);
    jury->num_yes = 0;
    sem_wait(&jury->available_participant);
    if(jury->num_participants==0) break;

    // awake jurors to estimate
    for(int i=0;i<jury->num_jurors;i++){
      sem_post(&jury->jurors[i].wait_for_part_estimate);
    }
    
    // wait for jurors' verdict
    for(int i=0;i<jury->num_jurors;i++){
      sem_wait(&jury->jurors[i].jury_wait_for_verdict);
    }

    // print verdict
    AudienceJuryAnnounceParticipantScore(jury->audience,jury->cur_participant,jury->num_yes);
    jury->cur_participant++;
    sem_wait(&jury->data_lock);
    jury->num_participants--;
    sem_post(&jury->data_lock);

  }
  // wait for jurors to finish
  for(int i=0;i<jury->num_jurors;i++){
    sem_post(&jury->jurors[i].wait_for_part_estimate);
  }

  // wait for jurors to finish
  for(int i=0;i<jury->num_jurors;i++){
    sem_wait(&jury->jurors[i].jury_wait_to_finish);
  }
  AudienceJuryDone(jury->audience);
  // jury done
  sem_post(&jury->jury_done);

  return NULL;
}

void JurorInit(JurorArgs* juror, int id, Jury* jury) {
  juror->id = id;
  juror->jury = jury;
  // Initialize mutexes and semaphores if needed.
  sem_init(&juror->jury_wait_juror_to_greet,0,0);
  sem_init(&juror->wait_for_part_estimate,0,0);
  sem_init(&juror->jury_wait_for_verdict,0,0);
  sem_init(&juror->jury_wait_to_finish,0,0);
}

void JurorDestroy(JurorArgs* juror) {
  // Destroy mutexes and semaphores if needed.
  sem_destroy(&juror->jury_wait_juror_to_greet);
  sem_destroy(&juror->wait_for_part_estimate);
  sem_destroy(&juror->jury_wait_for_verdict);
  sem_destroy(&juror->jury_wait_to_finish);
}

void JuryInit(Jury* jury, Audience* audience, Evaluator evaluator,
	      int num_jurors) {
  jury->audience = audience;
  jury->evaluator = evaluator;
  jury->num_jurors = num_jurors;
  jury->num_participants = 0;
  jury->take_no_new_participants = false;
  // Initialize mutexes and semaphores if needed.

  jury->cur_participant = 0;
  sem_init(&jury->juror_wait_jury_greet,0,0);
  sem_init(&jury->available_participant,0,0);
  sem_init(&jury->jury_done,0,0);
  sem_init(&jury->data_lock,0,1);

}

void JuryDestroy(Jury* jury) {
  for (int i = 0; i < jury->num_jurors; ++i) {
    JurorDestroy(&jury->jurors[i]);
  }
  // Destroy mutexes and semaphores if needed.
  sem_destroy(&jury->juror_wait_jury_greet);
  sem_destroy(&jury->available_participant);
  sem_destroy(&jury->jury_done);
  sem_destroy(&jury->data_lock);
}

void JuryStartAcceptingParticipants(Jury* jury) {
  pthread_t tid;
  for (int i = 0; i < jury->num_jurors; ++i) {
    JurorInit(&jury->jurors[i], i, jury);
    pthread_create(&tid, NULL, JurorStart, &jury->jurors[i]);
    pthread_detach(tid);
  }
  pthread_create(&tid, NULL, JuryStart, jury);
  pthread_detach(tid);
}

bool JuryTakeNewParticipant(Jury* jury) {
  // Fill in.

  sem_wait(&jury->data_lock);
  if(jury->take_no_new_participants){
    sem_post(&jury->data_lock);
    return false;
  }
  jury->num_participants++;
  sem_post(&jury->data_lock);
  // awake jury
  sem_post(&jury->available_participant);
  return true;
}

void JuryStopAcceptingParticipants(Jury* jury) {
  // Fill in.
  sem_wait(&jury->data_lock);
  jury->take_no_new_participants = true;
  sem_post(&jury->data_lock);
  // wait for jury to done
  sem_post(&jury->available_participant);
  sem_wait(&jury->jury_done);

}
