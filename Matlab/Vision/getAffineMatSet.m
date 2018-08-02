%% ���ݲ������ɷ�����󼯺� ����Ϊcell
% �ο�: [1] ASIFT:A New Framework for Fully Affine Invariant Image Comparison
%       [2] Fast keypoint recognition using random ferns
% rangeLamda: �˵ķ�Χ���� �� 1:0.5:6
% rangeT:     t�ķ�Χ���� ����
% rangePsi:   �׵ķ�Χ����������
% rangePhi:   �յķ�Χ��������
% TSet���任���� cell��
%% 
function [TSet] = getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi)
   lL=length(RangeLamda);
   lT=length(RangeT);
   lPsi=length(RangePsi);
   lPhi=length(RangePhi);
   
   TSet=cell(lL*lT*lPsi*lPhi,1);
   n=1;%TSet������
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

