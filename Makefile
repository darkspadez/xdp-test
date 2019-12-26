all: xdp-cf.o

.PHONY: xdp-cf.o
xdp-cf.o: xdp-cf.c
		clang -Wall -Wextra \
				-O2 -emit-llvm \
				-c $(subst .o,.c,$@) -S -o - \
		| llc -march=bpf -filetype=obj -o $@

.PHONY:
clean:
		rm xdp-cf.o