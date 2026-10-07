#define _GNU_SOURCE
#include <dlfcn.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

typedef int (*F_execve)(const char*, char* const[], char* const[]);

F_execve _real_execve;

__attribute__((constructor)) static void initialize(void)
{
  _real_execve = dlsym(RTLD_NEXT, "execve");
  /* Don't pass the preload on to processes spawned by libvirtd (e.g. QEMU) */
  unsetenv("LD_PRELOAD");
}

int execve(const char *pathname, char *const argv[], char *const envp[]) {
  if (strcmp(pathname, "/usr/lib/libvirt/virt-aa-helper") == 0) {
    pathname = "/usr/lib/libvirt/virt-aa-helper-hook";
  }
  return _real_execve(pathname, argv, envp);
}
