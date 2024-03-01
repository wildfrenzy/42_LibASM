#include <stdio.h>
//nasm -felf64 ft_strlen.s && gcc -Wall -Wextra -Werror ft_strlen.o main.c && ./a.out

extern size_t ft_strlen(char const *str);
extern char *ft_strcpy(char *dst, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);

int main(void){
	char dst[20];
	char *src = "Hello hi";

	//printf("%zu\n", ft_strlen("Hello"));
	printf("strcpy: %s\n", ft_strcpy(dst, src));
	printf("strcpy dest: %s\n", dst);
	printf("strcpy src: %s\n", src);

	printf("strcmp: %d\n", ft_strcmp("Hello", "Hello"));
	printf("strcmp: %d\n", ft_strcmp("A", "a"));
	printf("ft: %d\n", ft_strcmp("c", "a"));
	return 0;
}
