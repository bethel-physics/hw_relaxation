clear
close all
% Simple program for solving Laplace's
%    equation with relaxation methods.

%%%%%%%%%%%%
%% Set up parameters

Nx = 50;                 % Number of grid points = 51
Ny = 50;                 % Number of grid points = 51

L = 1.0;                % Length of domain
h = L/N;                % Space grid size
x=zeros(N+1); 
y=zeros(N+1);
for j=1:N+1
    for i=1:N+1
        x(i,j)=-L/2+(i-1)*h;
        y(i,j)=-L/2+(j-1)*h;
    end
end

a=zeros(N+1);  newa=a; % copy used for Jacobi method
ID=zeros(N+1);
BC=zeros(N+1);

%% Implement ID = 1 and BC = value on boundaries


imethod = input('Enter method (1=Jacobi), (2=Gauss Seidel), (3=SOR): ');
if(imethod==3)
    omega = input('Enter desired omega: ');
end

%%%%%%%%%%%%
%% Run the loop

mesh(x,y,a,a); axis([-.5 .5 -.5 .5 0 1])
pause;
iter=0;
change = 1000;
while(abs(change) < 1e-4)
    changeSum = 0;
    iter = iter + 1;
    if(imethod == 1)           % Jacobi method
        for j=2:N
            for i=2:N
                %newa(i,j) = ADD JACOBI UPDATE HERE
                changeSum = changeSum + abs(1-a(i,j)/(newa(i,j)+1e-6));
            end
        end
        a(2:N,2:N) = newa(2:N,2:N);  % copy new guess to old guess
    elseif(imethod == 2)       % Gauss-Seidel
        for j=2:N
            for i=2:N
                %newa = ADD GAUSS-SEIDEL UPDATE HERE
                changeSum = changeSum + abs(1-a(i,j)/newa);                
                a(i,j) = newa; % copy new guess to old guess at each pt
            end
        end
    else                       % Successive Overrelaxation
        for j=2:N
            for i=2:N
                %newa = ADD SOR UPDATE HERE
                changeSum = changeSum + abs(1-a(i,j)/newa);                
                a(i,j) = newa; % copy new guess to old guess at each pt
            end
        end
    end
    change = changeSum/(N-2)^2;    
    cla
    mesh(x,y,a,a);
    pause(.01)
end
