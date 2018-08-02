%% �÷����������ŷ��������ٶ�֮���Jacobian����
%% ע����ŵ�˳�������� �����xyz ��ô�����Ƕ������� x��y��z��ת�ǣ����
%% ��zyx ��ô������ z��y��x��ת�� ���������ܶ�����������x y z��˳����
% EulerAnler :3��1 ŷ�������� ���ű���
% EulerType: ŷ�������� 'xyz' 'zyx' 'zyz'��
% CoordType: �������ϵ���ͣ�'B'or'b' ������������ϵ 'W'or'w'�����������ϵ
% varargin{1}:���ű���(Ҳ��������ֵ����)[a b r].',�����滻e1 e2 e3��ŷ���Ƿ���

function [ J ] = symEulerJacobian( EulerType ,CoordType,varargin )
   
   E=sym('e',[3 1]); % ŷ���Ƿ�������
   dE=sym('de',[3 1]);
   
   R=EulerRotMat(E,EulerType);
   
   vR=reshape(R,9,1);% 3��3 R->9��1����
   dR=jacobian(vR,E)*dE;
   dR=reshape(dR,3,3);

   if ( (CoordType=='B')||(CoordType=='b') )
       % ������������ϵ���� body frame
       Sw=R.'*dR;
   else 
       % �����������ϵ����
       Sw=dR*R.';
   end
   Sw=simplify(Sw);
   %
   F=[-Sw(2,3);Sw(1,3);-Sw(1,2)];
   J=jacobian(F,dE);
   
   % �ø��������滻
   if nargin>2
       Euler=varargin{1};    
       J=subs(J,E,Euler);
%        J=subs(J,[E(1),E(2),E(3)],[Euler(1),Euler(2),Euler(3)]);
%        J=subs(J,E(2),);
%        J=subs(J,E(3),);
   end
   
end

