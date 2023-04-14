```bash
mkdir build
cd build
cmake ..
make
./gui_example
```

rkt
```bash
racket gui.rkt
raco exe gui.rkt
raco distribute gui-dist gui.exe

```

tcl
```bash
freewrap gui.tcl
tclkit sdx.kit wrap gui.tcl

```