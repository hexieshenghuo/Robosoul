%% ����ѵ��һ��rbf������
%% ˵��
% optX ��Ҫ�Ż���X,��[C;S;W]
% FuncParam: Ŀ�꺯���������
function [ rbf ,varargout] = rbfTrain( rbf,X,Yt,varargin)

   if nargin<4
       % Ĭ��ѵ����ʽ
       FuncParam.X=X;
       FuncParam.Yt=Yt;
       FuncParam.rbf=rbf;
       optX=rbfPackParam(rbf);
       SearchParam=getBackParam();
       SearchParam.lamda=6.6e-06;
       SearchParam.Method='Const';
       GDParam.SearchParam=SearchParam;
       
       [newX,f,g] = GD(@rbfErrorFunOpt,optX,FuncParam,GDParam);
%        disp(g);
       rbf=rbfUnpack(rbf,newX);
       
       if nargout>1
           varargout{1}=f;
       end
       
   else
       % ���ݲ���ѵ��
       
   end
   
end