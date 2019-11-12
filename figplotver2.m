function figplot(X,idx)
t=max(idx)
range = min(idx):max(idx);
res = [range; histc(idx(:)', range)]'; % res has values in first column, counts in second.
sortedres = sortrows(res, 2)
cVec = 'brkc';
mrk='<*so'
figure;
k=4;
for i=1:t
    if (i>t-4)                                                              
        k=t-i+1;
    else
        k=4;
    end
    plot(X(idx==sortedres(i),1),X(idx==sortedres(i),2),'Color',cVec(k),'Linewidth',0.5,'LineStyle','none','Marker',mrk(k),'MarkerSize',4)
%scatter(X(idx==sortedres(i),1),X(idx==sortedres(i),2),12,'filled')
hold on
end
xlabel('Dim 1')
ylabel('Dim 2')

%title('Clustering Results at OPT Optimised Parameters')
f=get(gca,'Children');
legend([f(1),f(2),f(3),f(4)],'Cluster 1','Cluster 2','Cluster 3','Unclustered')
set(gca,'FontSize',16)
% set(gcf, 'Position', [300, 10, 500, 500])

hold off
ax1=gca
axis(ax1,[-0.03 0.05 -0.035 0.05])
end