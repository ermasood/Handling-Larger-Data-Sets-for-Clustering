function [accuracy,confm]= accuracy (Z,clust)
clusre=max(Z);
clusgen=max(clust);
No_of_Generated_clusters= clusgen;
No_of_real_clusters= clusre;
   cam=[clusre clusgen];
   matma= zeros(clusre,clusgen);
   for i=1:clusre
   for j=1:clusgen
      ma(i,j)= length(intersect(find(Z==i),find(clust==j)));
       
   end
   end
  compa= min(cam);
  compar=[];
  %compar=[(1:clusre)',(1:clusgen)']
  mat=ma;
  for n=1:compa
[num] = max(mat(:));
 if num==0
     com1 =(1:clusre)';%original clusre
     com2=(1:clusgen)';
     l1=compar(:,1);
     l2=compar(:,2);
     [ucmr,ia1,ib1]=union(l1,com1,'stable');
     [ucmg,ia,ib]=union(l2,com2,'stable') ;
     ucm=zeros(length(ucmr),1);
     for i=1:length(ucmg)
     ucm(i)=ucmg(i);
     end
     %compar=[ucmr ucmg(1:compa)]
     compar=[ucmr(1:compa) ucmg(1:compa)];
     break;
 end
[x,y]= ind2sub(size(mat),find(mat==num));
compar=[compar;[x y]];
%compar([x y],2) = compar([y x],2)
mat(x,:) = zeros(1,length(clusgen)); %reduce the size of the matrix
mat(:,y) = zeros(length(clusre),1);
  end
  
   for i=1:compa
   for j=1:compa
      mna(i,j)= length(intersect(find(Z==compar(i,1)),find(clust==(compar(j,2))))); 
   end
  end
   confm = mna;
accuracy= (sum(diag(mna))*100)/(length(clust));
end