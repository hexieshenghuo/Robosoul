%% ����ŷ���Ǽ�����ת����
%% ע����ŵ�˳�������� �����xyz ��ô�����Ƕ������� x��y��z��ת�ǣ����
%% ��zyx ��ô������ z��y��x��ת�� ���������ܶ�����������x y z��˳����
% EulerAngles: ŷ����Ĭ��������
% varargin{1}: ŷ�������� type
% R:��ת����
function [ R ] = EulerRotMat( EulerAngles ,varargin )
   type='xyz';   %Ĭ��ŷ��������
   if nargin>1
       type=varargin{1};
   end
   switch type
       case 'xyz'
           R=Rot(EulerAngles(1),'x')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'z');
       case 'zyx'
           R=Rot(EulerAngles(1),'z')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'x');
       case 'zyz'
           R=Rot(EulerAngles(1),'z')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'z');
       case 'xyx'
           R=Rot(EulerAngles(1),'x')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'x');
   end
   R=MR(R);
end

