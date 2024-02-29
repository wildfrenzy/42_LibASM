#include <stdio.h>
//nasm -felf64 ft_strlen.s && gcc -Wall -Wextra -Werror ft_strlen.o main.c && ./a.out

extern size_t ft_strlen(char const *str);

int main(void){
	printf("%zu\n", ft_strlen("Hello"));
	return 0;
}
