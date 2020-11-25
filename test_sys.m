function out = test_sys(in)

global A B C D

sys = ss(A, B, C, D);

out = sys;

end
