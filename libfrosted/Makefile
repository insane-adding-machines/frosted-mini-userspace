FROSTED?=frosted
CROSS_COMPILE?=arm-none-eabi-
CC:=$(CROSS_COMPILE)gcc
AS:=$(CROSS_COMPILE)as
AR:=$(CROSS_COMPILE)ar
LIBNAME:=libfrosted.a
PREFIX:=$(PWD)/build
#Target flags
CFLAGS+=-mcpu=cortex-m3 -mthumb -mlittle-endian -mthumb-interwork -fno-common
CFLAGS+=-DCORE_M3 -DARCH_$(ARCH)
CFLAGS+=-DKLOG_LEVEL=6
#Include paths
CFLAGS+=-I. -I$(FROSTED)/include -I$(FROSTED)/include/libc 
#Freestanding options
#CFLAGS+=-fno-builtin
#CFLAGS+=-ffreestanding
# GOTPIC CFLAGS
#CFLAGS+=-fPIC -mword-relocations -mlong-calls -fno-common -msingle-pic-base -mpic-register=r9 -mno-pic-data-is-text-relative
#Debugging
CFLAGS+=-ggdb
ASFLAGS:=-mcpu=cortex-m3 -mthumb -mlittle-endian -mthumb-interwork -ggdb

OBJS-y+=						\
		accept.o				\
		bind.o					\
		closedir.o				\
		connect.o				\
		chdir.o					\
		chroot.o				\
		close.o					\
		dup.o					\
		dup2.o					\
		errno.o					\
		exec.o					\
		exit.o					\
		fgets.o					\
		fork.o					\
		free.o					\
		fstat.o					\
		getcwd.o				\
		gethostname.o			\
		getlogin.o				\
		getpid.o				\
		getppid.o				\
		getsockopt.o			\
		grp.o					\
		ioctl.o					\
		isatty.o				\
		kill.o					\
		link.o					\
		lseek.o					\
		listen.o				\
		malloc.o				\
		malloc_trim.o			\
		mkdir.o					\
		mutex_init.o			\
		mutex.o					\
		mount.o					\
		newlib_syscalls.o		\
		open.o					\
		opendir.o				\
		pipe.o					\
		poll.o					\
		printf.o				\
		pwd.o					\
		read.o					\
		readdir.o				\
		recvfrom.o				\
		resource.o				\
		stat.o					\
		string.o				\
		sem_init.o				\
		semaphore.o				\
		sigaction.o				\
		signal.o				\
		sigprocmask.o			\
		sigsuspend.o			\
		socket.o				\
		sendto.o				\
		setsockopt.o			\
		sleep.o					\
		shutdown.o				\
		syscall.o				\
		svc.o	    			\
		ttyname.o				\
		thread_create.o			\
		thread_join.o			\
		tcsetattr.o				\
		tcgetattr.o				\
		tcsendbreak.o			\
		unlink.o				\
		umount.o				\
		uid.o					\
		umask.o					\
		vfork.o					\
		wait.o					\
		waitpid.o				\
		write.o					\
		posix/collate_error.o   \
		posix/collcmp.o			\
		posix/execl.o			\
		posix/execle.o			\
		posix/execlp.o			\
		posix/execv.o			\
		posix/execve.o			\
		posix/execvp.o			\
		posix/glob.o			\
		posix/regcomp.o  		\
		posix/regerror.o  		\
		posix/regexec.o  		\
		posix/regfree.o			\
		syscall_table.o


CFLAGS+=$(CFLAGS-y)


all: $(OBJS-y) 
	@echo -e "\t[AR] ../$(LIBNAME)"
	@$(AR) cru ../$(LIBNAME) $(OBJS-y)

clean:
	@rm -f $(OBJS-y)
	@rm -f ../$(LIBNAME)

