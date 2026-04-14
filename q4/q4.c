#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<dlfcn.h>

int main(){
    char op[10];
    int a,b;
    while(scanf("%s %d %d",op,&a,&b)!=EOF){
        char lib[20]="lib";
        strcat(lib,op);
        strcat(lib,".so");
        char path[30]="./";
        strcat(path,lib);
        void* head=dlopen(path,RTLD_LAZY);
        if(!head){
            printf("Error loading %s\n",lib);
            continue;
        }
        int(*func)(int,int);
        func=(int(*)(int,int))dlsym(head,op);
        if(!func){
            printf("Function %s not found\n",op);
            dlclose(head);
            continue;
        }
        int ans=func(a,b);
        printf("%d\n",ans);
        dlclose(head);
    }
}