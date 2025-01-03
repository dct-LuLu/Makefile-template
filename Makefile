# Colors and formatting
GREEN		= \e[1;32m
BLUE		= \e[1;34m
RED			= \e[1;31m
YELLOW		= \e[1;33m
PURPLE		= \e[1;35m
UNDERLINE	= \e[4m
BOLD		= \e[1m
RESET		= \e[0m

# Directories
SRCDIR		= .
OBJDIR		= .obj
DEPDIR		= .dep
INCDIR		= include
LIBFTDIR	= libft

# Output
NAME		= program_name
LIBFT		= $(LIBFTDIR)/libft.a

# Compiler and flags
CC			= cc
CFLAGS		= -Wall -Wextra -Werror
DFLAGS		= -MMD -MP -MF $(DEPDIR)/$*.d
IFLAGS		= -I$(INCDIR) -I$(LIBFTDIR)/include
LFLAGS		= -L$(LIBFTDIR) -lft
CF			= $(CC) $(CFLAGS) $(IFLAGS) $(DFLAGS)

# VPATH
vpath %.c $(SRCDIR) $(LIBFTDIR)/$(SRCDIR)
vpath %.h $(INCDIR) $(LIBFTDIR)/$(INCDIR)
vpath %.o $(OBJDIR) $(LIBFTDIR)/$(OBJDIR)
vpath %.d $(DEPDIR) $(LIBFTDIR)/$(DEPDIR)

# Sources
SRCS		= main.c

OBJS		= $(addprefix $(OBJDIR)/, $(notdir $(SRCS:.c=.o)))
DEPS		= $(addprefix $(DEPDIR)/, $(notdir $(SRCS:.c=.d)))

all: $(LIBFT) $(NAME)

$(NAME): $(OBJS) $(LIBFT)
	@echo -e "$(BLUE)Creating program $(UNDERLINE)$(NAME)$(RESET)$(BLUE)...$(RESET)"
	@$(CF) $^ $(LFLAGS) -o $@
	@echo -e "$(GREEN)$(BOLD)✓ Program $(UNDERLINE)$(NAME)$(RESET)$(GREEN)$(BOLD) successfully created!$(RESET)"

$(LIBFT):
	@echo -e "$(PURPLE)➜ Building $(UNDERLINE)libft$(RESET)"
	@$(MAKE) -s -C $(LIBFTDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR) $(DEPDIR)
	@echo -e "$(PURPLE)➜ Compiling $(UNDERLINE)$<$(RESET)"
	@$(CF) -c $< -o $@

$(OBJDIR) $(DEPDIR):
	@echo -e "$(BLUE)Creating directory $(UNDERLINE)$@$(RESET)"
	@mkdir -p $@

clean:
	@$(MAKE) -s -C $(LIBFTDIR) clean
	@echo -e "$(RED)Cleaning $(UNDERLINE)$(NAME)$(RESET)$(RED) object files from $(UNDERLINE)$(OBJDIR)$(RESET)$(RED) and $(UNDERLINE)$(DEPDIR)$(RESET)"
	@rm -rf $(OBJDIR) $(DEPDIR)

fclean:
	@$(MAKE) -s -C $(LIBFTDIR) fclean
	@echo -e "$(RED)Cleaning $(UNDERLINE)$(NAME)$(RESET)$(RED) object files from $(UNDERLINE)$(OBJDIR)$(RESET)$(RED) and $(UNDERLINE)$(DEPDIR)$(RESET)"
	@rm -rf $(OBJDIR) $(DEPDIR)
	@echo -e "$(RED)Removing program $(UNDERLINE)$(NAME)$(RESET)"
	@rm -f $(NAME)

re: fclean all

debug: CFLAGS += -g
debug:
	@echo -e "$(YELLOW)$(BOLD)⚠ Building in debug mode...$(RESET)"
	@$(MAKE) -s -C $(LIBFTDIR) debug
	@$(MAKE) -s -B $(OBJS)
	@$(MAKE) -s $(NAME)
	@echo -e "$(YELLOW)$(BOLD)✓ Debug build complete$(RESET)"

help:
	@echo "Available targets:"
	@echo "  all     : Build the program"
	@echo "  clean   : Remove object files"
	@echo "  fclean  : Remove object files and program"
	@echo "  re      : Rebuild everything"
	@echo "  debug   : Build with debug symbols"

-include $(DEPS)

.PHONY: all clean fclean re debug help

