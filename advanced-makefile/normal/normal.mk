NAME		= normal

DIR			= normal
SRCDIR		= $(DIR)/src
INCDIR		= $(DIR)/include

SRCS		= main.c

SRCS		:= $(addprefix $(SRCDIR)/, $(SRCS))

vpath %.c $(SRCDIR)
vpath %.h $(INCDIR)
