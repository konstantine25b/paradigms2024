#define ELEM(src) (*((Score **)((char *)src.scores + 3)))

typedef struct {
    char offset; //1 0
    short scores[3]; //6 1
    char lateHours; // 1 7
    char otherActivities[12]; //12 8 
} Score; // 20

typedef short (*ScoreFn)(short[3]);

char score(Score *data, int numScores, ScoreFn fn) {
    short total = 0;

    for (int i = 0; i < numScores; i++) {
        total += fn(ELEM(data[i])->scores);
    }

    return total;
}

