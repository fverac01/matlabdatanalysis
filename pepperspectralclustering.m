sigsq = 10;

load('Ncut_Data.mat');
pepperorig = pepper;
pepper = reshape(pepper,[3100,1]);

wm = zeros(3100);

for i = 1:3100
    for j = 1:3100
        wm(i,j) = weight(pepper(i,:),pepper(j,:) );
    end
end

L = zeros(100);

for j = 1:3100
    L(j,j) = sum( wm(j,:) );
end
            
L = L - wm;

[vecs,vals] = eig(L);

important = vecs(:,2);

for i = 1:3100
    if (important(i) < 0)
        pepper(i) = 0;
    else 
        pepper(i) = 1;
    end
end

pepperfin = reshape(pepper,[100,31]);
imshow(pepperfin);






function ret = weight(xi,xj)
sigsq = .1;
temp = -(norm(xi-xj)^2)/sigsq;
ret = exp(temp);
end