#include "tree.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


#define ASSERT_INT_EQ(a, b) {						\
    int expected = (a);							\
    int actual = (b);							\
    if (expected != actual) {						\
      printf("%s:%d Assertion failed: expected %d got %d\n", __FILE__, __LINE__, expected, actual); \
      return false;							\
    }									\
  }

#define TEST(t) {				\
    printf("-- TESTING: %s\n", #t);		\
    if (t()) {					\
      printf("TEST %s: SUCCEEDED\n", #t);	\
    }						\
    else {					\
      printf("TEST %s: FAILED\n", #t);		\
    }						\
    printf("####\n\n");				\
  }

int findMax(int a, int b) {
    if(a > b) {
        return a;
    }
    return b;
}

int OneThreadGrow(int* original_heights, int n) {
    int numStages = 0;
    int new_heights[n];
    memcpy(new_heights, original_heights, sizeof(int) * n);
    int heights[n];
    memcpy(heights,original_heights,sizeof(int) * n);

    while (0xDEADBEEF) {
        for (int i = 0; i < n; i++) {
            if (i == 0) {
                new_heights[i] = findMax(heights[i], heights[i + 1]);
            } else if (i == n - 1) {
                new_heights[i] = findMax(heights[i], heights[i - 1]);
            } else {
                new_heights[i] = findMax(heights[i], findMax(heights[i - 1], heights[i + 1]));
            }
        }

        numStages++;

        // Check for convergence
        if (memcmp(heights, new_heights, n * sizeof(int)) == 0) {
            return numStages - 1;
        }

        // Update heights for the next stage
        memcpy(heights, new_heights, n * sizeof(int));
    }
}




bool SmallTree() {
    int n = 3;
    int heights[3] = {1,2,3};
    int ans = OneThreadGrow(heights,n);
    int numStages = Grow(heights, n);
    ASSERT_INT_EQ(ans, numStages);
    return true;
}

bool SmallTree2() {
    int n = 4;
    int heights[4] = {3,4,2,5};
    int ans = OneThreadGrow(heights,n);
    int numStages = Grow(heights, n);
    ASSERT_INT_EQ(ans, numStages);
    return true;
}


bool BiggerTree() {
    int n = 10;
    int heights[10] = {1, 2, 3, 4, 5, 4, 3, 2, 1, 7};
    int ans = OneThreadGrow(heights,n);
    int numStages = Grow(heights, n);
    ASSERT_INT_EQ(ans,numStages);
    return true;
}



bool BiggestTree() {
    int n = 500;
    int heights[500];
    for(int i = 0; i < 500; i++) {
        heights[i] = - (i * i) + n * i;
    }
    int ans = OneThreadGrow(heights,n);
    int numStages = Grow(heights, n);
    ASSERT_INT_EQ(ans,numStages);
    return true;
}


bool RandomBigTree() {
    int n = 100;
    int heights[100];
    for(int i = 0; i < 100; i++) {
        heights[i] = rand() % 2000;
    }
    int ans = OneThreadGrow(heights,n);    
    int numStages = Grow(heights, n);
    ASSERT_INT_EQ(ans,numStages);
    return true;
}

bool EvenBiggerRandomTree() {
    int n = 400;
    int heights[400];
    for(int i = 0; i < 400; i++) {
        heights[i] = rand() % 10000;
    }
    int ans = OneThreadGrow(heights,n);
    int numStages = Grow(heights, n);
    ASSERT_INT_EQ(ans,numStages);
    return true;
}





int main() {
    srand(time(NULL));
    TEST(SmallTree);
    TEST(SmallTree2);
    TEST(BiggerTree);
    TEST(BiggestTree);
    TEST(RandomBigTree);
    TEST(EvenBiggerRandomTree);
    return 0;
}