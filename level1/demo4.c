#include <stdio.h>
#include <string.h>

// Structure definition
typedef struct {
    char flight_number[10];
    char destination[50];
    int available_seats;
} Flight_t;

// Function prototypes
void readFlights(int n, Flight_t f[]);
void searchByDestination(int n, Flight_t f[], char searchDest[]);

int main() {
    Flight_t flights[4];
    char searchDest[50];

    printf("Enter details for 4 flights:\n");
    readFlights(4, flights);

    printf("\nEnter destination to search: ");
    fgets(searchDest, sizeof(searchDest), stdin);
    searchDest[strcspn(searchDest, "\n")] = 0;

    searchByDestination(4, flights, searchDest);

    return 0;
}

// Read flight details
void readFlights(int n, Flight_t f[]) {
    for (int i = 0; i < n; i++) {
        printf("Flight %d:\n", i + 1);

        printf("Flight Number: ");
        fgets(f[i].flight_number, sizeof(f[i].flight_number), stdin);
        f[i].flight_number[strcspn(f[i].flight_number, "\n")] = 0;

        printf("Destination: ");
        fgets(f[i].destination, sizeof(f[i].destination), stdin);
        f[i].destination[strcspn(f[i].destination, "\n")] = 0;

        printf("Available Seats: ");
        scanf("%d", &f[i].available_seats);
        getchar(); // clear newline
    }
}

// Search function
void searchByDestination(int n, Flight_t f[], char searchDest[]) {
    int found = 0;

    for (int i = 0; i < n; i++) {
        if (strcasecmp(f[i].destination, searchDest) == 0) {
            printf("Flight available: %s\n", f[i].flight_number);
            found = 1;
        }
    }

    if (!found) {
        printf("No flights available to %s\n", searchDest);
    }
}