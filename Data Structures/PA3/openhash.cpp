
#include <stdio.h>
#include <iostream>
#include <string.h>

using namespace std;

const int SIZE = 10;

struct node {
    int value;
    node *next = NULL;
};
class HASH{
public:
    node* h [SIZE] ;
   

};
void MAKEFULL(HASH *hash);
int Function(int x);
void INSERT(int x, HASH *hash);
bool MEMBER(int x, HASH *hash);
void DELETE(int x, HASH *h);
void PRINT(HASH *h);
void MAKEFULL(HASH *hash)
{
    for (int i = 0; i < SIZE ; i++)
    {
        hash->h[i] = NULL;
    }
}
int Function(int x)
{
    return x%SIZE;
}

void INSERT(int x, HASH *hash)
{
    if(MEMBER(x, hash))
    {
        cout << "exists\n";
    }
    else
    {
        int bucket = Function(x);
        node *oldheader  = hash->h[bucket];
        hash->h[bucket] = new node;
        hash->h[bucket]->value = x;
        hash->h[bucket]->next = oldheader;
        
    }
}
bool MEMBER(int x, HASH *hash)
{
    node *current;
    int loca = Function(x);
    current = hash->h[loca];
    while(current!=NULL)
    {
        if(current->value == x)
        {
            return true;
        }
        current = current -> next;
    }
    return false;
}

void DELETE(int x, HASH *hash)
{
    if(MEMBER(x, hash))
    {
        int bucket = Function(x);
        node *current = hash->h[bucket];
        
        if (hash->h[bucket]->value==x) {
            hash->h[bucket] = hash->h[bucket]->next;
        }
        else {
        
            while(current->next!=NULL)
            {
                if(current->next->value == x)
                {
                    current->next = current->next->next;
                }
            }
        }
    }
    else
    {
        cout << "doesn't exist\n";
    }
    
}
void PRINT(HASH *hash)
{
    cout << "HASH Table:\n";
    node *current;
    for (int i = 0; i<SIZE; i++)
    {
        current = hash->h[i];
        cout << i << ": ";
        while (current!=NULL)
        {
            cout << current->value<< " ->";
            current=current->next;
        }
        cout << "null\n";
    }
    
}

int main(){
    HASH *hash = new HASH();
    PRINT(hash);
    cout<< "INSERT 3, 4, 7, 14, 20, 21, 26, 27, 32 into the table:\n";
    INSERT(3, hash);
    INSERT(4, hash);
    INSERT(7, hash);
    INSERT(14, hash);
    INSERT(20, hash);
    INSERT(21, hash);
    INSERT(26, hash);
    INSERT(27, hash);
    INSERT(32, hash);
    PRINT(hash);
    cout << "delete 4, 32 from the table\n";
    DELETE(4, hash);
    DELETE(32, hash);
    PRINT(hash);
    
    
    
    return 0;
}