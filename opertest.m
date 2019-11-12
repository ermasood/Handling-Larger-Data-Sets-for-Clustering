function [clust,OB,Ac,tit,xax] = opertest(x,z,logval);   
Mdtime=[];
Mdacc=[];
k=0;
A=[];
ConA=[];
AccA=[];
MAPTclust=[];
c=1;

l=length(x);
mat=zeros(l,l);
for i=1:l
for j=1:l
  mat(i,j)= sqrt(sum((x(i,:)-x(j,:)).^2));
end
end
% clustname='MeanShift'
mn=min(min(mat));
mx=max(max(mat));
t=mean(mean(mat));
un=0;
ut=mx;
p=1;
up=t;
ul=t;
tem1=ut;
tem2=un;
conv=[0 0 0];
conv(2)=t;

tic
for r=1:80
    if ut==un
        k=r;
        break;
    end
    conv(1)= mean(mat(find(mat(:)<ul&mat(:)>un)));
    conv(3)= mean(mat(find(mat(:)>up&mat(:)<ut)));
    switch logval
     case 'MeanShift'
        for i=1:3
        [clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(x',conv(i),'false');
        [acc,conf]=accuracy(z,point2cluster);
        A(i)= acc;
        MAPTclust=[MAPTclust;point2cluster];
        tit='MeanShift Clustering'
        xax='Bandwidth'
        end
    otherwise
        for i=1:3
        [C, ptsC, centres] = dbscan(x',conv(i),0);
        [acc,conf]=accuracy(z,ptsC');
        A(i)= acc;
        MAPTclust=[MAPTclust;ptsC];
        tit='DBSCAN Clustering'
        xax='Epsilon'
        end
end

AccA=[AccA A];
ConA=[ConA conv];
if A(1)>60|A(2)>60|A(3)>60
    I =A(1)+(A(1)*0.02);
    D =A(1)-(A(1)*0.02);
else
    I =A(1)+(A(1)*0.12);
    D =A(1)-(A(1)*0.12);
end
if A(1)<I & A(2)<I & A(3)<I & A(1)>D & A(2)>D & A(3)>D 
    if A(1)>60|A(2)>60|A(3)>60
        if c==1
            B=A;
            c=2;
        else
            k=r;
            break;
        end
    end
    ul=conv(1);
    up=conv(3);
    tem1=conv(1);
    tem2=conv(3);
    elseif A(1)>(A(2)+(A(2)*0.01))& A(1)>(A(3)+(A(3)*0.01)) 
        ul=conv(1);
        up=conv(1);
        conv(2)=conv(1);
        ut=tem1;
        tem1=conv(1);
        tem2=ut;
    elseif A(2)>(A(1)+(A(1)*0.01))& A(2)>(A(3)+(A(3)*0.01)) 
        ul=conv(2);
        up=conv(2);
        ut=conv(3);
        un=conv(1);
        tem1=conv(1);
        tem2=conv(3);
    elseif A(3)>(A(1)+(A(1)*0.01))& A(3)>(A(2)+(A(2)*0.01))
        ul=conv(3);
        up=conv(3);
        un=conv(2);
        conv(2)=conv(3);
        tem1=un;
        tem2=ut; 
    else
        if p==1
        B=A;
        p=2;
        ul=conv(1);
        up=conv(3);
        tem1=conv(1);
        tem2=conv(3);
    else
        k=r;
        break;
    end
end
r
end


atime=toc;
Mdtime=[Mdtime atime];
maxa=find(AccA==max(AccA));
clust=MAPTclust(maxa(1),:);
% masoodfigplot(x,MAPTclust(maxa(1),:))
% savefig('Mclust.fig')

t =conv(find(A==max(A)));
OB=t(1);
Number_of_Iterations=k;
[BM I]=sort(ConA,'ascend')
T=AccA(I);
Ac=max(AccA)

end
