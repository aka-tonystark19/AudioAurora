#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

enum State {WAIT, FIRST, SECOND, END};

int main(void) {
    // store hello in a string as a char array
    // Hello World 391 Sucks
    char string[] = "['!546F6E696768742049276D20676F6E6E612068617665206D7973656C662061207265616C20676F6F642074696D650D0A49?','!206665656C20616C6976650D0A416E642074686520776F726C642049276C6C207475726E20697420696E73696465206F75?','!742C20796561680D0A49276D20666C6F6174696E672061726F756E6420696E20656373746173790D0A536F2C2028646F6E?','!27742073746F70206D65206E6F77290D0A28446F6E27742073746F70206D65290D0A2743617573652049276D2068617669?','!6E67206120676F6F642074696D652C20686176696E67206120676F6F642074696D650D0A49276D20612073686F6F74696E?','!672073746172206C656170696E67207468726F7567682074686520736B79206C696B6520612074696765720D0A44656679?','!696E6720746865206C617773206F6620677261766974790D0A49276D206120726163696E67206361722070617373696E67?','!206279206C696B65204C61647920476F646976610D0A49276D20676F6E6E6120676F2C20676F2C20676F2C207468657265?','!2773206E6F2073746F7070696E67206D650D0A49276D206275726E696E27207468726F7567682074686520736B792C2079?','!6561680D0A32303020646567726565732C207468617427732077687920746865792063616C6C206D65204D697374657220?','!46616872656E686569740D0A49276D2074726176656C6C696E6720617420746865207370656564206F66206C696768740D?','!0A492077616E6E61206D616B652061207375706572736F6E6963206D616E206F7574206F6620796F750D0A28446F6E2774?','!2073746F70206D65206E6F77290D0A49276D20686176696E672073756368206120676F6F642074696D650D0A49276D2068?','!6176696E6720612062616C6C0D0A28446F6E27742073746F70206D65206E6F77290D0A496620796F752077616E6E612068?','!617665206120676F6F642074696D650D0A2E2E2E0D0A2A2A2A2A2A2A2A2054686973204C7972696373206973204E4F5420?','!666F7220436F6D6D65726369616C20757365202A2A2A2A2A2A2A0D0A283134303936323331383530353129~']";
    
    // print the string
    // printf("%s\n", string);

    char save[10000];
    char *ptr = save;

    // create a state variable
    int i = 0;
    uint8_t curr = 0;
    uint8_t temp = 0;
    enum State state = WAIT;

    while (state != END) {
        switch (state) {
            case WAIT:
                // printf("WAIT\n");
                if (string[i] == '!') {
                    state = FIRST;
                }
                break;
            case FIRST:
                if (string[i] == '?') {
                    state = WAIT;
                } else if (string[i] == '~') {
                    state = END;
                } else {
                    curr = 0;
                    switch(string[i]) {
                        case '0':   temp = 0;   break;
                        case '1':   temp = 1;   break;
                        case '2':   temp = 2;   break;
                        case '3':   temp = 3;   break;
                        case '4':   temp = 4;   break;
                        case '5':   temp = 5;   break;
                        case '6':   temp = 6;   break;
                        case '7':   temp = 7;   break;
                        case '8':   temp = 8;   break;
                        case '9':   temp = 9;   break;
                        case 'A':   temp = 10;  break;
                        case 'B':   temp = 11;  break;
                        case 'C':   temp = 12;  break;
                        case 'D':   temp = 13;  break;
                        case 'E':   temp = 14;  break;
                        case 'F':   temp = 15;  break;
                        default: printf("1 BRUH\n");
                    }

                    curr = temp * 16;
                    state = SECOND;
                }
                break;
            case SECOND:
                switch(string[i]) {
                    case '0':   temp = 0;   break;
                    case '1':   temp = 1;   break;
                    case '2':   temp = 2;   break;
                    case '3':   temp = 3;   break;
                    case '4':   temp = 4;   break;
                    case '5':   temp = 5;   break;
                    case '6':   temp = 6;   break;
                    case '7':   temp = 7;   break;
                    case '8':   temp = 8;   break;
                    case '9':   temp = 9;   break;
                    case 'A':   temp = 10;  break;
                    case 'B':   temp = 11;  break;
                    case 'C':   temp = 12;  break;
                    case 'D':   temp = 13;  break;
                    case 'E':   temp = 14;  break;
                    case 'F':   temp = 15;  break;
                    default: printf("2 BRUH %d %c\n", i, string[i]);
                }

                curr += temp;
                // printf("%d\n", curr);
                *ptr++ = curr;

                state = FIRST;
                break;
            case END:
                break;
        }
        i++;
    }


    // print the string
    printf("%s", save);
}