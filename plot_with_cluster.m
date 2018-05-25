function plot_with_cluster(h,x,y,a,b)
%
% plot X with different color for each cluster
%
% INPUT:
%  x: n x d data
%  y: n x 1 vector.

color=['b+';'ko';'ro';'go';'bo';'k+';'r+';'g+';];


k=unique(y);
for i=k'
    plot(h,x(y==i,a),x(y==i,b),color(rem(i,8)+1,:));
    hold on
end
hold off
