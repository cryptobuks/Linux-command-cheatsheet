## Freqtrade installation problem on Fedora Linux

```
gcc: fatal error: cannot execute ‘cc1plus’: execvp: No such file or directory
      compilation terminated.
      error: command '/usr/bin/gcc' failed with exit code 1
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed building wheel for py_find_1st
Failed to build blosc py_find_1st
ERROR: Could not build wheels for blosc, py_find_1st, which is required to install pyproject.toml-based projects
Failed installing dependencies
```

**Oplossing:**

Installeer: `sudo dnf install gcc-c++ python-devel`
