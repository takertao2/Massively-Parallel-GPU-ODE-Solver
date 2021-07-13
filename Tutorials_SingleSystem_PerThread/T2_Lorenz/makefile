INCL_DIR = -I$(HOME)/Massively-Parallel-GPU-ODE-Solver/SourceCodes
CMPL_OPT = -O3 -std=c++11 --ptxas-options=-v --gpu-architecture=sm_35 -lineinfo -maxrregcount=64

all: Lorenz.exe

Lorenz.exe: Lorenz.cu
	nvcc -o	Lorenz.exe Lorenz.cu $(INCL_DIR) $(CMPL_OPT)

clean:
	rm -f Lorenz.exe
	rm -f Lorenz.txt