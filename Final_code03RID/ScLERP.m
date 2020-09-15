function [G,result] = ScLERP( p,q, dt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p_conj = DQConjugate(p);
prod = DualQMult(p_conj,q);
s = DualQMult(p,p_conj);
% [P1 P2] = DualQuaternionAngFormat(p,t)

%%
%%For ScLerp
% ScLERP(p,q,t) = p(p*q)^t
%Let (p*q)^t = r
% P3 = [];
% P4 = [];
result = [];
k = 1;
j = 1;
t = 0;

G = [0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];
while t <= 1
    
 r = DualQuaternionAngFormat(prod,t);
 result(k,1:8)  = DualQMult(p,r);
 G(:,:,k) = DQuaternionToMatrix(result(k,1:8));
 %plot3(G(1,4,k),G(2,4,k),G(3,4,k), '*k');
  k = k+1;
  t = t+dt;
end


end

