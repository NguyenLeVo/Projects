format compact
geom=[1 0 0; 
    0 1 0; 
    2.5 -4.3 1] % Geometric Matrix
dynm=[-58.32;-5.77;101.3]       % Dynamic Matrix
geom\dynm                       % Ax=B => x=A\B

