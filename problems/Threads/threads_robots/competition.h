#ifndef PARADIGMS_ROBOTS_COMPETITION_H_
#define PARADIGMS_ROBOTS_COMPETITION_H_

#include <stdbool.h>
#include <pthread.h>

#include "robot.h"

void* startFn(void* args);
void* fightFn(void* args);

typedef struct
{
  const Robot* robot;
  bool isAvailable;
} RoboWraper;

typedef struct {
  // აქ დაამატეთ ცვლადები
  RoboWraper robotArr[1000];
  bool canAccept;
  int availableRobotsCount;
  int currentlyAvailable;
  int newSpaceIdx;
  pthread_mutex_t lock;
  pthread_cond_t cond;
} Competition;

typedef struct{
  RoboWraper* x;
  RoboWraper* y;
  Competition* comp;
} fightArgs;

// უკეთებს შეჯიბრს ინიციალიზაციას.
void CompetitionInit(Competition* comp);
// უნდა გაუშვას შეჯიბრის მენეჯმენტისთვის მთავარი ნაკადი.
void CompetitionStart(Competition* comp);
// უნდა აკრძალოს შეჯიბრში ახალი მონაწილეების დამატება,
// დაელოდოს უკვე დამატებულ მონაწილეებს შორის გამარჯვებულს,
// და დააბრუნოს იგი.
const Robot* CompetitionStop(Competition* comp);
// აბრუნებს true თუ რობოტი წარმატებით დაემატა შეჯიბრში,
// და false წინააღმდეგ შემთხვევაში.
bool CompetitionAddParticipant(Competition* comp, const Robot* robot);

#endif // PARADIGMS_ROBOTS_COMPETITION_H_
