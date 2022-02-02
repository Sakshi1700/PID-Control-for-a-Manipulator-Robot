clc
clear all;

%open loop tf
num = [0.023];
den = [0.029 0.1543 0.1205 0];
sys = tf(num,den)
spec = stepinfo(sys)
figure
step(sys)

%closed loop tf
num1 = [0.023];
den1 = [0.029 0.1543 0.1205 0.001543];
sys1 = tf(num1,den1)
figure
pzmap(sys1),grid on

%Tuning of controller with kp
t=[0:0.05:100];
kp = 1;
C = pid(kp);
T = feedback(C*sys,kp);
specs_1 = stepinfo(T)
figure
step(10*T,t)

%Nyquist Plot
figure
nyquist(num,den)

%Bode Plot
figure
bode(num,den)

%margins
margin(sys)
[Gm,Pm,Wcg,Wcp] = margin(sys)

%using pid controller
t=[0:0.05:100];
kp = 10;
ki = 0;
kd = 12.867;
C = pid(kp,ki,kd);
T = feedback(C*sys,1);
spec_c2 = stepinfo(T)
figure
step(10*T,t)
syms k