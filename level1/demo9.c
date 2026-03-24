#include <stdio.h>
#include <stdlib.h>

#define MAX_STUDENTS 100
#define MAX_NAME 50

typedef struct {
    int roll_no;
    char name[MAX_NAME];
    float marks;
} Student;

void inputStudents(Student students[], int n);
void writeToTextFile(Student students[], int n, const char *filename);
int readFromTextFile(Student students[], const char *filename);
void printStudents(Student students[], int n);

int main() {
    Student students1[MAX_STUDENTS];
    Student students2[MAX_STUDENTS];
    int n, read_count;
    const char *filename = "students.txt";
    
    printf("Enter number of students: ");
    scanf("%d", &n);
    
    printf("Enter details of %d students:\n", n);
    inputStudents(students1, n);
    
    writeToTextFile(students1, n, filename);
    printf("Data written to %s\n", filename);
    
    read_count = readFromTextFile(students2, filename);
    printf("Read %d students from %s\n", read_count, filename);
    
    printf("\nStudents data read from file:\n");
    printStudents(students2, read_count);
    
    return 0;
}

void inputStudents(Student students[], int n) {
    for (int i = 0; i < n; i++) {
        printf("Student %d:\n", i + 1);
        printf("Roll No: ");
        scanf("%d", &students[i].roll_no);
        
        printf("Name: ");
        scanf("%s", students[i].name);
        
        printf("Marks: ");
        scanf("%f", &students[i].marks);
        printf("\n");
    }
}

void writeToTextFile(Student students[], int n, const char *filename) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file %s for writing!\n", filename);
        return;
    }
    
    fprintf(file, "%d\n", n);
    
    for (int i = 0; i < n; i++) {
        fprintf(file, "%d %s %.2f\n", 
                students[i].roll_no, 
                students[i].name, 
                students[i].marks);
    }
    
    fclose(file);
}

int readFromTextFile(Student students[], const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file %s for reading!\n", filename);
        return 0;
    }
    
    int n;
    if (fscanf(file, "%d", &n) != 1) {
        fclose(file);
        return 0;
    }
    
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (fscanf(file, "%d %s %f", 
                   &students[i].roll_no, 
                   students[i].name, 
                   &students[i].marks) == 3) {
            count++;
        }
    }
    
    fclose(file);
    return count;
}

void printStudents(Student students[], int n) {
    printf("================================\n");
    printf("STUDENT RECORDS\n");
    printf("================================\n");
    
    for (int i = 0; i < n; i++) {
        printf("Student %d:\n", i + 1);
        printf("Roll No: %d\n", students[i].roll_no);
        printf("Name: %s\n", students[i].name);
        printf("Marks: %.2f\n", students[i].marks);
        printf("----------------------------\n");
    }
    printf("================================\n");
}
