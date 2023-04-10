//#include <stdio.h>
//#include "system.h"
//#include "sys/alt_stdio.h"
//#include "altera_avalon_pio_regs.h"
//#include "altera_avalon_uart_regs.h"
//#include <stdint.h>
//
//enum State {WAIT, FIRST, SECOND, END};
//
//int main(void) {
//    alt_putstr("Hello from Nios II!\n");
//	char input;
//
//    char *ptr = ONCHIP_MEMORY2_0_BASE;
//
//    // create a state variable
//    int i = 0;
//    uint8_t curr = 0;
//    uint8_t temp = 0;
//    enum State state = WAIT;
//
//    while (state != END) {
//		input = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//        switch (state) {
//            case WAIT:
//                if (input == '!') {
//                	printf("Chunk Start\n");
//                    state = FIRST;
//                }
//                break;
//            case FIRST:
//                if (input == '?') {
//                	printf("WAIT %d\n", i++);
//                    state = WAIT;
//                } else if (input == '~') {
//                    state = END;
//                } else {
//                    curr = 0;
//                    switch(input) {
//                        case '0':   temp = 0;   break;
//                        case '1':   temp = 1;   break;
//                        case '2':   temp = 2;   break;
//                        case '3':   temp = 3;   break;
//                        case '4':   temp = 4;   break;
//                        case '5':   temp = 5;   break;
//                        case '6':   temp = 6;   break;
//                        case '7':   temp = 7;   break;
//                        case '8':   temp = 8;   break;
//                        case '9':   temp = 9;   break;
//                        case 'A':   temp = 10;  break;
//                        case 'B':   temp = 11;  break;
//                        case 'C':   temp = 12;  break;
//                        case 'D':   temp = 13;  break;
//                        case 'E':   temp = 14;  break;
//                        case 'F':   temp = 15;  break;
//                        default: printf("1 BRUH %d\n", input);
//                    }
//
//                    curr = temp * 16;
//                    state = SECOND;
//                }
//                break;
//            case SECOND:
//            	if (input == '?') {
//            		printf("WAIT %d\n", i++);
//            		state = WAIT;
//            	} else if (input == '~') {
//            		state = END;
//            	} else {
//            		switch(input) {
//            			case '0':   temp = 0;   break;
//            			case '1':   temp = 1;   break;
//            			case '2':   temp = 2;   break;
//            			case '3':   temp = 3;   break;
//            			case '4':   temp = 4;   break;
//            			case '5':   temp = 5;   break;
//            			case '6':   temp = 6;   break;
//            			case '7':   temp = 7;   break;
//            			case '8':   temp = 8;   break;
//            			case '9':   temp = 9;   break;
//            			case 'A':   temp = 10;  break;
//            			case 'B':   temp = 11;  break;
//            			case 'C':   temp = 12;  break;
//            			case 'D':   temp = 13;  break;
//            			case 'E':   temp = 14;  break;
//            			case 'F':   temp = 15;  break;
//            			default: printf("2 BRUH %d\n", input);
//            		}
//
//            		curr += temp;
//            		*ptr++ = curr;
//
//            		state = FIRST;
//            	}
//
//                break;
//            case END:
//                break;
//        }
//    }
//
//    printf("done!\n");
//
//    char *read = ONCHIP_MEMORY2_0_BASE;
//
//    while (read != ptr) {
//    	printf("%c", *read++);
//    }
//
//}


#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "system.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_uart_regs.h"
#include "altera_avalon_uart.h"
#include "altera_up_avalon_rs232.h"
#include "altera_up_avalon_rs232_regs.h"

#define DATA_SIZE 10000
#define MAX_CHARS 10

void delay(int a){
	volatile int i=0;
	while(i<a*1000){
		i++;
	}
}

char mostFrequentChar(char* str) {
    int len = strlen(str);
    int count[MAX_CHARS] = {0};
    int maxCount = 0;
    char result;

    // Count frequency of each character
    for (int i = 0; i < len; i++) {
        count[str[i]]++;
        if (count[str[i]] > maxCount) {
            maxCount = count[str[i]];
            result = str[i];
        }
    }
    return result;
}

