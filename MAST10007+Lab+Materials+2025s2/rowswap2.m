function B=rowswap2(M,i,j)
    % this function performs a row swap operation on M
    temp=M(i,:);
    M(i,:)=M(j,:);
    M(j,:)=temp;
    B=M;