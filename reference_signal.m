function output = reference_signal(input)

t = input;

% % Earlier (open loop, no MPC block) I was using this block/function to 
% % provide direct control input. After adding MPC, this block provides the
% % reference value that the plant output (here y = lateral position) should
% % track. So dimension is just 1.
% f = 0.03;
% 
% del_f = sin(2*pi*f*t);
% del_r = 0.33*sin(2*pi*f*t);
% % del_r = 0;
% 
% output = [del_f, del_r];
% % output = [del_f; del_r];


% % Now (after adding MPC, closed loop system), only single referece signal
% % for lateral position being provided
% output = [  1, 1, 1, 1;
%             2, 2, 2, 2];
% output = -10;
% output = [-10, -10, -10, -10];
% output = [-10, -10];
f1 = 0.03;
f2 = 0.015;
ref_lat = sin(2*pi*f1*t);
ref_yaw = 0.5*sin(2*pi*f2*t);

output = [ref_lat, ref_yaw];

end