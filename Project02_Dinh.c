#include <stdio.h>
#include <stdlib.h>

struct node
{
    int data;
    struct node *next;
};

// Queue data types
struct node *front = NULL;
struct node *end = NULL;
int num = 0;

void display();
void enqueue(int);
void dequeue();
void clear();

int size();

int main()
{
    enqueue(1);
    enqueue(2);
    enqueue(3);
    printf("%d\n", size());
    dequeue();
    printf("%d\n", size());
    printf("Before clear\n");
    clear();
    printf("After clear\n");
    printf("%d\n", size());
    display();
    
    enqueue(1);
    printf("%d\n", size());
    
    
}

void enqueue(int item)
{
    struct node *nptr = malloc(sizeof(struct node));
    nptr->data = item;
    nptr->next = NULL;
    if (end == NULL)
    {
        front = nptr;
        end = nptr;
    }
    else
    {
        end->next = nptr;
        end = end->next;
    }
    num++;
}

void display()
{
    struct node *temp;
    temp = front;
    printf("\n");
    while (temp != NULL)
    {
        printf("%d\t", temp->data);
        temp = temp->next;
    }
}

void dequeue()
{
    if (front == NULL)
    {
        printf("\n\nQueue is empty \n");
    }
    else
    {
        struct node *temp;
        temp = front;
        front = front->next;
        free(temp);
        num--;
    }
}

int size()
{
    return num;
}

void clear()
{
    while(front != NULL)
    {
        free(front);
        front = front->next;
    }
    num = 0;
}
