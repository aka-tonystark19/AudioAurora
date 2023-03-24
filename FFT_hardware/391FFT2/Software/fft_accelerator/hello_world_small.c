#include "sys/alt_stdio.h"
#include "stdio.h"
#include "system.h"
#include "stdlib.h"

//volatile unsigned *curr_base = (volatile unsigned *) RAM_BASE;

int main()
{ 
  alt_putstr("Hello from Nios III!\n");
  volatile unsigned *curr_base = RAM_INSTR_BASE;
  //why do u die after 33
  for(int i = 0; i< 1024; i++){
  		*curr_base = i;		//save to memory
  		printf("i = %d ", i);
  		printf("curr_base = %x", (int)curr_base);
  		curr_base = (int*)curr_base +1 ;	//increment
  		printf("i = %d\n", i);
  	}
  alt_putstr("Successfully saved to RAM!\n");
  curr_base = RAM_INSTR_BASE;
  for(int i = 0; i < 512; i++){
    	printf("%d ", (int)*curr_base);
    	printf("%d \n", (int)(*(curr_base + 0x20000)));
    	curr_base = (int*)curr_base + 1;	//increment

  }
/*
  volatile unsigned *curr_base = (volatile unsigned *) RAM_BASE;
  for(int i = 0; i < 512; i++){
//	  *curr_base = i;
	  volatile unsigned *new = curr_base + i;
	  *new = i;
//	  curr_base++;
  }
  curr_base = (volatile unsigned *) RAM_BASE;
  printf("Wrote to memory \n");
  alt_putstr("Wrote to memory \n");
  for(int i = 0; i < 512; i++){
	  printf("%d ", (int)*curr_base);
	  printf("%d \n", (int)(*(curr_base + 0x10000)));
	  curr_base = (int*)curr_base + 1;	//increment

    }
*/
  /* Event loop never exits. */
  while (1);

  return 0;
}