int main(void){

	printf("hello from NIOS II\n");
	volatile int* data = IOADDR_ALT_UP_RS232_DATA(RS232_BASE);
	volatile unsigned char* mem = ONCHIP_MEMORY2_0_BASE;
	int i = 0;
	char a = '#';

	char fileData[DATA_SIZE];

//	for(int j=0; j<DATA_SIZE; j++){
////			printf("%c",fileData[j]);
//			fileData[j] = '\0';
//	}

	char holder = (*data & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;

//	while(1){
//			a = (*data & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;
//			if (a == '!'){
//				while (1){
//					a = (*data & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;
//					if (a == '?' || a == '~' || a == '!'){
//						printf("\n");
//						break;
//					}
//					else {
//						printf("%c", a);
//						delay(1);
//					}
//				}
//			}
//			if (a == '~') break;
//		}

		while(1){
				a = (*data & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;
				if (a == '!'){
					while (1){
						a = (*data & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;
						if (a == '?' || a == '~'){
							printf("\n");
							break;
						}
						else {
							delay(1);
//							printf("%c", a);
							printf("%d ", i);
							fileData[i] = a;
							i++;
						}
					}
				}
				if (a == '~') break;
			}

		printf("Outside while loop with file data\n");

//		char mostFrequent =  mostFrequentChar(fileData);

//		printf("Most Frequent Character: %c\n", mostFrequent);

		for(int j=0; j<DATA_SIZE; j++){
//			if(i%18 == 0) printf("\n");
			printf("%c",fileData[j]);
			fileData[j] = NULL;
		}


//	while(1){
//
//
//			  char a = (*data & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;
//			  if(a!=holder){
//				printf("%c",a);
//			  	holder=a;
//			  }
//
//			return 0;
//	}

	printf("Packet %d Recieved!\n", i);

//	volatile unsigned char* newmem = ONCHIP_MEMORY2_0_BASE;
//	for (int j = i; j > 0; j--) {
//		printf("%c", *newmem);
//		newmem++;
//	}

	while(1);


//	for (uint8_t i = 0; i < 100; i++) {
//		IOWR_ALTERA_AVALON_UART_RXDATA(RS232_BASE, 35);
//		char a = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//		printf("%d\n", a);
//	}

//	char a = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//	while(1){
//		a = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//		if (a == '!'){
//			while (1){
//				a = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//				if (a == '?' || a == '~'){
//					printf("\n");
//					break;
//				}
//				else {
//					printf("%c", a);
//				}
//			}
//		}
//	}
}

//int main(){
//  alt_putstr("Hello from Nios II!\n");
//
//  /* Event loop never exits. */
////	  printf("Hello from UART\n");
//	  char holder = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//	  char temp = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//	  char fileData[10000];
//	  unsigned int i = 0;
////	  while(1) {
////		  printf("%d\n", IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE));
////	  }
//	  while(1){
//
//		  char a = IORD_ALTERA_AVALON_UART_RXDATA(RS232_BASE);
//		  if(a!=holder){
//			i++;
//			if (i%2==1)	printf("%c",a);
////			if (i%2==0)	printf("%c",a);
//		  	holder=a;
//		  }
////		  // printf("%c\n", a);
////		  if(a!='q'){
////			  fileData[i]=a;
////			  i=i+1;
////		  }
////
////		  if (i >= 1000) break;
//	  }
//
////	  printf("%s", fileData);
//
//		  return 0;
//}


// Another Trial

//#include <stdio.h>
//#include "altera_up_avalon_uart.h"
//
//#define BAUD_RATE 115200      // Desired baud rate
//
//int main()
//{
//
////	alt_up_uart_dev *uart = alt_up_uart_open_dev(RS232_BASE); // Open the UART device
//
//
//	alt_up_rs232_dev *uart = alt_up_rs232_open_dev(RS232_BASE);
//
////	alt_up_uart_init(uart); // Initialize the UART module
//
//	ALTERA_UP_AVALON_RS232_INIT(uart,);
//
//	alt_up_uart_set_config(uart, BAUD_RATE, 8, 'N', 1); // Configure the UART module
//
//    printf("Waiting for start character '!'...\n");
//
//    unsigned char data;
//    while (1) {
//        alt_up_uart_read_data(uart, &data, 1); // Read one byte of data from the UART module
//        if (data == '!') { // Start reading and printing when '!' is received
//            printf("Start character '!' received. Reading and printing data...\n");
//            while (1) {
//                alt_up_uart_read_data(uart, &data, 1); // Read one byte of data from the UART module
//                printf("%c", data); // Print the received data
//                if (data == '?') { // Stop reading and printing when '?' is received
//                    printf("\n");
//                    break;
//                }
//            }
//        }
//    }
//
//    return 0;
//}
