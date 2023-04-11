#include "sys/alt_stdio.h"
#include "stdio.h"
#include "system.h"
#include "stdlib.h"

//volatile unsigned *curr_base = (volatile unsigned *) RAM_BASE;

int callfft(void) {
	volatile unsigned *fft_magic = FFT_ACCEL_0_BASE;
	*fft_magic = 0;
	alt_putstr("FFT started\n");
	//while(1); //testing something
	return *fft_magic;
}

int main()
{ 
  alt_putstr("Hello from Nios II!\n");
  volatile unsigned *curr_base_1 = RAM_1_BASE;
  volatile unsigned *curr_base_2 = RAM_2_BASE;



  alt_putstr("Saving to RAM!\n");
  
  for(int i = 0; i< 512; i++){
  		*curr_base_1 = i;		//save to memory
  		*curr_base_2 = i;
//  		printf("i = %d ", i);
//  		printf("curr_base = %x", (int)curr_base_1);
  		curr_base_1 = (int*)curr_base_1 +1 ;	//increment
  		curr_base_2 = (int*)curr_base_2 +1 ;
  }
  alt_putstr("Successfully saved to RAM!\nCALLING FFT! \n");
  

  int num = callfft();
  printf("FFT returned: %d\n", num);

  
  curr_base_1 = RAM_1_BASE;
  curr_base_2 = RAM_2_BASE;
  for(int i = 0; i < 512; i++){
    	printf("%u ", (unsigned int)*curr_base_1);
    	printf("%u ", (unsigned int)*curr_base_2);
    	curr_base_1 = (int*)curr_base_1 + 1;	//increment
    	curr_base_2 = (int*)curr_base_2 + 1;

  }


  for(int i = 0; i< 512; i++){
  		*curr_base_1 = i;		//save to memory
  		*curr_base_2 = i;
//  		printf("i = %d ", i);
//  		printf("curr_base = %x", (int)curr_base_1);
  		curr_base_1 = (int*)curr_base_1 +1 ;	//increment
  		curr_base_2 = (int*)curr_base_2 +1 ;
  }
  alt_putstr("Successfully saved to RAM!\nCALLING FFT! \n");
  /* Event loop never exits. */


  while (1);

  return 0;
}
