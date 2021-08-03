function odev5(i1, i2)
    %image which will be copied
    I2=imread(i2);
    %base-background image
    I1=imread(i1);
    [M,N,~]=size(I1);
    I2=imresize(I2,[M N]);
    figure
    imshow(I2);

    figure
    imshow(I1);
    [x,y] = ginput(4);

    Y=ceil(y);
    X=ceil(x);
    %define square matrix A which helps us to find h
    A=[1 1 1 0 0 0 -1*1*X(1) -1*1*X(1); 0 0 0 1 1 1 -1*1*Y(1) -1*1*Y(1);
       1 N 1 0 0 0 -1*1*X(2) -1*N*X(2); 0 0 0 1 N 1 -1*1*Y(2) -1*N*Y(2);
       M 1 1 0 0 0 -1*M*X(3) -1*1*X(3); 0 0 0 M 1 1 -1*M*Y(3) -1*1*Y(3);
       M N 1 0 0 0 -1*M*X(4) -1*N*X(4); 0 0 0 M N 1 -1*M*Y(4) -1*N*Y(4)
      ];

    %define b which consist of input points
    b=[X(1); Y(1); X(2); Y(2); X(3); Y(3); X(4); Y(4)];

    d=det(A);
    %check if A is invertible then find h
    if d~=0
        h=A\b;
    else
        [U, S, V]=svd(A);
        h = V(:, end);
    end

    %convert vector h to matrix H
    H=[h(1) h(2) h(3); h(4) h(5) h(6); h(7) h(8) 1];

    for i=1:M
        for j=1:N
            a=H(1,1)*i+ H(1,2)*j+ H(1,3)*1;
            v=H(2,1)*i+ H(2,2)*j+ H(2,3)*1;
            c=H(3,1)*i+ H(3,2)*j+ H(3,3)*1;
            %normalization
            a=ceil(a/c);
            v=ceil(v/c);
            c=1;
            I1(v,a,:)=I2(i,j,:);
        end
    end

    figure
    imshow(uint8(I1));
end
