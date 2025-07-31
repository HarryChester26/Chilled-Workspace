function houseanimation(A)
x=house+9;       % displaces house by (+9, +9) from the origin
hold off;        % tells MATLAB to replace each plot by the next
plot2dd(x);      % does an initial plot of the house

for i=1:100
    x = A*x;     % applies the transformation with matrix representation A
    plot2dd(x)   % plots the transformed house
    pause(0.03)  % waits for 0.03 seconds, then repeats
end