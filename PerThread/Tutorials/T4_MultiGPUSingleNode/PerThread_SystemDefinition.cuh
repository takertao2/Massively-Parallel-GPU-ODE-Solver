#ifndef PERTHREAD_SYSTEMDEFINITION_H
#define PERTHREAD_SYSTEMDEFINITION_H

// SYSTEM

__device__ void PerThread_OdeFunction(int tid, int NT, double* F, double* X, double T, double* cPAR, double* sPAR, double* ACC)
{
	int i0 = tid + 0*NT;
	int i1 = tid + 1*NT;
	
	double x1 = X[i0];
	double x2 = X[i1];
	
	double p1 = cPAR[i0];
	double p2 = sPAR[0];
	
	F[i0] = x2;
	F[i1] = x1 - x1*x1*x1 - p1*x2 + p2*cos(T);
}

__device__ void PerThread_OdeProperties(double* RelativeTolerance, double* AbsoluteTolerance, double& MaximumTimeStep, double& MinimumTimeStep, double& TimeStepGrowLimit, double& TimeStepShrinkLimit)
{
	RelativeTolerance[0] = 1e-9;
	RelativeTolerance[1] = 1e-9;
	
	AbsoluteTolerance[0] = 1e-9;
	AbsoluteTolerance[1] = 1e-9;
	
	MaximumTimeStep     = 1.0e6;
	MinimumTimeStep     = 2.0e-12;
	TimeStepGrowLimit   = 5.0;
	TimeStepShrinkLimit = 0.1;
}

// EVENTS

__device__ void PerThread_EventFunction(int tid, int NT, double* EF, double* X, double T, double* cPAR, double* sPAR, double* ACC)
{
	int i0 = tid + 0*NT;
	int i1 = tid + 1*NT;
	
	double x1 = X[i0];
	double x2 = X[i1];
	
	EF[i0] = x2;
	EF[i1] = x1;
}

__device__ void PerThread_EventProperties(int* EventDirection, double* EventTolerance, int* EventStopCounter, int& MaxStepInsideEvent)
{
	EventDirection[0]   = -1;
	EventDirection[1]   =  0;
	
	EventTolerance[0]   = 1e-6;
	EventTolerance[1]   = 1e-6;
	
	EventStopCounter[0] = 0;
	EventStopCounter[1] = 0;
	
	MaxStepInsideEvent  = 50;
}

__device__ void PerThread_ActionAfterEventDetection(int tid, int NT, int IDX, int CNT, double &T, double &dT, double* TD, double* X, double* cPAR, double* sPAR, double* ACC)
{
	int i0 = tid + 0*NT;
	int i1 = tid + 1*NT;
	
	double x1 = X[i0];
	double x2 = X[i1];
	
	if ( x1>ACC[i0] )
		ACC[i0] = x1;
	
	if ( (IDX==1) && (CNT==2) )
		ACC[i1] = x2;
}

// ACCESSORIES

__device__ void PerThread_ActionAfterSuccessfulTimeStep(int tid, int NT, double T, double dT, double* TD, double* X, double* cPAR, double* sPAR, double* ACC)
{
	int i0 = tid + 0*NT;
	int i2 = tid + 2*NT;
	
	double x1 = X[i0];
	
	if ( x1>ACC[i2] )
		ACC[i2] = x1;
}

__device__ void PerThread_Initialization(int tid, int NT, double T, double &dT, double* TD, double* X, double* cPAR, double* sPAR, double* ACC)
{
	int i0 = tid + 0*NT;
	int i1 = tid + 1*NT;
	int i2 = tid + 2*NT;
	int i3 = tid + 3*NT;
	
	double x1 = X[i0];
	double x2 = X[i1];
	
	ACC[i0] = x1;
	ACC[i1] = x2;
	ACC[i2] = x1;
	
	dT = ACC[i3];
}

__device__ void PerThread_Finalization(int tid, int NT, double T, double dT, double* TD, double* X, double* cPAR, double* sPAR, double* ACC)
{
	int i3 = tid + 3*NT;
	
	ACC[i3] = dT;
}

#endif