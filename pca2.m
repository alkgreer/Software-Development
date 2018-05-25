function [U_k,lamda_k]=PCA(X,k)
%
% PCA
%
% INPUTS:
%  X: n x d data
%  k: Size of dimensions for features
%
% OUTPUTS:
%  U_k: eigenvectors 
%  lamda_k: eigenvalues
[n d]=size(X);

%center X
X=X-ones(n,1)*mean(X);

C=X'*X/n;

[U lamda]=eig(C);

[tmp ind]=sort(diag(lamda),'descend');

U_k=U(:,ind(1:k));
lamda_k=lamda(ind(1:k),ind(1:k));