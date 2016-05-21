XEN_ROOT = $(CURDIR)/../..

ifeq (,$(findstring clean,$(MAKECMDGOALS)))
include $(XEN_ROOT)/Config.mk
endif

ARCH   ?= x86_64
TARGET ?= $(ARCH)-unknown-linux-gnu

all: main.a
	
target/$(TARGET)/debug/libxen_rust.a: Cargo.toml src/xen-rust.rs
	cargo rustc -v --target $(TARGET) -- -Z no-landing-pads

main_wrapper.a: main_wrapper.o
	$(AR) cr $@ $^

main.a: main_wrapper.a target/$(TARGET)/debug/libxen_rust.a
	@rm -f main.a
	$(AR) cqT $@ $^
	echo -e 'create $@\naddlib $@\nsave\nend' | ar -M

clean:
	rm -rf *.a *.o target Cargo.lock
