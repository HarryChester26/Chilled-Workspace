function [A] = rrefmod2(A)
%REFMOD2   Reduced row echelon form using modulo 2 rithmetic.
%   R = RREFMOD2(A) produces the reduced row echelon form of A.
%
%   See also RREF, RREFMOVIE, RANK, ORTH, NULL, QR, SVD.


[m,n] = size(A);


% Find the initial matrix modulo 2
A=mod(A,2);

% Loop over the entire matrix.
i = 1;
j = 1;
while (i <= m) & (j <= n)
   % Find the index of largest element in the remainder of column j.
   p=0;
   k=i;
   while (k<=m) & (p==0) 
       p=A(k,j);
       k=k+1;
   end
   k=k-1;
if (p==0)
      % The column is all zeros below pivot element.
       j = j + 1;
   else
       % Swap i-th and k-th rows.
         A([i k],j:n) = A([k i],j:n);
      % Subtract the pivot row from all the other rows.
      % for k = [1:i-1 i+1:m]
      for l = [1:i-1 i+1:m]
          if A(l,j)==1
         A(l,1:n) = mod((A(l,1:n) - A(i,1:n)),2);
        end
      end
       i = i + 1;
      j = j + 1;
  end
end

