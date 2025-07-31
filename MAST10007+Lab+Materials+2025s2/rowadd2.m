function B=rowadd2(M,c,i,j)
    %this function performs an add-a-multiple-of-a-row operation on M
    if(i==j)
        error('you cannot add a multiple of a row to itself')
    end
    M(j,:)=M(j,:)+c*M(i,:);
    B=M;