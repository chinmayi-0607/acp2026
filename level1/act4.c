#include <stdio.h>
#include <string.h>
typedef struct{
    char player_name[50];
    int jersey_number;
    int runs_scored;
}Player;

void readPlayers(int n, Player p[]);
float calculateAverageRuns(int n, Player p[]);
void output(float average);

int main()
{
    int n=11;
    Player p[11];
    readPlayers(n,p);
    float avg=calculateAverageRuns(n,p);
    output(avg);
    return 0;
}

void readPlayers(int n, Player p[])
{
    for(int i=0;i<n;i++)
    {
        printf("Enter player names:");
        getchar();
        fgets(p[i].player_name, sizeof(p[i].player_name), stdin);
        p[i].player_name[strcspn(p[i].player_name, "\n")] = 0;
        printf("Enter jersey number:");
        scanf("%d",&p[i].jersey_number);
        printf("Enter runs scored:");
        scanf("%d",&p[i].runs_scored);
        
    }
}

float calculateAverageRuns(int n, Player p[])
{
    float avg=0;
    for (int i=0;i<n;i++)
    {
        avg+=p[i].runs_scored;
    }
    avg/=n;
    return avg;
}

void output(float avg)
{
    printf("average score:%.2f",avg);
}