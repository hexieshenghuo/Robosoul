%% 根据参数生成仿射矩阵集合 类型为cell
% 参考: [1] ASIFT:A New Framework for Fully Affine Invariant Image Comparison
%       [2] Fast keypoint recognition using random ferns
% rangeLamda: λ的范围向量 如 1:0.5:6
% rangeT:     t的范围向量 如上
% rangePsi:   ψ的范围向量：如上
% rangePhi:   φ的范围矩阵如上
% TSet：变换矩阵集 cell型
%% 
function [TSet] = getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi)
   lL=length(RangeLamda);
   lT=length(RangeT);
   lPsi=length(RangePsi);
   lPhi=length(RangePhi);
   
   TSet=cell(lL*lT*lPsi*lPhi,1);
   n=1;%TSet的索引
   for lamda=RangeLamda
       for t=RangeT
           for psi=RangePsi
               for phi=RangePhi
                  TSet{n}=makeAffineMat(lamda,t,psi,phi);
                  n=n+1;
               end
           end
       end
   end
end

