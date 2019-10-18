CXX = $(shell sst-config --CXX)
CXXFLAGS = $(shell sst-config --ELEMENT_CXXFLAGS)
LDFLAGS  = $(shell sst-config --ELEMENT_LDFLAGS)

SRC = $(wildcard *.cc)
OBJ = $(SRC:%.cc=.build/%.o)
DEP = $(OBJ:%.o=%.d)

.PHONY: all checkOptions install uninstall clean

memHierarchy ?= $(shell sst-config memHierarchy memHierarchy_LIBDIR)

all: checkOptions install

checkOptions:
ifeq ($(memHierarchy),)
	$(error memHierarchy Environment variable needs to be defined, ex: "make memHierarchy=/path/to/memHierarchy")
endif

-include $(DEP)
.build/%.o: %.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -I$(memHierarchy) -MMD -c $< -o $@

libGNA.so: $(OBJ)
	$(CXX) $(CXXFLAGS) -I$(memHierarchy) $(LDFLAGS) -o $@ $^ -L$(memHierarchy) -lmemHierarchy

install: libGNA.so
	sst-register GNA GNA_LIBDIR=$(CURDIR)

uninstall:
	sst-register -u GNA

clean: uninstall
	rm -rf .build libGNA.so