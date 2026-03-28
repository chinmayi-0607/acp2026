#include <stdio.h>
#include <stdlib.h>

/* Structure Definition */
typedef struct {
    int id;
    char name[50];
    float marks;
} Student;

/* Function Prototypes */
void inputStudents(Student students[], int n);
void writeToBinaryFile(Student students[], int n, const char *filename);
int readFromBinaryFile(Student students[], const char *filename);
void printStudents(Student students[], int n);

/* Main Function */
int main() {
    int n;

    printf("Enter number of students: ");
    scanf("%d", &n);

    Student students[n], studentsFromFile[n];

    inputStudents(students, n);

    writeToBinaryFile(students, n, "students.dat");

    int count = readFromBinaryFile(studentsFromFile, "students.dat");

    printf("\nStudents read from file:\n");
    printStudents(studentsFromFile, count);

    return 0;
}

/* Function Definitions */

void inputStudents(Student students[], int n) {
    for (int i = 0; i < n; i++) {
        printf("\nEnter details for student %d\n", i + 1);
        printf("ID: ");
        scanf("%d", &students[i].id);

        printf("Name: ");
        scanf("%s", students[i].name);

        printf("Marks: ");
        scanf("%f", &students[i].marks);
    }
}

void writeToBinaryFile(Student students[], int n, const char *filename) {
    FILE *fp = fopen(filename, "wb");

    if (fp == NULL) {
        printf("Error opening file for writing!\n");
        return;
    }

    fwrite(students, sizeof(Student), n, fp);
    fclose(fp);

    printf("\nData written to binary file successfully.\n");
}

int readFromBinaryFile(Student students[], const char *filename) {
    FILE *fp = fopen(filename, "rb");

    if (fp == NULL) {
        printf("Error opening file for reading!\n");
        return 0;
    }

    int count = fread(students, sizeof(Student), 100, fp);
    fclose(fp);

    return count;
}

void printStudents(Student students[], int n) {
    for (int i = 0; i < n; i++) {
        printf("\nStudent %d\n", i + 1);
        printf("ID: %d\n", students[i].id);
        printf("Name: %s\n", students[i].name);
        printf("Marks: %.2f\n", students[i].marks);
    }
}