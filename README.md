<div align="center">

# 42_LibASM

[About](#about-the-project) •
[Subject requirements](#subject-requirements) •
[Usage](#usage) •
[Useful links](#useful-links)

</div>

## About The Project
The aim of this project is to get familiar with x86_64 assembly language, reproducing behaviour of various functions of the C standard library as well as some other utility functions.

## Subject requirements
* You must use the Intel syntax, not the AT&T

***Available functions:***

|         Name          |                                                           Prototype                                                            |                                            Description                                             |
|:---------------------:|:------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------:|
|       `ft_read`       |                                   ssize_t ft_read(unsigned int fd, char *buf, size_t count);                                   |                                           man `read(2)`                                            |
|      `ft_strcmp`      |                                         int ft_strcmp(const char *s1, const char *s2);                                         |                                          man `strcmp(3)`                                           |
|      `ft_strcpy`      |                                          char *ft_strcpy(char *dst, char const *src);                                          |                                          man `strcpy(3)`                                           |
|      `ft_strdup`      |                                                char *ft_strdup(const char *s1);                                                |                                          man `strdup(3)`                                           |
|      `ft_strlen`      |                                               size_t ft_strlen(char const *str);                                               |                                          man `strlen(3)`                                           |
|      `ft_write`       |                               ssize_t ft_write(unsigned int fd, const char *buf, size_t nbyte);                                |                                           man `write(2)`                                           |
|    `ft_list_size`     |                                               size_t ft_list_size(t_list *lst);                                                |                            returns the number of elements in the list.                             |
|  `ft_list_remove_if`  | void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(const char *, const char *), void (*free_fct)(void *)); | removes from the list, all elements whose data compared to data_ref using cmp, makes cmp return 0. |
| `ft_list_push_front`  |                                   void ft_list_push_front(t_list **begin_list, void *data);                                    |                  adds a new element of type t_list to the beginning of the list.                   |

## Usage

To be continued ...

## Useful links
1. https://imada.sdu.dk/u/kslarsen/dm546/Material/IntelnATT.htm
2. https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
3. https://cs.lmu.edu/~ray/notes/nasmtutorial/
4. https://www.nasm.us/doc/
