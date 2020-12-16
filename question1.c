#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

pid_t pid;

void ctrlCHandler(int num){
    printf("\n heyyy \n");
    printf("%d", pid);
    //exit(0);
}

void ctrlZHandler(int num){
    
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

    if (pid == 0){

    }else{
        // wait(NULL);
        while(1){
            printf("wasted \n");
            sleep(1);
        }
    }

    return 0;



}
