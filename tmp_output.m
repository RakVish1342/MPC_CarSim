%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Proper use of tf(), sys(), ss()


nr = [1]

nr =

     1

dr = [1, -1]

dr =

     1    -1




thesys = tf(nr, dr)

thesys =
 
    1
  -----
  s - 1
 
Continuous-time transfer function.

bode(thesys)
dr = [1, 1]

dr =

     1     1

thesys = tf(nr, dr)

thesys =
 
    1
  -----
  s + 1
 
Continuous-time transfer function.



bode(thesys)


dr = [1, 1]

dr =

     1     1



thesys = tf(nr, dr)

thesys =
 
    1
  -----
  s + 1
 
Continuous-time transfer function.

bode(thesys)
thesys1 = tf(nr, dr)

thesys1 =
 
    1
  -----
  s + 1
 
Continuous-time transfer function.



dr = [1, -1]

dr =

     1    -1

thesys2 = tf(nr, dr)

thesys2 =
 
    1
  -----
  s - 1
 
Continuous-time transfer function.

thesys1

thesys1 =
 
    1
  -----
  s + 1
 
Continuous-time transfer function.

thesys2

thesys2 =
 
    1
  -----
  s - 1
 
Continuous-time transfer function.




H = [thesys1, thesys2]

H =
 
  From input 1 to output:
    1
  -----
  s + 1
 
  From input 2 to output:
    1
  -----
  s - 1
 
Continuous-time transfer function.

bode(H)
Error using matlab.graphics.axis.Axes/set
Value must be a 1x2 vector of numeric type in which the second element is larger than the first and may be Inf

Error in ctrluis.axesgroup/generic_listeners>LocalPreUnitTranform (line 216)
         set(PlotAxes(ct,:),'Ylim',Ylim)
 
Warning: Error occurred while evaluating listener callback. 
> In resppack.bodeplot.editUnits>localWriteProp (line 52)
  In ctrluis.axesgrid.editUnits>localWriteProp (line 212) 




bode(H)



margin(H)
Error using DynamicSystem/margin (line 44)
MARGIN requires a SISO model.
 
margin(thesys1)




step(H)



impulse(H)



G_sym = poly2sym(cell2mat(num),s)/poly2sym(cell2mat(den),s)
Unrecognized function or variable 'num'.
 
Did you mean:
G_sym = poly2sym(cell2mat(sum),s)/poly2sym(cell2mat(dr),s)



 G_sym = poly2sym(cell2mat(num),s)/poly2sym(cell2mat(den),s)
Unrecognized function or variable 'num'.
 
Did you mean:
 G_sym = poly2sym(cell2mat(nr),s)/poly2sym(cell2mat(dr),s)
Brace indexing is not supported for variables of this type.

Error in cell2mat (line 36)
    if isnumeric(c{1}) || ischar(c{1}) || islogical(c{1}) || isstruct(c{1})
 
nr

nr =

     1

dr

dr =

     1    -1

G_sym = poly2sym(nr,s)/poly2sym(dr,s)
Unrecognized function or variable 's'.
 
syms s
G_sym = poly2sym(nr,s)/poly2sym(dr,s)
 
G_sym =
 
1/(s - 1)
 



ilaplace(G_sym)
 
ans =
 
exp(t)
 
initial(sys)
Error using DynamicSystem/initial (line 84)
The initial condition X0 is required for simulating the unforced response of a linear system.
 
initial(sys, 10)
Error using DynamicSystem/initial (line 84)
The length of the initial condition X0 must match the number of states.
 
thesys

thesys =
 
    1
  -----
  s + 1
 
Continuous-time transfer function.

initial(thesys1, 10)
Error using DynamicSystem/initial (line 84)
Initial condition responses are only supported for state-space models.
 
thess1 = tf2ss(thesys1)
Error using tf2ss (line 33)
Not enough input arguments.
 
thesys1

thesys1 =
 
    1
  -----
  s + 1
 
Continuous-time transfer function.

tfdata(thesys1)

ans =

  1×1 cell array

    {1×2 double}

tf2ss(tfdata(thesys1))
Error using tf2ss (line 33)
Not enough input arguments.
 


ssdata(thesys1)

ans =

    -1

ssdata(thesys2)

ans =

     1

ssdata(thesys2)

ans =

     1





initial(ssdata(thesys2), 10)
Error using initial (line 72)
Not enough input arguments.
 
initial(ssdata(thesys2))
Error using initial (line 72)
Not enough input arguments.
 
ssdata(thesys2)

ans =

     1

initial( ss(ssdata(thesys2)) )
Error using DynamicSystem/initial (line 84)
The initial condition X0 is required for simulating the unforced response of a linear system.
 
initial( ss(ssdata(thesys2)), 10 )
Error using DynamicSystem/initial (line 84)
The length of the initial condition X0 must match the number of states.
 
