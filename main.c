#include <stdio.h>
#include <sys/cdefs.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>
#include <errno.h>

//nasm -felf64 ft_read.s && gcc -no-pie -Wall -Wextra -Werror ft_read.o main.c && ./a.out

extern size_t ft_strlen(char const *str);
extern char *ft_strcpy(char *dst, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern size_t ft_write(unsigned int fd, const char *buf, size_t nbyte);
extern size_t ft_read(unsigned int fd, char *buf, size_t count);

void test_strlen(void){
	//assert(ft_strlen(NULL) == 0);
	assert(ft_strlen("") == strlen(""));
	assert(ft_strlen("Hello") == strlen("Hello"));
	assert(ft_strlen("Hello\n") == strlen("Hello\n"));
	assert(ft_strlen("aaa\0bbb") == strlen("aaa\0bbb"));
	puts("ft_strlen: OK");
}

void test_strcpy(void){
	char dst[20];
	char odst[20];
	char *src = "Hello hi";
	{
		assert(ft_strcpy(dst, src) == dst);
		assert(strcmp(dst, src) == 0);
		strcpy(odst, src);
		assert(strcmp(dst, odst) == 0);
	}
	{
		assert(ft_strcpy(dst, "aaa") == dst);
		assert(strcmp(dst, "aaa") == 0);
		strcpy(odst, "aaa");
		assert(strcmp(dst, odst) == 0);
	}
	{
		assert(ft_strcpy(dst, "aaa\0bbb") == dst);
		assert(strcmp(dst, "aaa\0bbb") == 0);
		strcpy(odst, "aaa\0bbb");
		assert(strcmp(dst, odst) == 0);
	}
	puts("ft_strcpy: OK");
}

void test_strcmp(void){
	{
		char a[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
		char b[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
		//printf("test 1: FT %d : OR %d\n", ft_strcmp(a, b), strcmp(a, b));
		assert(ft_strcmp(a, b) == strcmp(a, b));
	}
	{
		char a[6] = {'H', 'e', 'a', 'l', 'o', '\0'};
		char b[6] = {'H', 'e', 'A', 'l', 'o', '\0'};
		//printf("test 2: FT %d : OR %d\n", ft_strcmp(a, b), strcmp(a, b));
		assert(ft_strcmp(a, b) > 0 && strcmp(a, b) > 0);
	}
	{
		char a[6] = {'H', 'e', 'A', 'l', 'o', '\0'};
		char b[6] = {'H', 'e', 'a', 'l', 'o', '\0'};
		//printf("test 3: FT %d : OR %d\n", ft_strcmp(a, b), strcmp(a, b));
		assert(ft_strcmp(a, b) < 0 && strcmp(a, b) < 0);
	}
	{
		char a[6] = {'H', 'e', '\0'};
		char b[6] = {'H', 'e', 'a', 'l', 'o', '\0'};
		//printf("test 4: FT %d : OR %d\n", ft_strcmp(a, b), strcmp(a, b));
		assert(ft_strcmp(a, b) < 0 && strcmp(a, b) < 0);
	}
	{
		char a[6] = {'H', 'e', 'a', 'l', 'o', '\0'};
		char b[6] = {'H', 'e', '\0'};
		//printf("test 5: FT %d : OR %d\n", ft_strcmp(a, b), strcmp(a, b));
		assert(ft_strcmp(a, b) > 0 && strcmp(a, b) > 0);
	}

	puts("ft_strcmp: OK");
}

void test_write(void){
	{
		assert(ft_write(-1, "FD test\n", 8) == -1);
		printf("errno: %d\n", errno);
	}
}

int main(void){
	test_strlen();
	test_strcpy();
	test_strcmp();

	ft_write(1, "Hallo\n", 6);
	// printf("mine: %ld\n", ft_write(1, NULL, 2));
	// perror("ft_write");

	// printf("original: %ld\n", write(1, NULL, 2));
	// perror("write");

	// printf("mine: %ld\n", ft_write(-1, "hallo\n", 2));
	// //perror("ft_write");

	// printf("original: %ld\n", write(-1, "hallo\n", 2));
	// //perror("write");

	// printf("mine: %ld\n", ft_write(10, "hallo\n", 6));
	// perror("ft_write");

	// printf("original: %ld\n", write(10, "hallo\n", 6));
	// perror("write");
/*
	char *buf;
	buf = calloc(sizeof(char) * 10, 1);

	int fd = open("test.txt", O_RDONLY);
	printf("fd: %d\n", fd);
	perror("open");
	ft_read(fd, buf, 60);
	perror("ft_read");
	printf("mine: %s\n", buf);
	free(buf);
	close(fd);

	write(1, "**********\n", 11);
	char *buf2;
	buf2 = calloc(sizeof(char) * 10, 1);

	int fd2 = open("test2.txt", O_RDONLY);
	printf("fd: %d\n", fd2);
	perror("open");
	read(fd2, buf2, 60);
	perror("read");
	printf("original: %s\n", buf2);
	free(buf2);
	close(fd2);
*/
	return 0;
}