#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

pid_t pid;

int childTerminated = 1;

void ctrlZHandler(int num)
{    
    printf("hello");      
    if (num == SIGCHLD)
    {        
        printf("hello1");
        childTerminated = 1;
        kill(pid, SIGCONT);        
    }else{
        printf("hello2");
        childTerminated = 0;
        kill(pid, SIGSTOP);        
    }
}



void ctrlCHandler(int num){
    printf("\n heyyy \n");
    printf("%d", pid);
    kill(pid, SIGKILL);
    //exit(0);
}


void seghandler(int num){
    write(STDOUT_FILENO, "Seg Fault \n", 10);
}


int main(int argc, char* argv[]){
    struct sigaction ctrlC;
    ctrlC.sa_handler = ctrlCHandler;
    sigaction(SIGINT, &ctrlC, NULL);    


    struct sigaction ctrlZ;
    ctrlZ.sa_handler = ctrlZHandler;
    sigaction(SIGTSTP, &ctrlZ, NULL);
    
    // sigaction(SIGTERM, &sa, NULL);
    // signal(SIGINT, ctrlCHandler);

    pid = fork();
    if (pid == -1){
        return 1;
    }

    if (pid == 0){ // Children     
            
        while(childTerminated){
            printf("wasted \n");
            sleep(1);            
        }

    }else{ // Parent 
        wait(NULL);
        exit(0);
    }

    return 0;



}