initial( ss(ssdata(thesys2)),  )
ss(ssdata(thesys2)
 ss(ssdata(thesys2)
                   ?
Error: Invalid expression. When calling a function or indexing a variable, use parentheses. Otherwise, check for mismatched delimiters.
 
Did you mean:
ss(ssdata(thesys2))

ans =
 
  D = 
       u1
   y1   1
 
Static gain.

ssdata(thesys2)

ans =

     1

[a,b,c,d] = ssdata(thesys2)

a =

     1


b =

     1


c =

     1


d =

     0





ss(a,b,c,d)

ans =
 
  A = 
       x1
   x1   1
 
  B = 
       u1
   x1   1
 
  C = 
       x1
   y1   1
 
  D = 
       u1
   y1   0
 
Continuous-time state-space model.

initial(ss(a,b,c,d), 10)
ss(-1,b,c,d)

ans =
 
  A = 
       x1
   x1  -1
 
  B = 
       u1
   x1   1
 
  C = 
       x1
   y1   1
 
  D = 
       u1
   y1   0
 
Continuous-time state-space model.

initial(ss(a,b,c,d), 10)



ss(-1,b,c,d)

ans =
 
  A = 
       x1
   x1  -1
 
  B = 
       u1
   x1   1
 
  C = 
       x1
   y1   1
 
  D = 
       u1
   y1   0
 
Continuous-time state-space model.

ss(1,b,c,d)

ans =
 
  A = 
       x1
   x1   1
 
  B = 
       u1
   x1   1
 
  C = 
       x1
   y1   1
 
  D = 
       u1
   y1   0
 
Continuous-time state-space model.

initial(ss(1,b,c,d), 10)
initial(ss(-1,b,c,d), 10)
initial(ss(1,b,c,d), 10)
initial(ss(1,b,c,d), 0)
initial(ss(-1,b,c,d), 0)
initial(ss(-1,b,c,d), 10)
initial(ss(1,b,c,d), 10)
initial(ss(1,b,c,d), 1)
initial(ss(1,b,c,d), 0.00001)
initial(ss(1,b,c,d), 0.000000001)
initial(ss(1,b,c,d), 0.0000000000000001)




A

A =

   -0.1760   -0.9542
    3.7810  -25.5598

chol(A)
Error using chol
Matrix must be positive definite.
 
[~,p] = chol(A)

p =

     1

aa = [1,0; 0, 1]

aa =

     1     0
     0     1


[~,p] = chol(aa)

p =

     0

[x,p] = chol(aa)

x =

     1     0
     0     1


p =

     0

aaa = -aa

aaa =

    -1     0
     0    -1

[~,p] = chol(aaa)

p =

     1

[x,p] = chol(aaa)

x =

     []


p =

     1




aaaa = [-1, 0; 0, 1]

aaaa =

    -1     0
     0     1



[x,p] = chol(aaaa)

x =

     []


p =

     1

eig(aaaa)

ans =

    -1
     1

aaaa

aaaa =

    -1     0
     0     1

aaaaa = [-1, 1; 1, 1]

aaaaa =

    -1     1
     1     1

eig(aaaaa)

ans =

   -1.4142
    1.4142

[x,p] = chol(aaaaa)

x =

     []


p =

     1

aaaaaa = [1, 2; 1, 1]

aaaaaa =

     1     2
     1     1

eig(aaaaaa)

ans =

    2.4142
   -0.4142

[x,p] = chol(aaaaaa)

x =

     1


p =

     2

aaaaa

aaaaa =

    -1     1
     1     1

[x,p] = chol(aaaaa)

x =

     []


p =

     1

det(aaaaa)

ans =

    -2

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output for sigma plots, to see if sigma plots always give sig_max and
% sig_min plots or is it one for each output?
% It's always two plots as long as num of ip and num of op is >= 2





tf([1],[1,-1])

ans =
 
    1
  -----
  s - 1
 
Continuous-time transfer function.

t = tf([1],[1,-1])

t =
 
    1
  -----
  s - 1
 
Continuous-time transfer function.

t

t =
 
    1
  -----
  s - 1
 
Continuous-time transfer function.






bode(t)


sigma(t)
bode(t)
allmargin(t)

ans = 

  struct with fields:

     GainMargin: 1
    GMFrequency: 0
    PhaseMargin: 0
    PMFrequency: 0
    DelayMargin: 0
    DMFrequency: 0
         Stable: 0

sigma(t)
H = [0, tf([3 0],[1 1 10]) ; tf([1 1],[1 5]), tf(2,[1 6])];
subplot(211)
sigma(H)
subplot(212)
sigma(H,[],2)





sigma(t, 1)
sigma(t)
sigma(t, 1)
sigma(t, [], 1)
sigma(t, [], 2)
sigma(t, [], 3)


HH = H

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
Continuous-time transfer function.

HH

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
Continuous-time transfer function.

HH(1,2)

ans =
 
      3 s
  ------------
  s^2 + s + 10
 
Continuous-time transfer function.

HH(1,3) = tf([1], [1,-1])

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
  From input 3 to output...
         1
   1:  -----
       s - 1
 
   2:  0
 
Continuous-time transfer function.

HH(2,3) = tf([1], [1,1])

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
  From input 3 to output...
         1
   1:  -----
       s - 1
 
         1
   2:  -----
       s + 1
 
Continuous-time transfer function.




size(H)
Transfer function with 2 outputs and 2 inputs.


shape(H)
Unrecognized function or variable 'shape'.
 
Did you mean:
reshape(H)


bode(H)
sigma(H)
HH(2,2)

ans =
 
    2
  -----
  s + 6
 
Continuous-time transfer function.

HH(2,3) = tf([4], [4,-1])

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
  From input 3 to output...
         1
   1:  -----
       s - 1
 
          4
   2:  -------
       4 s - 1
 
Continuous-time transfer function.

HH(2,3) = tf([1], [1,1])

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
  From input 3 to output...
         1
   1:  -----
       s - 1
 
         1
   2:  -----
       s + 1
 
Continuous-time transfer function.

HH(3,1) = tf([4], [4,-1])

HH =
 
  From input 1 to output...
   1:  0
 
       s + 1
   2:  -----
       s + 5
 
          4
   3:  -------
       4 s - 1
 
  From input 2 to output...
           3 s
   1:  ------------
       s^2 + s + 10
 
         2
   2:  -----
       s + 6
 
   3:  0
 
  From input 3 to output...
         1
   1:  -----
       s - 1
 
         1
   2:  -----
       s + 1
 
   3:  0
 
Continuous-time transfer function.



sigma(H)
size(HH)
Transfer function with 3 outputs and 3 inputs.

