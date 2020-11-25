% %%
% %
% % basic MIMO TFM to SS
% %
% G=tf({1 1;1 [1 -2]},{[1 2] [1 2];[1 -2] [1 3 2]});
% 
% % find residue matrices of the 3 poles
% R1=tf([1 1],1)*G;R1=minreal(R1);R1=evalfr(R1,-1)
% R2=tf([1 2],1)*G;R2=minreal(R2);R2=evalfr(R2,-2)
% R3=tf([1 -2],1)*G;R3=minreal(R3);R3=evalfr(R3,2)
% 
% % form SS model for 3 poles using the residue matrices
% A1=[-1];B1=R1(2,:);C1=[0 1]';
% A2=[-2 0;0 -2];B2=R2;C2=eye(2);
% A3=[2];B3=R3(2,:);C3=[0 1]';
% 
% % combine submodels
% A=zeros(4);A(1:1,1:1)=A1;A(2:3,2:3)=A2;A(4,4)=A3;
% B=[B1;B2;B3];
% C=[C1 C2 C3];
% 
% syms s
% Gn=simplify(C*inv(s*eye(4)-A)*B);
% 
% % alternative is to make a SS model of each g {ij}
% A11=-2;B11=1;C11=1;
% A12=-2;B12=1;C12=1;
% A21=2;B21=1;C21=1;
% A22=[-3 -2;1 0];B22=[2 0]';C22=[0.5 -1];
% 
% % and then combine
% AA=zeros(5);AA(1,1)=A11;AA(2,2)=A12;AA(3,3)=A21;AA(4:5,4:5)=A22;
% BB=[B11 B11*0;B12*0 B12;B21 B21*0;B22*0 B22];
% CC=[C11 C12 zeros(1,3);zeros(1,2) C21 C22];
% GGn=simplify(CC*inv(s*eye(5)-AA)*BB);
% 
% Gn,GGn

%%

A = [-1, 0; 0, -1]
B = [1 0; 0 1]
C = [-1 1; 1 1]
D = [1 0; 0 0 ]


tzero(sys)

mat = [tzero(sys)*eye(size(A))-A, -B; C, D]

null(mat)

H = tf(sys)

rank(mat)

eig(A)


