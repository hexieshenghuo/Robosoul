%% ���DataVectors��һ�����ݿ���
%% ˵����
% Database��һ����ά��cellÿһ��cell��һ��DataVectors cell
% Database{d,n} d��DataVectors������ά��D,n��DataVectors�任��N
%%
function [Database,varargout] = addDataVectors2Database(Database,DataVectors,D,N,varargin)
   srcDataVectors=Database{D,N};
   dstDataVectors=combineDataVectors(srcDataVectors,DataVectors);
   Database{D,N}=dstDataVectors;
end