  :Comment :
:Reference : :		Kole,Hallermann,and Stuart, J. Neurosci. 2006

NEURON	{
	SUFFIX Ih_me
	NONSPECIFIC_CURRENT ihcn
	RANGE gIhbar, gIh, ihcn 
}

UNITS	{
	(S) = (siemens)
	(mV) = (millivolt)
	(mA) = (milliamp)
}

PARAMETER	{
	gIhbar = 0.00001 (S/cm2) 
	ehcn =  -49.765 (mV)
	vh= -90.963
	k= 8.0775
	a= 23.428
	b= 0.21756
	c= 1.3881e-09
	d= 0.082329
	e= 1.9419e-09

a_Ih=23.428
b_Ih=0.21756
c_Ih=1.3881e-09
d_Ih=0.082329
e_Ih=1.9419e-09
k_Ih=8.0775
vh_Ih=-90.963
ehcn_Ih=-49.765

}


ASSIGNED	{
	v	(mV)
	ihcn	(mA/cm2)
	gIh	(S/cm2)
	mInf
	mTau
	mAlpha
	mBeta
}

STATE	{ 
	m
}

BREAKPOINT	{
	SOLVE states METHOD cnexp
	gIh = gIhbar*m
	ihcn = gIh*(v-ehcn)
}

DERIVATIVE states	{
	rates()
	m' = (mInf-m)/mTau
}

INITIAL{
	rates()
	m = mInf
}

PROCEDURE rates(){
	UNITSOFF
		mInf=1/(1+exp((v-vh)/k))
		mTau=1/(exp(-a-b*v)+exp(-c+d*v))+e
	UNITSON
}
