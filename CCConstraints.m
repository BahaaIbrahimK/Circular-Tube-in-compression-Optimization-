function [c, ceq] = CCConstraints(x)
P = 10000; 
L = 1000;
E = 72000;
sigma_c = 300; 
K=0.605;
I=pi*x(1)^3*x(2);
P_E=pi^2*E*I/L^2;
A=2*pi*x(1)*x(2);
sigma_E=P_E/A;
sigma_L=K*E*x(2)/x(1);  %Circular
c = [(P/A)-sigma_c;...
    (P/A)-sigma_E
    %(P/A)-sigma_L
    ];
display(sigma_E);
ceq = [];