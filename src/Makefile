SRCS = main.cpp cli.cpp list.cpp
OBJS = $(SRCS:.cpp=.o)
TARGET = roger
CXXFLAGS = -std=c++17 -Wall -Wextra -lzstd -lminisat

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)
