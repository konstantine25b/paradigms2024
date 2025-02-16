#ifndef TREE_GROWTH_H
#define TREE_GROWTH_H


#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

// Function declarations

/**
 * Finds the maximum of two integers.
 *
 * @param a First integer
 * @param b Second integer
 * @return Maximum of a and b
 */
int findMax(int a, int b);

/**
 * The thread function for each tree, responsible for growing the tree to the correct height.
 *
 * @param args Pointer to TreeArgs structure
 * @return NULL
 */
void* Tree(void* args);

/**
 * Simulates the growth of trees over several stages until equilibrium is reached.
 *
 * @param heights Initial heights of the trees
 * @param n Number of trees
 * @return Number of stages taken for all trees to reach equilibrium
 */
int Grow(int* heights, int n);

#endif // TREE_GROWTH_H
