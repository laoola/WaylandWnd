WAYLAND_FLAGS = $(shell pkg-config wayland-client --cflags --libs)
WAYLAND_PROTOCOLS_DIR = $(shell pkg-config wayland-protocols --variable=pkgdatadir)
WAYLAND_SCANNER = $(shell pkg-config --variable=wayland_scanner wayland-scanner)

XDG_SHELL_PROTOCOL = $(WAYLAND_PROTOCOLS_DIR)/stable/xdg-shell/xdg-shell.xml

HEADERS=xdg-shell-client-protocol.h
SOURCES=xdg-shell-protocol.c

CXX=g++
CXXFLAGS=-Wall -Wextra -g -I.
CC=gcc
CFLAGS=-Wall -Wextra -g
LDLIBS=-lwayland-client -lpng -lm -lpthread
LDFLAGS=-L./
SRCS=$(wildcard *.cpp) $(wildcard *.c)
OBJS=$(SRCS:.cpp=.o) $(SRCS:.c=.o)
TARGET=WaylandWnd

all: $(HEADERS) $(SOURCES)  $(TARGET) 

$(HEADERS):
	$(WAYLAND_SCANNER) client-header $(XDG_SHELL_PROTOCOL) $@

$(SOURCES):
	$(WAYLAND_SCANNER) private-code $(XDG_SHELL_PROTOCOL) $@

$(TARGET): $(OBJS)
	rm -rf $(TARGET)
	$(CXX) $(CXXFLAGS) $(filter %.o,$^) -o $@ $(LDFLAGS) $(LDLIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	#rm -rf  $(TARGET)
	rm -rf *.o
