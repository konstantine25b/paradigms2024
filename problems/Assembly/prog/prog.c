#include <stdio.h>

typedef struct{
    int cur;
    int res;
} Str;

void upgrade(Str* s,int j){
    s->cur+=j;
}

void iter(Str* s){
    for(int j=0;j<5;j++){
        upgrade(s,j);
    }
}

int main(){
    Str s;
    s.cur = 0;
    s.res = 0;
    for(int i=0;i<5;i++){
        iter(&s);
        s.res+=s.cur;
    }
    printf("%d\n",s.cur);
}