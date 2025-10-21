# GW-OS
Credit to [Cfenollosa's work on os-tutorial](https://github.com/cfenollosa/os-tutorial/). Thanks
# Build & Run
## Install Requirements
The software you need to install is: **qemu & nasm** <br>
To install them in linux run
```bash
sudo apt install qemu nasm
```
## Building and running
Run in the root of the repo:
```bash
chmod +x ./run.sh
./run.sh
```
or in **`src`** you run:
```bash
make run
```
> **Note:** I am still working on cross platform compiling so these may change fast although I will try to keep it the same 