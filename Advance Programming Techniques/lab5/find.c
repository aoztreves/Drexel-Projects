/*
*
*Aslan Oztreves
*23/10/2016
*/
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int find ( char *key, int *p_ans ) {
		entry entry*;
		int i;
		i = hash(key);		
		
		for ( entry = table[i]; entry!=NULL; entry=entry->next)
			if( strcmp(key , entry->key) == 0) {
				
				return 1;
			}																							
return 0;
}
