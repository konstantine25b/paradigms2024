#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

typedef struct {
    int* heights;
    int* newHeights;
    pthread_mutex_t lock;
    bool allDone;
    sem_t* done;
    sem_t* requested;
    int n;
} CommonArgs;


typedef struct {
    CommonArgs* c;
    int id;
} TreeArgs;

int findMaximum(int a, int b) {
    if(a > b) {
        return a;
    }
    return b;
}


void* Tree(void* args) {
    TreeArgs * a = args;

    while(0xDEADBEEF) {
        sem_wait(&a->c->requested[a->id]);
        if(a->c->allDone) {
            return NULL;
        }

        if(a->id > 0 && a->id < (a->c->n - 1)) {
            if(a->c->heights[a->id] < a->c->heights[a->id - 1] || a->c->heights[a->id] < a->c->heights[a->id + 1]) {
                pthread_mutex_lock(&a->c->lock);
                a->c->newHeights[a->id] = findMaximum(a->c->heights[a->id - 1], a->c->heights[a->id + 1]);
                pthread_mutex_unlock(&a->c->lock);
            }
        } else if (a->id == 0) {
            if(a->c->heights[a->id] < a->c->heights[a->id + 1]) {
                pthread_mutex_lock(&a->c->lock);
                a->c->newHeights[a->id] = a->c->heights[a->id + 1];
                pthread_mutex_unlock(&a->c->lock);
            }
        } else if (a->id == (a->c->n - 1)) {
            if(a->c->heights[a->id] < a->c->heights[a->id - 1]) {
                pthread_mutex_lock(&a->c->lock);
                a->c->newHeights[a->id] = a->c->heights[a->id - 1];
                pthread_mutex_unlock(&a->c->lock);
            }
        }

        sem_post(&a->c->done[a->id]);
    }
}





int Grow(int * heights, int n) {
    int numStages = 0;
    
    int currentHeights[n];
    int newHeights[n];
    memcpy(currentHeights,heights,n * sizeof(int));
    memcpy(newHeights,heights,n * sizeof(int));

    sem_t done[n];
    sem_t requested[n];

    for(int i = 0; i < n; i++) {
        sem_init(&done[i],0,0);
        sem_init(&requested[i],0,0);
    }

    pthread_mutex_t lock;
    pthread_mutex_init(&lock,NULL);

    pthread_t th[n];

    TreeArgs args[n];

    CommonArgs c_args = {
        .allDone = 0,
        .done = done,
        .heights = currentHeights,
        .lock = lock,
        .n = n,
        .newHeights = newHeights,
        .requested = requested
    };

    for(int i = 0; i < n; i++) {
        args[i].c = &c_args;
        args[i].id = i;
        pthread_create(&th[i],NULL,Tree,&args[i]);
    }

    while(0xDEADBEEF) {
        for(int i = 0; i < n; i++) {
            sem_post(&requested[i]);
        }

        for(int i = 0 ; i < n; i++) {
            sem_wait(&done[i]);
        }

        numStages++;

        int size = newHeights[0];
        int i;
        for(i = 1; i < n; i++) {
            if(size != newHeights[i]) {
                break;
            }
        }

        if(i >= n) {
            break;
        }

        memcpy(currentHeights,newHeights,sizeof(int) * n);
    }
    
    c_args.allDone = 1;

    for(int i = 0; i < n; i++) {
        sem_post(&requested[i]);
    }

    for(int i = 0; i < n; i++) {
        pthread_join(th[i],NULL);
    }

    pthread_mutex_destroy(&lock);

    for(int i = 0; i < n; i++) {
        sem_destroy(&requested[i]);
        sem_destroy(&done[i]);
    }

    return numStages;
}
