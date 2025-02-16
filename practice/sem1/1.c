#include <stdio.h>

void change(char **s){
    *s = "world";
}

int main(int args, char **argv){
    char *s = "hello";
    printf(s);
    change(&s);
    printf(s);
    return 0;
}


