function [nums]= arraydivider (length,n)
a=length/n
b=int32(a)
nums=1;
for i=1:n-1
nums=[nums  i*b];
end
nums=[nums length];
end