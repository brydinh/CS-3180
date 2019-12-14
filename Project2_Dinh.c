///////////////////////////////////////////////////////////////////////////////////////
// CS 3180 Fall '19
// Project 02
// Brian Dinh
///////////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

///////////////////////////////////////////////////////////////////////////////////////
// ADT Queue Algebraic Specs
///////////////////////////////////////////////////////////////////////////////////////
//
// CANONICAL CONSTRUCTORS
// makeQueue() : -> Queue
// enqueue() : Queue, X -> Queue
// clear() : -> Queue
//
// OBSERVERS
// dequeue() : Queue -> Queue
// size() : Queue -> Natural
// equals() : Queue, Queue -> Int (Boolean)
//
// CONSTRUCTOR AXIOMS
//
// ///// The following Axiom specifies "makeQueue" constructor semantics //////
// makeQueue() -> Queue
// AXIOM: size(makeQueue()) = 0
//
// ///// The following Axiom specifies "enqueue" constructor semantics //////
// enqueue() : Queue, X -> Queue
//
// AXIOM: For all Q in Queue and X
// size(enqueue(Q, X)) > 0
//
// AXIOM: For all Q in Queue
// dequeue(enqueue(Q, X)) -> Q          // enqueue() can be undone via dequeue()
//
// AXIOM: For all Q in Queue
// equals(enqueue(S, X), S) -> False    // enqueue() returns a different/modified Queue
//
// OBSERVER AXIOMS
//
// dequeue:
// AXIOM: dequeue(queue()) -> queue()
//    - also -
// AXIOM: For all Q in Queuem
// dequeue(enqueue(Q, X)) -> Q
//
// size:
// AXIOM: size(queue()) -> 0
//    - also -
// AXIOM: For all Q in Queue
// size(enqueue(Q, X)) -> 1 + size(Q)
//
// equals:
// AXIOM: For all Q in Queue
// equal(enqueue(Q, X), Q) -> False     ;; enqueue() produces a different queue
//    - also -
// AXIOM: For all Q, Q1 in Queue and X, X1  ;; Specifies criteria for equality
// equal(enqueue(S, X), enqueue(S1, X1)) ->
//     True if equal(S, S1) and X is equal X1
//     else False
//    - also -
// AXIOM: For all Q, Q1 in Queue
// equal(Q, Q1) -> equal(Q1, Q)       ;; Order of comparison doesn't matter
//    - also -
// AXIOM: For all Q in Queue          ;; Identity property of equal()
// equal(Q, Q) -> True

/////////////////////////////////////////////////////////////////////////////////////
// Queue Function Prototypes
/////////////////////////////////////////////////////////////////////////////////////
struct Queue* makeQueue();
void enqueue(struct Queue*, int);
void clear(struct Queue*);

void dequeue(struct Queue*);
int equals(struct Queue*, struct Queue*);
int size(struct Queue*);

struct QueueNode
{
    int data;
    struct QueueNode* next;
};

struct Queue
{
    struct QueueNode *head, *tail;
};

/////////////////////////////////////////////////////////////////////////////////////
// Queue Driver Program
// Used to test functions
/////////////////////////////////////////////////////////////////////////////////////

int main()
{
    struct Queue* a = makeQueue();
    printf("A Size: %d\n", size(a));
    struct Queue* b = makeQueue();
    
    for(int x=1; x<=1000000; x++)
    {
        enqueue(a, x);
    }
    
    for(int x=1; x<=1000000; x++)
    {
        enqueue(b, x);
    }
    printf("A Size: %d\n", size(a));
    printf("B Size: %d\n", size(b));
    
    if(equals(a, b) == 1)
    {
        printf("A and B are equal\n");
    }
    else
    {
        printf("A and B are not equal\n");
    }
    
    printf("Dequeue A once\n");
    dequeue(a);
    
    if(equals(a, b) == 1)
    {
        printf("A and B are equal\n");
    }
    else
    {
        printf("A and B are not equal\n");
    }
    
    clear(a);
    clear(b);
    
    printf("A Size: %d\n", size(a));
    printf("B Size: %d\n", size(b));

    enqueue(a, 1);
    enqueue(a, 2);

    enqueue(b, 1);
    enqueue(b, 3);
    
    printf("A Size: %d\n", size(a));
    printf("B Size: %d\n", size(b));

    if(equals(a, b) == 1)
    {
        printf("A and B are equal\n");
    }
    else
    {
        printf("A and B are not equal\n");
    }
    
    return 0;
}

