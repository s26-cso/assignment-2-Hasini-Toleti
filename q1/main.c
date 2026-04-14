#include<stdio.h>
#include<stdlib.h>

typedef struct Node {
    int val;
    struct Node* left;
    struct Node* right;
}Node;

Node* make_node(int val);
Node* insert(Node* root,int val);
Node* get(Node* root,int val);
int getAtMost(int val,Node* root);

int main(){
    Node* root=NULL;
    root=insert(root,10);
    root=insert(root,5);
    root=insert(root,15);

    Node* ans=get(root,12);
    if(ans!=NULL){
        printf("%d\n",ans->val);
    }
    else{
        printf("Not found\n");
    }
    printf("%d\n",getAtMost(12,root));
}