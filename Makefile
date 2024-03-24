FLAGS = -g -felf64
NAME = libasm.a
TEST = libasm_test

CC = nasm

SRC = ft_read.s ft_strcmp.s ft_strcpy.s ft_strdup.s ft_strlen.s ft_write.s

BONUS_SRC = ft_list_push_front.s ft_list_size.s ft_list_remove_if.s ft_list_sort.s
#ft_atoi_base.s

# COLORS
NOC         = \033[0m
GREEN       = \033[1;32m
YELLOW      = \033[1;33m
BLUE        = \033[1;34m

OBJ = $(SRC:.s=.o)
BONUS_OBJ = $(BONUS_SRC:.s=.o)

all: $(NAME)

$(NAME):$(OBJ)
	@printf "$(GREEN)Libasm successfully compiled !$(NOC)\n"
	@ar rc $(NAME) $(OBJ)
	@ranlib $(NAME)

$(OBJ): %.o:%.s
	@$(CC) $(FLAGS) $<
	@printf "$(GREEN)[\342\234\205] $(notdir $@)$(NOC)\n";

bonus:$(BONUS_OBJ)
	@ar rc $(NAME) $(BONUS_OBJ)
	@ranlib $(NAME)

$(BONUS_OBJ): %.o:%.s
	@$(CC) $(FLAGS) $<
	@printf "$(GREEN)[\342\234\205] $(notdir $@)$(NOC)\n";

test: $(TEST)

$(TEST): all bonus
	@gcc main.c -L. -lasm -o $(TEST) && ./$(TEST)

clean:
	@if [ "$(wildcard $(addprefix ./, $(OBJ)))" ]; then\
		printf "$(BLUE)Cleaning libasm files: $(YELLOW)$(OBJ)$(NOC) $(GREEN) [ \342\234\205 ] $(NOC)\n";\
		/bin/rm -f $(OBJ);\
	else\
		printf "$(YELLOW)There's no object files in libasm \360\237\230\261$(NOC)\n";\
	fi
	@if [ "$(wildcard $(addprefix ./, $(BONUS_OBJ)))" ]; then\
    		printf "$(BLUE)Cleaning bonus libasm files: $(YELLOW)$(BONUS_OBJ) $(GREEN) [ \342\234\205 ] $(NOC)\n";\
    		/bin/rm -f $(BONUS_OBJ);\
    	else\
    		printf "$(YELLOW)There's no bonus object files in libasm \360\237\230\261$(NOC)\n";\
    	fi
fclean: clean
	@if [ "$(wildcard $(addprefix ./, $(NAME)))" ]; then\
		printf "$(BLUE)Cleaning libasm.a: $(YELLOW)$(NAME) $(GREEN) [ \342\234\205 ]\n$(NOC)";\
		/bin/rm -f $(NAME);\
	else\
		printf "$(YELLOW)There's no $(GREEN)libasm.a $(YELLOW)file here \360\237\230\261\n$(NOC)";\
	fi
	@/bin/rm -f $(TEST)

re: fclean all

.PHONY:	all clean fclean re bonus
