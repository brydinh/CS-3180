
// A C program to demonstrate linked list based implementation of queue
#include <stdio.h>
#include <stdlib.h>

// A linked list (LL) node to store a queue entry
struct QNode {
    int key;
    struct QNode* next;
};

// The queue, front stores the front node of LL and end stores the
// last node of LL
struct Queue {
    int numNodes;
    struct QNode *front, *end;
};

// Helper function to create a new linked list node.
struct QNode* newNode(int k)
{
    struct QNode* temp = (struct QNode*)malloc(sizeof(struct QNode));
    temp->key = k;
    temp->next = NULL;
    return temp;
}

// Helper function to create an empty queue
struct Queue* createQueue()
{
    struct Queue* q = (struct Queue*)malloc(sizeof(struct Queue));
    q->front = q->end = NULL;
    q->numNodes = 0;
    return q;
}

// The function to add a key k to q
void enqueue(struct Queue* q, int k)
{
    // Create a new LL node
    struct QNode* temp = newNode(k);
    
    // If queue is empty, then new node is front and end both
    if (q->end == NULL)
    {
        q->front = q->end = temp;
    }
    else
    {
        // Add the new node at the end of queue and change end
        q->end->next = temp;
        q->end = temp;
    }
    q->numNodes++;
}

// Function to remove a key from given queue q
struct QNode* dequeue(struct Queue* q)
{
    // If queue is empty, return NULL.
    if (q->front == NULL)
    {
        q->numNodes = 0;
        return NULL;
    }
    else
    {
        // Store previous front and move front one node ahead
        struct QNode* temp = q->front;
        free(temp);
        
        q->front = q->front->next;
        
        // If front becomes NULL, then change end also as NULL
        if (q->front == NULL)
        q->end = NULL;
        q->numNodes--;
        return temp;
    }
}

void clear(struct Queue *q)
{
    while(q->front != NULL)
    {
        free(q->front);
        q->front = q->front->next;
    }
    
    q->numNodes = 0;
}

void equals(struct Queue *a, struct Queue *b)
{
}

int size(struct Queue *q)
{
    return q->numNodes;
}

// Driver Program to test anove functions
int main()
{
    struct Queue* a = createQueue();
    printf("%d\n", size(a)); // 0
    enqueue(a, 10);
    printf("%d\n", size(a)); // 1
    enqueue(a, 20);
    printf("%d\n", size(a)); // 2
    dequeue(a);
    dequeue(a);
    printf("%d\n", size(a)); // 0
    enqueue(a, 30);
    enqueue(a, 40);
    enqueue(a, 50);
    printf("%d\n", size(a)); // 3
    
    struct QNode* n = dequeue(a);
    
    if (n != NULL)
    {
        printf("Dequeued item is %d\n", n->key);
    }
    
    printf("%d\n", size(a)); // 2

    
    
    return 0;
}
