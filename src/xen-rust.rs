#![feature(lang_items)]
#![no_std]

extern {
    fn printf(format: *const u8) -> i32;
}

#[no_mangle]
pub extern fn rust_main() {
    // Hello from Rust!
    let c_to_print: [u8;18] = [0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x66, 0x72, 0x6F, 0x6D, 0x20, 0x52, 0x75, 0x73, 0x74, 0x21, 0x0A, 0x00];

    unsafe { printf(c_to_print.as_ptr()); }
}

#[lang = "eh_personality"]
extern fn eh_personality() {}

#[lang = "panic_fmt"]
extern fn panic_fmt() -> ! {loop{}}

