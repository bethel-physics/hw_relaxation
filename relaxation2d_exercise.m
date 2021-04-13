%% Set up parameters

N = 50;                 % Number of grid points = 51
L = 1.0;                % Length of domain
h = L/N;                % Space grid size
x=zeros(N+1); 
y=zeros(N+1);
for j = 1:N+1
    for i = 1:N+1
        x(i,j) = -L/2+(i-1)*h;
        y(i,j) = -L/2+(j-1)*h;
    end
end

a = zeros(N+1);  
% SET the fixed outer boundary conditions in a
%-------------------------------------------------
a(1,:) = 1;
a(N+1,:) = 1;
a(:,1) = 0;
a(:,N+1) = 0;

newa = a; % copy used for Jacobi method

%% Homework: Implement ID = 1 and BC = value on inner boundaries
%-------------------------------------------------

%ID = 
%BC = 

%-------------------------------------------------

% Choose a method
imethod = input('Enter method (1=Jacobi), (2=Gauss Seidel), (3=SOR): ');
if(imethod==3)
    omega = input('Enter desired omega: ');
end

%%%%%%%%%%%%
%% Run the loop

mesh(x,y,a,a); 
axis([-.5 .5 -.5 .5 0 1])

iter=0;
change = 1000;
while(abs(change) > 1e-4)
    changeSum = 0;
    iter = iter + 1;

    if(imethod == 1)           % Jacobi method
        % IMPLEMENT a NESTED FOR LOOP
        
        
                %newa(i,j) = ADD JACOBI UPDATE HERE

                changeSum = changeSum + abs(1-a(i,j)/(newa(i,j)+1e-6));
 
        %a =       % copy new guess onto the old guess at the end
    elseif(imethod == 2)       % Gauss-Seidel
        % IMPLEMENT a NESTED FOR LOOP
        
        
                %newval = ADD GAUSS-SEIDEL UPDATE HERE
                
                changeSum = changeSum + abs(1-a(i,j)/newval);                
                a(i,j) = newval; % copy new guess to old guess right away
                
                
    else                       % Successive Overrelaxation
        % IMPLEMENT NESTED FOR LOOP
            
        
                %newval = ADD SOR UPDATE HERE
                
                changeSum = changeSum + abs(1-a(i,j)/newval);                
                a(i,j) = newval; % copy new guess to old guess right away

                
    end
    
    change = changeSum/(N-2)^2;    
    cla
    mesh(x,y,a,a);
    pause(.01)
end
