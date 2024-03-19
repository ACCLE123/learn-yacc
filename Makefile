# 定义编译器和编译选项
CC = gcc
CFLAGS = -Wall -g
LFLAGS = -lfl

# 定义目标文件名
TARGET = calc

# 定义Bison和Flex生成的文件
BISON_SRC = calc.y
FLEX_SRC = calc.l
BISON_OUT = calc.tab.c
FLEX_OUT = calc.lex.c
BISON_HEADER = calc.tab.h

# 默认目标
all: $(TARGET)

# 生成可执行文件
$(TARGET): $(BISON_OUT) $(FLEX_OUT)
	$(CC) $(CFLAGS) -o $@ $(BISON_OUT) $(FLEX_OUT) $(LFLAGS)

# 生成Bison源文件
$(BISON_OUT): $(BISON_SRC)
	bison -d -o $@ $<

# 生成Flex源文件
$(FLEX_OUT): $(FLEX_SRC) $(BISON_HEADER)
	flex -o $@ $(FLEX_SRC)

# 清理编译生成的文件
clean:
	rm -f $(TARGET) $(BISON_OUT) $(FLEX_OUT) $(BISON_HEADER)

# 声明伪目标
.PHONY: all clean
