#include <stdio.h>
#include <string.h>
#include <ctype.h>


int isIdentifier(const char *str) {
    
    if (!isalpha(str[0]) && str[0] != '_')
        return 0;

   
    for (int i = 1; str[i] != '\0'; i++) {
        if (!isalnum(str[i]) && str[i] != '_')
            return 0;
    }
    return 1;
}


int isConstant(const char *str) {
    int i = 0;

    if (str[i] == '+' || str[i] == '-')
        i++;

    for (; str[i] != '\0'; i++) {
        if (!isdigit(str[i]))
            return 0;
    }

    return (i > 0); 
}

// Function to check if a string is an operator
int isOperator(const char *str) {
    const char operators[] = {"+", "-", "", "/", "%", "=", "==", "!=", "<", "<=", ">", ">=", "&&", "||", "!"};
    int numOperators = sizeof(operators) / sizeof(operators[0]);

    for (int i = 0; i < numOperators; i++)      {
        if (strcmp(str, operators[i]) == 0)
            return 1;
    }
    return 0;
}
void analyzeToken(const char *str) {
    char token[100];
    int j = 0;

    for (int i = 0; str[i] != '\0'; i++) {
        char singleCharStr[2] = {str[i], '\0'};
        if (isspace(str[i]) || isOperator(singleCharStr)) {
            if (j > 0) {
                token[j] = '\0';
                if (isIdentifier(token)) {
                    printf("'%s' is an Identifier.\n", token);
                } else if (isConstant(token)) {
                    printf("'%s' is a Constant.\n", token);
                }
                j = 0;
            }
            char op[2] = {str[i], '\0'};
            if (isOperator(op)) {
                printf("'%c' is an Operator.\n", str[i]);
            }
        } else {
            token[j++] = str[i];
        }
    }

    if (j > 0) {
        token[j] = '\0';
        if (isIdentifier(token)) {
            printf("'%s' is an Identifier.\n", token);
        } else if (isConstant(token)) {
            printf("'%s' is a Constant.\n", token);
        }
    }
}

int main() {
    char input[100];

    printf("Enter a token: ");
    scanf("%s", input);

    analyzeToken(input);

    if (isIdentifier(input)) {
        printf("'%s' is an Identifier.\n", input);
    } else if (isConstant(input)) {
        printf("'%s' is a Constant.\n", input);
    } else if (isOperator(input)) {
        printf("'%s' is an Operator.\n", input);
    } else {
        printf("'%s' is not recognized as an Identifier, Constant, or Operator.\n", input);
    }

    return 0;
}