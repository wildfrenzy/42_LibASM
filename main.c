#include <stdio.h>
#include <sys/cdefs.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>
#include <errno.h>

typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

extern size_t ft_strlen(char const *str);
extern char *ft_strcpy(char *dst, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern ssize_t ft_write(unsigned int fd, const char *buf, size_t nbyte);
extern ssize_t ft_read(unsigned int fd, char *buf, size_t count);
extern char *ft_strdup(const char *s1);
//bonus part:
extern size_t ft_list_size(t_list *lst);
extern void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));



void test_strlen(void){
	//assert(ft_strlen(NULL) == 0); // original doesn't like null either :)
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
		//printf("errno: %d\n", errno);
		assert(errno == 9); //EBADF	Bad file descriptor
	}
	errno = 0;
	{
		assert(ft_write(1, 0, 1) == -1);
		//write(1, 0, 1);
		//printf("errno: %d\n", errno);
		assert(errno == 14); //EFAULT Bad address
	}
	errno = 0;
	{
		assert(ft_write(1, "STDOUT test\n", 12) == 12);
		assert(errno == 0);
	}
	puts("ft_write: OK");
}

void test_read(void){
	{
		char *buf;
		buf = calloc(sizeof(char) * 100, 1);

		char *buf2;
		buf2 = calloc(sizeof(char) * 100, 1);

		int fd = open("test.txt", O_RDONLY);
		int fd2 = open("test2.txt", O_RDONLY);

		assert(ft_read(fd, buf, 55) == read(fd2, buf2, 55));

		free(buf);
		free(buf2);

		close(fd);
		close(fd2);
	}
	{
		int ft_errno = 0;

		ft_read(-1, 0, 0);
		ft_errno = errno;
		errno = 0;
		read(-1, 0, 0);

		assert(ft_errno == errno);
		errno = 0;
	}

	puts("ft_read: OK");
}

void test_strdup(void){
	char *ft;
	char dup[50] = "strdup test";

	ft = ft_strdup(dup);
	assert(strcmp(dup, ft) == 0);
	puts("ft_strdup: OK");
	free(ft);
}

void test_ft_list_size(void){
	t_list a;
	t_list b;
	t_list c;
	t_list d;
	t_list e;

	a.next = &b;
	b.next = &c;
	c.next = &d;
	d.next = NULL;
	e.next = &a;

	assert(ft_list_size(&e) == 5);
	assert(ft_list_size(&a) == 4);
	assert(ft_list_size(&b) == 3);
	assert(ft_list_size(&c) == 2);
	assert(ft_list_size(&d) == 1);

	puts("ft_list_size: OK");
}

void free_fct(void *data){
	printf("free data: %s\n", (char *)data);
	free(data);
}

t_list	*ft_lstnew(void *content)
{
	struct s_list	*new;

	new = (t_list *)malloc(sizeof(t_list));
	if (new == NULL)
		return (0);
	new->data = content;
	new->next = NULL;
	return (new);
}

void test_list_remove_if(void){
	char *keep = strdup("Hello");
	char *del = strdup("remove");

	t_list *a = ft_lstnew(keep);
	t_list *b = ft_lstnew(keep);
	t_list *c = ft_lstnew(del);
	t_list *d = ft_lstnew(keep);

	a->next = b;
	b->next = c;
	c->next = d;

	//(*cmp)(list_ptr->data, data_ref);
	//(*free_fct)(list_ptr->data);

	assert(ft_list_size(a) == 4);
	ft_list_remove_if(&a, del, strcmp, free_fct);
	assert(ft_list_size(a) == 3);
}


int main(void){
	test_strlen();
	test_strcpy();
	test_strcmp();
	test_write();
	test_read();
	test_strdup();
    test_ft_list_size();

	return 0;
}