#include <stdio.h>
#include <unistd.h>
//nasm -felf64 ft_strlen.s && gcc -Wall -Wextra -Werror ft_strlen.o main.c && ./a.out

extern size_t ft_strlen(char const *str);
extern char *ft_strcpy(char *dst, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern size_t ft_write(int fd, const char *buf, size_t nbyte);

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

	printf("mine: %ld\n", ft_write(1, NULL, 2));
	perror("ft_write");

	printf("original: %ld\n", write(1, NULL, 2));
	perror("write");

	printf("mine: %ld\n", ft_write(-1, "hallo\n", 2));
	//perror("ft_write");

	printf("original: %ld\n", write(-1, "hallo\n", 2));
	//perror("write");

	printf("mine: %ld\n", ft_write(10, "hallo\n", 6));
	perror("ft_write");

	printf("original: %ld\n", write(10, "hallo\n", 6));
	perror("write");

	return 0;
}