/////////////////////////////////////////////////////////////////////////////////////
// ADT Queue Constructors
/////////////////////////////////////////////////////////////////////////////////////

// CONTRACT: makeQueue() : -> Queue
struct Queue* makeQueue()
{
    struct Queue* q = (struct Queue*)malloc(sizeof(struct Queue));
    q->head = q->tail = NULL;
    return q;
}

// CONTRACT: enqueue(Q, X) -> Queue
// For all Q in Queue
// push(Q, X) -> Queue
// PURPOSE:  Adds new Queue node to the end of the the queue
// CODE:
void enqueue(struct Queue *q, int num)
{
    // Create new Queue Node
    struct QueueNode* temp = (struct QueueNode*)malloc(sizeof(struct QueueNode));
    temp->data = num;
    temp->next = NULL;
    
    // If queue is empty, point head and tail at the same node
    if (q->tail == NULL)
    {
        q->head = q->tail = temp;
    }
    else
    {
        // Add the new node at the tail of queue
        q->tail->next = temp;
        q->tail = temp;
    }
}

// CONTRACT: clear() : Queue -> Queue
// PURPOSE:  removes all items from Queue, or error
// CODE:
void clear(struct Queue *q)
{
    if (q->head == NULL)
    {
        printf("You are trying to clear an empty queue\n");
    }
    else
    {
        struct QueueNode *temp = q->head;
        while(q->head != NULL)
        {
            temp = q->head;
            q->head = q->head->next;
            free(temp);
        }
        q->tail = NULL;
    }
}

/////////////////////////////////////////////////////////////////////////////////////
// ADT Queue Observers
/////////////////////////////////////////////////////////////////////////////////////

// CONTRACT: dequeue() : Queue -> Queue
// PURPOSE:  removes first item (if any) from queue
// CODE:
void dequeue(struct Queue* q)
{
    if (q->head == NULL)
    {
        printf("You are trying to dequeue an empty queue\n");
    }
    else
    {
        struct QueueNode *temp = q->head;
        //printf("Removing node with data: %d\n", temp->data);
        q->head = q->head->next;
        free(temp);
        
        if (q->head == NULL)
        {
            q->tail = NULL;
        }
        
    }
}

// CONTRACT: equals() : Queue, Queue -> Int(Boolean)
// PURPOSE:  return True if and only if two Queues have the same content in the same order
// CODE:
int equals(struct Queue *a, struct Queue *b)
{
    if(a->head == NULL && b->head == NULL)
    {
        return 1;
    }
    if (size(a) != size(b))
    {
        return 0; // return false
    }
    
    struct QueueNode* tempA = a->head;
    struct QueueNode* tempB = b->head;
    
    while(tempA != NULL && tempB != NULL)
    {
        if(tempA->data == tempB->data)
        {
            tempA = tempA->next;
            tempB = tempB->next;
        }
        else
        {
            return 0; // return false
        }
    }
    
    return 1; // return true
}

// CONTRACT: size() : Queue -> Natural
// PURPOSE:  return the number of item in a Queue
// CODE:
int size(struct Queue *q)
{
    int count = 0;
    struct QueueNode* temp = q->head;
    
    while(temp != NULL)
    {
        count++;
        temp = temp->next;
    }
    
    return count;
}
