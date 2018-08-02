%% 创建BSpline的局部线段点集合用于生成时的匹配
%% 
%% 
function [Curve,t] = createLocalBSplineCurve(P,k,dt,t,range)
[Dim,N]=size(P);

T=getT(N,k);
t=getLocalt(T,dt,t,range);
Curve=zeros(Dim,length(t));

for j=1:Dim
     for i=1:N
        Curve(j,:)=Curve(j,:)+P(j,i)*B(t,i,k,T);
    end
end
end

