%% ���BSpline���ߵ�Ŀ�꺯��
%% ˵��
% Y=Data.Y �����������
% Dim=Data.Dim;����ά��
% N=Data.N; �����Ƶ���
% k=Data.k; ����ϳ�BSpline�ľ���
% Points=vector2Points(X,Dim,N);
% dtm=Data.dtm; ��Ѱ�һ������������ļ��,ԽСԽ��ȷ��Ӱ���ٶ�
% f: ����ֵ
% g: �����ݶ�
%%
function [ f,g ] = fitObjFunc(X,Data,varargin)
%------��ʼ��
   Y=Data.Y;
   Dim=Data.Dim;
   N=Data.N;
   k=Data.k;
   Points=vector2Points(X,Dim,N);
   dtm=Data.dtm;
   
%------����Y��Ӧ��tm
   [tm] = findArcRatiotm(Y,Points,k,dtm);
   
%------����f
   bsplineC=createBSplineCurve(Points,k,0.01,tm);
   dC=Y-bsplineC;
   M=length(dC);
   f=0;
   
   % ����������ʽ������ 
%    for m=1:M
%         f=f+norm(dC(m))^2; %����ۼ�
%    end
   f=norm(dC)^2; % ������ʽ
   
   f=f/2;
%------����g
   T=getT(N,k);
   for n=1:N
       BI(n,:)=B(tm,n,k,T);% BIΪN��M����ÿ��Ϊһ����Pi��Ӧ�������溯��
   end
   
   df_dP=zeros(Dim,N);
   
   for n=2:N-1
       for i=1:Dim %���ά��
           df_dP(i,n)=sum(-dC(i,:).*BI(n,:));
       end
   end
   % ת��Ϊ����
   g=points2Vector(df_dP);
end