/*
 * Rust Bootstrap
 *
 */

#include <stdio.h>
#include <errno.h>
#include <unistd.h>

/* Ugly binary compatibility with Linux */
FILE *_stderr asm("stderr");
int *__errno_location;
/* Will probably break everything, probably need to fetch from glibc */
void *__ctype_b_loc;

extern void rust_main(void);

int main(int argc, char *argv[], char *envp[])
{
    printf("starting rust\n");

    /* Get current thread's value */
    _stderr = stderr;
    __errno_location = &errno;

    /* Wait before things might hang up */
    sleep(1);

    rust_main();

    printf("callback returned\n");

    return 0;
}
