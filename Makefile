
all: libfrosted.a

libfrosted.a: libfrosted
	make -C libfrosted

clean:
	make -C apps clean
	make -C libfrosted clean
