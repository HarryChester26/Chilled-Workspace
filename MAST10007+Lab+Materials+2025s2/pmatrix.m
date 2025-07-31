function P = pmatrix
A = [3 1 0; 5 0 1]';
P = A*inv(A'*A)*A';