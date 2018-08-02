function [x,fval,exitflag,output,grad]=fminlbfgsWEI(funfcn,x_init,optim)

%FMINLBFGS Ѱ�Ҷ���������ֲ���Сֵ 
%   ���Ż���Ϊ���д���δ֪������ͼ����׼���������� 
%
%   ��֧���Ż�������
%	- ��ţ�ٷ���BFGS��  
%   - ���޴洢BFGS (L-BFGS)
%   - ��ݶ��½��Ż�
%   
%   [X,FVAL,EXITFLAG,OUTPUT,GRAD] = FMINLBFGS(FUN,X0,OPTIONS) 
%
%   ����
%		FUN: ����С�������ľ�����ַ������������ֵ������ݶ��������ָ��Ҳ����
%		X0: δ֪����ʼֵ����Ϊ����������������󣨿�ѡ��
%		OPTIONS: ��Ӧ�Ż�����ѡ��Ľṹ�������Զ����������optimset,(optimset��֧����������ѡ�
%
%   ���
%		X : ���ҵ�����С��������λ�ã�ֵ��
%		FVAL : ���ҵ�����Сֵ
%		EXITFLAG : �����Ż���ֹͣԭ������������Ӧ��ֵ
%		OUTPUT : ��������Ҫ���ֵ������Ľṹ����
%		GRAD : ��λ���ϵ��ݶ� 
%
%   ����/���������չ���� 
%   OPTIONS,
%		OPTIONS.GoalsExactAchieve : ��0����������һά����������1������Wolfe��������̬��������Ĭ�ϣ�
%		OPTIONS.GradConstr, ����ݶȵ�����CPU���۸߰��ģ�Ĭ�ϣ����ñ���ֵΪ��;����Ϊ�٣��ݶȵ��ö࣬����������
%	    OPTIONS.HessUpdate : ��Ϊ 'bfgs',����BFGS�Ż�������Ĭ�ϣ���δ֪������3000ʱ���л��������ڴ�BFGS������
%               ����Ϊ'lbfgs'��ͬ����Ϊ 'steepdesc', ������ݶ��½��Ż����� 
%		OPTIONS.StoreN : ����L-BFGS�н���Hessian����ĵ���������Ĭ��ֵ20���Բ�ƽ��������Сֵ���ܸ��ã�
%               ��ΪHessian�����ض�λ����Ч���Զ���ʽ�Ƽ��ô�ֵ 
%		OPTIONS.GradObj : ������ݶȣ���Ϊ 'on'������������޲��
%     	OPTIONS.Display : ��ʾ�ĵȼ��� 'off' ����ʾ�����'plot'��ʾͼ����������������� 
%               'iter'��ʾÿһ�ε����������'final'ֻ��ʾ��������� 'notify'���ں���������ʱ��ʾ��� 
%	    OPTIONS.TolX : x����ֹ���ޣ�Ĭ��ֵ 1e-6.
%	    OPTIONS.TolFun : ����ֵ��ֹ���ޣ�Ĭ��ֵ 1e-6.
%		OPTIONS.MaxIter : ������������Ĭ��ֵ 400.
% 		OPTIONS.MaxFunEvals : ������ֵ��������Ĭ��ֵΪδ֪������Ŀ100��
%		OPTIONS.DiffMaxChange : ���޲���ݶ�����󲽳�
%		OPTIONS.DiffMinChange : ���޲���ݶ�����С����
%		OPTIONS.OutputFcn : �û����庯�����Ż���������ÿ�ε���ʱ����
%		OPTIONS.rho : �ݶȵ�Wolfe����, Ĭ��ֵ 0.01
%		OPTIONS.sigma : �ݶȵ�Wolfe����, Ĭ��ֵ 0.9 
%		OPTIONS.tau1 : �������ʱ��������Χ��չ��Ĭ��ֵ 3
%		OPTIONS.tau2 : ��Χ�зֽ׶Σ�section phase����߽�������Ĭ��ֵ 0.1
%		OPTIONS.tau3 : ��Χ�зֽ׶Σ�section phase���ұ߽�������Ĭ��ֵ 0.5
%   FUN,
%		ͬʱ�ṩX���ݶ��ܸĽ��Ż����ٶȣ��� FUN ����дΪ������ʽ
%   	function [f,g]=FUN(X)
%       	f , X����ֵ����;
%   	if ( nargout > 1 )
%       	g , X�����ݶȼ���
%   	end
%	EXITFLAG,
%		EXITFLAG���ܵ�ȡֵ����Ӧ�˳�����
%		1, 'Change in the objective function value was less than the specified tolerance TolFun.'
%           ��Ŀ�꺯��ֵ�仯С��ָ��������TolFun��
%  		2, 'Change in x was smaller than the specified tolerance TolX.';
%           ��X�仯С��ָ������TolX��
%  		3, 'Magnitude of gradient smaller than the specified tolerance';
%           ���ݶ�ֵС��ָ�����ޣ�
%  		4, 'Boundary fminimum reached.'
%           ���ﵽfminimum�߽磩
%  		0, 'Number of iterations exceeded options. MaxIter or number of function evaluations exceeded options.FunEvals.'
%           �������������ޣ�MaxIter���ߺ�����ֵ��������options.FunEvals��
%  		-1, 'Algorithm was terminated by the output function.'
%           �����������output����ֹ���㷨��
%  		-2, 'Line search cannot find an acceptable point along the current search';
%           �����ŵ�ǰ�������������޷��ҵ�һ���ɽ��ܵ㣩
%
%   ����
%       options = optimset('GradObj','on');
%       X = fminlbfgs(@myfun,2,options)
%
%   	% ���� myfun��һ��MATLAB����������
%       function [f,g] = myfun(x)
%       f = sin(x) + 3;
%	    if ( nargout > 1 ), g = cos(x); end
%
% See also OPTIMSET, FMINSEARCH, FMINBND, FMINCON, FMINUNC, @, INLINE.
%
% Function is written by D.Kroon University of Twente (Updated Nov. 2010)

% ���Ż�����
defaultopt = struct(    ...
            'Display',              'final',                ...
            'HessUpdate',           'bfgs',                 ...
            'GoalsExactAchieve',    1,                      ...
            'GradConstr',           true,                   ...
			'TolX',                 1e-6,                   ...
            'TolFun',               1e-6,                   ...
            'GradObj',              'off',                  ...
            'MaxIter',              400,                    ...
            'MaxFunEvals',          100*numel(x_init)-1,    ...
			'DiffMaxChange',        1e-1,                   ...
            'DiffMinChange',        1e-8,                   ...
            'OutputFcn',            [],                     ...
			'rho',                  0.0100,                 ...
            'sigma',                0.900,                  ...
            'tau1',                 3,                      ...
            'tau2',                 0.1,                    ...
            'tau3',                 0.5,                    ...
            'StoreN',20);

if (~exist('optim','var')) 
    optim=defaultopt;
else
    f = fieldnames(defaultopt);
    for i=1:length(f),
        if (~isfield(optim,f{i})||(isempty(optim.(f{i})))), optim.(f{i})=defaultopt.(f{i}); end
    end
end
    
% ��ʼ�����ݽṹ
data.fval=0;
data.gradient=0;
data.fOld=[]; 
data.xsizes=size(x_init);
data.numberOfVariables = numel(x_init);
data.xInitial = x_init(:);
data.alpha=1;
data.xOld=data.xInitial; 
data.iteration=0;
data.funcCount=0;
data.gradCount=0;
data.exitflag=[];
data.nStored=0;
data.timeTotal=tic;
data.timeExtern=0;

% δ֪������3000ʱ�л��� L-BFGS ����
if(optim.HessUpdate(1)=='b') 
    if (data.numberOfVariables<3000),   optim.HessUpdate='bfgs';
    else    optim.HessUpdate='lbfgs';
    end
end

if(optim.HessUpdate(1)=='l'),   succes=false;
    while(~succes)
        try
            data.deltaX=zeros(data.numberOfVariables,optim.StoreN);
            data.deltaG=zeros(data.numberOfVariables,optim.StoreN);
            data.saveD=zeros(data.numberOfVariables,optim.StoreN);
            succes=true;
        catch ME
            warning('fminlbfgs:memory','Decreasing StoreN value because out of memory');
            succes=false;
            data.deltaX=[];     data.deltaG=[];     data.saveD=[];
            optim.StoreN=optim.StoreN-1;
            if (optim.StoreN<1), rethrow(ME);   end
        end
    end
end
exitflag=[];

% ��ʾ��������
if(strcmp(optim.Display,'iter'))
     disp('     Iteration  Func-count   Grad-count         f(x)         Step-size');
end

% �����ʼ������ݶ�
data.initialStepLength=1;
[data,fval,grad]=gradient_function(data.xInitial,funfcn, data, optim);
data.gradient=grad;
data.dir = -data.gradient;
data.fInitial = fval;
data.fPrimeInitial= data.gradient'*data.dir(:);
data.fOld=data.fInitial;
data.xOld=data.xInitial;
data.gOld=data.gradient;
    
gNorm = norm(data.gradient,Inf);  data.initialStepLength = min(1/gNorm,5);      % �ݶȷ���
 

% ��ʾ��ǰ������Ϣ
if (strcmp(optim.Display,'iter'))
    s=sprintf('     %5.0f       %5.0f       %5.0f       %13.6g    ',data.iteration,data.funcCount,data.gradCount,data.fInitial); disp(s); disp(s);
end
  
% Hessian�����ʼ��
if (optim.HessUpdate(1)=='b'),	data.Hessian=eye(data.numberOfVariables);   end

% �����������
if (call_output_function(data,optim,'init')),   exitflag=-1;    end
    
% ��ʼ��С��
while(true)
    data.iteration=data.iteration+1;     % ���µ�������

    % �õ�ǰ����������
    data.TolFunLnS = eps(max(1,abs(data.fInitial )));
    data.fminimum = data.fInitial - 1e16*(1+abs(data.fInitial));
    
	% �����洢�����ؽ��������
    data.storefx=[]; data.storepx=[]; data.storex=[]; data.storegx=[];

    % ���option��ʾѡ��Ϊplot, ��ʼ��ͼ
    if (optim.Display(1)=='p'), figure, hold on; end
		
    % �ҵ��ݶȷ�����ʲ�����������
    if (optim.GoalsExactAchieve==1),	data=linesearch(funfcn, data,optim);
    else  data=linesearch_simple(funfcn, data, optim);
    end
	
	% ��������ͼ
	if(optim.Display(1)=='p'); 
		plot(data.storex,data.storefx,'r*');
		plot(data.storex,data.storefx,'b');
		
		alpha_test  = linspace(min(data.storex(:))/3, max(data.storex(:))*1.3, 10);
		falpha_test = zeros(1,length(alpha_test));
        for i=1:length(alpha_test)
			[data,falpha_test(i)]=gradient_function(data.xInitial(:)+ alpha_test(i)*data.dir(:),funfcn, data, optim);
        end    
		plot(alpha_test,falpha_test,'g');
        plot(data.alpha,data.f_alpha,'go','MarkerSize',8);
	end
	
    % ��� exitflag �Ƿ�����
    if(~isempty(data.exitflag)),
        exitflag=data.exitflag;     data.xInitial=data.xOld; 
        data.fInitial=data.fOld;    data.gradient=data.gOld;
        break, 
    end;
    
    data.xInitial=data.xInitial+data.alpha*data.dir;                % ��alpha��������x
    data.fInitial =  data.f_alpha;  data.gradient = data.grad;      % �õ�ǰ������ݶ�
	
    data.initialStepLength = 1;         % �ó�ʼ����Ϊ1
    gNorm = norm(data.gradient,Inf);    % �ݶȷ���
    
    % ���˳���־ 
    if (gNorm <optim.TolFun),   exitflag=1;     end
    if (max(abs(data.xOld-data.xInitial)) <optim.TolX),         exitflag=2;     end
    if (data.iteration>=optim.MaxIter),         exitflag=0;     end
    
    if (~isempty(exitflag)), break, end     % ����˳���־�Ƿ�����

    % ������Hessian����
    if (optim.HessUpdate(1)~='s')           % ��ţ�ٷ�����Hessian����
        data = updateQuasiNewtonMatrix_LBFGS(data,optim);
    else
        data.dir = -data.gradient;
    end
    data.fPrimeInitial= data.gradient'*data.dir(:);     % ������

    % �����������
    if (call_output_function(data,optim,'iter')),   exitflag=-1;    end
    
    % ��ʾ��ǰ����
    if(strcmp(optim.Display(1),'i')||strcmp(optim.Display(1),'p'))
        s=sprintf('     %5.0f       %5.0f       %5.0f       %13.6g   %13.6g',data.iteration,data.funcCount,data.gradCount,data.fInitial,data.alpha); disp(s);
    end
    
    % �������������´ε���
    data.fOld=data.fInitial;    data.xOld=data.xInitial;    data.gOld=data.gradient;
end

% �����������x���λ�ԭ���ߴ�
fval = data.fInitial;           grad = data.gradient;       x = data.xInitial;      x = reshape(x,data.xsizes);   

if(call_output_function(data,optim,'done')), exitflag=-1;   end     % �����������

% �γ���������ṹ
if      (optim.HessUpdate(1)=='b'),     output.algorithm='BFGS method';
elseif  (optim.HessUpdate(1)=='l'),     output.algorithm='limited memory BFGS (L-BFGS)';
else    output.algorithm='Steepest Gradient Descent';
end

output.message=getexitmessage(exitflag);
output.iteration = data.iteration;
output.funccount = data.funcCount;
output.fval = data.fInitial;
output.stepsize = data.alpha;
output.directionalderivative = data.fPrimeInitial;
output.gradient = reshape(data.gradient, data.xsizes);
output.searchdirection = data.dir;
output.timeTotal=toc(data.timeTotal);    
output.timeExtern=data.timeExtern;
oupput.timeIntern=output.timeTotal-output.timeExtern;

% ��ʾ���ս��
if(~strcmp(optim.Display,'off'))
    disp('    Optimizer Results')
    disp(['   Algorithm Used: ' output.algorithm]);
    disp(['   Exit message : ' output.message]);
    disp(['   iterations : '  int2str(data.iteration)]);
    disp(['   Function Count : ' int2str(data.funcCount)]);
    disp(['   Minimum found : ' num2str(fval)]);
    disp(['   Intern Time : ' num2str(oupput.timeIntern) ' seconds']);
    disp(['   Total Time : ' num2str(output.timeTotal) ' seconds']);
end

function message=getexitmessage(exitflag)
    switch(exitflag)
        case 1, message='Change in the objective function value was less than the specified tolerance TolFun.';
        case 2, message='Change in x was smaller than the specified tolerance TolX.'; 
        case 3, message='Magnitude of gradient smaller than the specified tolerance';
        case 4, message='Boundary fminimum reached.';
        case 0, message='Number of iterations exceeded options.MaxIter or number of function evaluations exceeded options.FunEvals.';
        case -1, message='Algorithm was terminated by the output function.';
        case -2, message='Line search cannot find an acceptable point along the current search';
        otherwise, message='Undefined exit code';
    end
    
function stopt=call_output_function(data,optim,where)

stopt=false;
if(~isempty(optim.OutputFcn))
    output.iteration = data.iteration;
    output.funccount = data.funcCount;
    output.fval = data.fInitial;
    output.stepsize = data.alpha;
    output.directionalderivative = data.fPrimeInitial;
    output.gradient = reshape(data.gradient, data.xsizes);
    output.searchdirection = data.dir;
    stopt=feval(optim.OutputFcn,reshape(data.xInitial,data.xsizes),output,where); 
end
        	
function data=linesearch_simple(funfcn, data, optim)

data = bracketingPhase_simple(funfcn, data, optim);     % Ѱ�ҿɽ��ܵ㷶Χ
if (data.bracket_exitflag  == 2)                        % BracketingPhase�ҵ������ɽ��ܵ㷶Χ�������ڷ�Χ����һ��
   data = sectioningPhase_simple(funfcn, data, optim);  data.exitflag = data.section_exitflag; 
else   data.exitflag = data.bracket_exitflag;           % �Ѿ��ҵ��ɽ��ܵ㣬���ߴﵽ��MaxFunEvals
end

function data = bracketingPhase_simple(funfcn, data,optim)

itw=0;          % ����������
data.beta=0;    data.f_beta=data.fInitial;  data.fPrime_beta=data.fPrimeInitial;  % ��Сֵ�㣬��ֵ
alpha = data.initialStepLength;     % ��ʼ��������ǰ�沽���alpha
hill  = false;  % ��ɽ

% ������Χ
while(true)
    if(optim.GradConstr)            % ������׼����ݶ�
        [data,f_alpha]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
        fPrime_alpha=nan;           grad=nan;
    else
        [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
        fPrime_alpha = grad'*data.dir(:);
    end
    
	% �洢������ֵ
	data.storefx=[data.storefx f_alpha];    data.storepx=[data.storepx fPrime_alpha]; 
	data.storex=[data.storex alpha];        data.storegx=[data.storegx grad(:)];
    
    % ���²���ֵ
    if(data.f_beta<f_alpha),    
        alpha=alpha*optim.tau3;             % ����С����
        hill=true;                          % ��λ hill����
    else                                    % ���浱ǰ��Сֵ��
        data.beta=alpha;                    data.f_beta=f_alpha; 
        data.fPrime_beta=fPrime_alpha;      data.grad=grad;
        if (~hill), alpha = alpha*optim.tau1;   end
    end
 
    itw=itw+1;              % ���µ���ѭ���������û���ҵ������ֵ����������ʧ��	
    if (itw>(log(optim.TolFun)/log(optim.tau3))),   data.bracket_exitflag=-2;     break;    end
    
    if (data.beta>0&&hill)  % Χ����Сֵȷ�Ϸ�Χ���Ӵ洢����������ΧA
            [~,i]=sort(data.storex,'ascend');
            storefx=data.storefx(i);    storepx=data.storepx(i);    storex=data.storex(i);
            [~,i]=find(storex>data.beta,1);
            if(isempty(i)),     [~,i]=find(storex==data.beta,1);    end
            alpha=storex(i);            f_alpha=storefx(i);         fPrime_alpha=storepx(i);
            
            % �Ӵ洢����������ΧB
            [~,i]=sort(data.storex,'descend');
            storefx=data.storefx(i);    storepx=data.storepx(i);    storex=data.storex(i);
            [~,i]=find(storex<data.beta,1);
            if(isempty(i)),     [~,i]=find(storex==data.beta,1);    end
            beta=storex(i);     f_beta=storefx(i);                  fPrime_beta=storepx(i);
            
            % �����û�������������㵼��
            if(optim.GradConstr)
                gstep=data.initialStepLength/1e6; 
                if(gstep>optim.DiffMaxChange), gstep=optim.DiffMaxChange; end
                if(gstep<optim.DiffMinChange), gstep=optim.DiffMinChange; end
                [data,f_alpha2]=gradient_function(data.xInitial(:)+(alpha+gstep)*data.dir(:),funfcn, data, optim);
                [data,f_beta2]=gradient_function(data.xInitial(:)+(beta+gstep)*data.dir(:),funfcn, data, optim);
                fPrime_alpha=(f_alpha2-f_alpha)/gstep;
                fPrime_beta=(f_beta2-f_beta)/gstep;
            end

            % �÷�ΧA��B������ȷ����Χ�׶�
            data.a=alpha;   data.f_a=f_alpha;   data.fPrime_a=fPrime_alpha;
            data.b=beta;    data.f_b=f_beta;    data.fPrime_b=fPrime_beta;    
            data.bracket_exitflag  = 2;         return         
    end
	if(data.funcCount>=optim.MaxFunEvals), data.bracket_exitflag=0;     return;     end     % �ﵽ�������������
end
    

function data = sectioningPhase_simple(funfcn, data, optim)

brcktEndpntA=data.a; brcktEndpntB=data.b;       % ȡ��������Χ

% ����������Χ֮����Сֵ
[alpha,f_alpha_estimated] = pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,data.a,data.b,data.f_a,data.fPrime_a,data.f_b,data.fPrime_b,optim);  
if (isfield(data,'beta')&&(data.f_beta<f_alpha_estimated)), alpha=data.beta;    end

[~,i]=find(data.storex==alpha,1);
if ((~isempty(i))&&(~isnan(data.storegx(i)))),          f_alpha=data.storefx(i);   grad=data.storegx(:,i);
else               % Ϊ��һ����С����������������ݶ�
    [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
    if(isfield(data,'beta')&&(data.f_beta<f_alpha)),    alpha=data.beta; 
        if ((~isempty(i))&&(~isnan(data.storegx(i)))),  f_alpha=data.storefx(i);    grad=data.storegx(:,i);
        else       [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
        end
    end
end

data.storefx=[data.storefx f_alpha];    data.storex=[data.storex alpha];        % �洢ֵ������
fPrime_alpha = grad'*data.dir(:);       data.alpha=alpha;                       
data.fPrime_alpha= fPrime_alpha;        data.f_alpha= f_alpha;  data.grad=grad;

data.section_exitflag=[];               % �óɹ��˳���־   


function data=linesearch(funfcn, data, optim)

data = bracketingPhase(funfcn, data,optim);         % �ҵ�һ���ɽ��ܵ㷶Χ
if   (data.bracket_exitflag  == 2)                  % BracketingPhase�ҵ��ɽ��ܵ㷶Χ���ڷ�Χ����һ���� 
     data = sectioningPhase(funfcn, data, optim);   data.exitflag = data.section_exitflag; 
else data.exitflag = data.bracket_exitflag;         % ���ҵ��ɽ��ܵ㣬���ߴﵽ�������������MaxFunEvals��
end

function data = sectioningPhase(funfcn, data, optim)

% sectioningPhase �ڰ����ɽ��ܵ�ĸ�����Χ[a,b]���ҵ�һ���ɽ��ܵ� alpha 
% ע�� funcCount �����Ժ�������������������Щ����Ѱ��Χ�׶ε���������  

while(true)
    
    % ��������Χ����alpha
    brcktEndpntA = data.a + min(optim.tau2,optim.sigma)*(data.b - data.a); 
    brcktEndpntB = data.b - optim.tau3*(data.b - data.a);
    
    % �ҵ���Χ[brcktEndpntA,brcktEndpntB]�ڵ�3�ȶ���ʽȫ����С���㣬����ʽ��"a" ��"b"�ڲ� f() �� f'() 
    alpha = pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,data.a,data.b,data.f_a,data.fPrime_a,data.f_b,data.fPrime_b,optim);  

    % û�з��ֿɽ��ܵ�
    if (abs( (alpha - data.a)*data.fPrime_a ) <= data.TolFunLnS), data.section_exitflag = -2; return; end
    
    % ���㵱ǰalphaֵ����������ʱ��Ҳ�����ݶȣ� 
    if(~optim.GradConstr)
        [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
        fPrime_alpha = grad'*data.dir(:);
    else
        gstep=data.initialStepLength/1e6; 
        if (gstep>optim.DiffMaxChange), gstep=optim.DiffMaxChange;  end
        if (gstep<optim.DiffMinChange), gstep=optim.DiffMinChange;  end
        [data,f_alpha]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
        [data,f_alpha2]=gradient_function(data.xInitial(:)+(alpha+gstep)*data.dir(:),funfcn, data, optim);
        fPrime_alpha=(f_alpha2-f_alpha)/gstep;
    end
    
	data.storefx=[data.storefx f_alpha];    data.storex=[data.storex alpha];    % �洢ֵ������  
    aPrev = data.a; f_aPrev = data.f_a;     fPrime_aPrev = data.fPrime_a;       % �洢��ǰ��ΧAλ��

    % ���µ�ǰ��Χ
    if ((f_alpha > data.fInitial + alpha*optim.rho*data.fPrimeInitial) || (f_alpha >= data.f_a))
        data.b = alpha; data.f_b = f_alpha; data.fPrime_b = fPrime_alpha;       % ���·�ΧBΪ��ǰalpha
    else                                    % Wolfe ��������Ϊ����ɽ��ܵ��ҵ� 
        if (abs(fPrime_alpha) <= -optim.sigma*data.fPrimeInitial), 
            if  (optim.GradConstr)          % ��Ϊʱ����ۣ��ݶȻ�û�м���
                [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
                fPrime_alpha = grad'*data.dir(:);
            end    
            data.alpha=alpha;       data.fPrime_alpha= fPrime_alpha;            % �洢�ҵ���alphaֵ
            data.f_alpha= f_alpha;  data.grad=grad;
            data.section_exitflag = [];     return 
        end
   
        data.a = alpha; data.f_a = f_alpha; data.fPrime_a = fPrime_alpha;       % ���·�ΧA     
        if (data.b - data.a)*fPrime_alpha >= 0                                  % B��Ϊ�ɷ�ΧA
            data.b = aPrev;    data.f_b = f_aPrev;   data.fPrime_b = fPrime_aPrev;
        end
    end
     
    if (abs(data.b-data.a) < eps), data.section_exitflag = -2;  return,     end             % �޷��ҵ��ɽ��ܵ�
    if(data.funcCount >optim.MaxFunEvals), data.section_exitflag = -1;  return,     end     % �ﵽ maxFunEvals 
end

function data = bracketingPhase(funfcn, data, optim)

% bracketingPhase �ҵ������ɽ��ܵ�ķ�Χ[a,b]����Χ��bracket����պ�����һ���������� a>b 
% ��� f_a �� fPrime_a ���ڷ�Χ�Ķ˵�'a'���Ƶĺ���ֵ�뵼�����˵� 'b'�Ǻ����� 

% ��ΧA��B�Ĳ���
data.a = [];    data.f_a = [];  data.fPrime_a = []; 
data.b = [];    data.f_b = [];  data.fPrime_b = [];

% �״���̽ alpha ���û��ṩ��f_alpha ����������̽��alpha�� f(alpha)��fPrime_alpha ����������̽��alpha�� f'(alpha) 
alpha = data.initialStepLength;     f_alpha = data.fInitial;    fPrime_alpha = data.fPrimeInitial;

% �� alpha���ֵ����fminimum ����)
alphaMax = (data.fminimum - data.fInitial)/(optim.rho*data.fPrimeInitial);  alphaPrev = 0;

while(true) 
  fPrev = f_alpha;  fPrimePrev = fPrime_alpha;      % ����f(alpha) and f'(alpha)
          
  % ���㵱ǰalpha�ĺ���ֵ(���û�ж���ʱ������Ҳ�����ݶȣ� 
  if(~optim.GradConstr)
      [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
      fPrime_alpha = grad'*data.dir(:);
  else
      gstep=data.initialStepLength/1e6;
      if(gstep>optim.DiffMaxChange), gstep=optim.DiffMaxChange; end
      if(gstep<optim.DiffMinChange), gstep=optim.DiffMinChange; end
      [data,f_alpha]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
      [data,f_alpha2]=gradient_function(data.xInitial(:)+(alpha+gstep)*data.dir(:),funfcn, data, optim);
      fPrime_alpha=(f_alpha2-f_alpha)/gstep;
  end
  
  data.storefx=[data.storefx f_alpha]; data.storex=[data.storex alpha];     % �洢ֵ������ 	
  if (f_alpha <= data.fminimum), data.bracket_exitflag = 4; return; end     % ��� f<fminimum����ֹ
  
  % ��Χ��λ�ˣ�- ����1 (Wolfe ����)
  if (f_alpha > (data.fInitial + alpha*optim.rho*data.fPrimeInitial)) || (f_alpha >= fPrev)  % �÷�Χֵ������������Χ�׶�
     data.a = alphaPrev;     data.f_a = fPrev;       data.fPrime_a = fPrimePrev;
     data.b = alpha;         data.f_b = f_alpha;     data.fPrime_b = fPrime_alpha; 
     data.bracket_exitflag  = 2;    return 
  end

  % �ɽ��ܵĲ����ҵ���
  if (abs(fPrime_alpha) <= -optim.sigma*data.fPrimeInitial), 
      if(optim.GradConstr)                  % ����ʱ�����ģ��ݶȻ�û�м���
          [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
          fPrime_alpha = grad'*data.dir(:);
      end
     
      data.alpha=alpha;                     % �洢�ҵ���alphaֵ
      data.fPrime_alpha= fPrime_alpha;      data.f_alpha= f_alpha;      data.grad=grad;
      data.bracket_exitflag = []; return    % ����������Χ�׶Σ�û��Ҫ�����зֽ׶�
  end
  
  % ��Χ��λ�ˣ�- ���� 2  
  if (fPrime_alpha >= 0)                    % �÷�Χֵ���������ط�Χ�׶�
    data.a = alpha; data.f_a = f_alpha;     data.fPrime_a = fPrime_alpha;
    data.b = alphaPrev; data.f_b = fPrev;   data.fPrime_b = fPrimePrev;
    data.bracket_exitflag  = 2;   return
  end
 
  % ���� alpha
  if (2*alpha - alphaPrev < alphaMax )
        brcktEndpntA = 2*alpha-alphaPrev;   brcktEndpntB = min(alphaMax,alpha+optim.tau1*(alpha-alphaPrev));
      
        % �ҵ�3�ȶ���ʽ�ڷ�Χ[brcktEndpntA,brcktEndpntB]��ȫ����С���㣬����ʽ��alphaPrev���alpha���ڲ�f()��f'() 
        alphaNew = pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,alphaPrev,alpha,fPrev,fPrimePrev,f_alpha,fPrime_alpha,optim);
        alphaPrev = alpha;    alpha = alphaNew;
  else  alpha = alphaMax;
  end
  if (data.funcCount >optim.MaxFunEvals), data.bracket_exitflag = -1; return, end    % �ﵽ�������������maxFunEvals��
end

function [alpha,f_alpha]= pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,alpha1,alpha2,f1,fPrime1,f2,fPrime2,optim)

% �ҵ���alpha1��alpha2�ڲ�f()��f'()����������ʽ��3�ȶ���ʽ�������ڷ�Χ[brcktEndpntA,brcktEndpntB]�ڵ�ȫ����С����alpha 
% ���� f(alpha1) = f1, f'(alpha1) = fPrime1, f(alpha2) = f2, f'(alpha2) = fPrime2

% ȷ����������ʽϵ����Ҫ���� c(alpha1) = f1, c'(alpha1) = fPrime1, c(alpha2) = f2, c'(alpha2) = fPrime2.
coeff = [(fPrime1+fPrime2)*(alpha2-alpha1)-2*(f2-f1) 3*(f2-f1)-(2*fPrime1+fPrime2)*(alpha2-alpha1) (alpha2-alpha1)*fPrime1 f1];

lowerBound = (brcktEndpntA - alpha1)/(alpha2 - alpha1);             % �߽�ת����Z�ռ�
upperBound = (brcktEndpntB - alpha1)/(alpha2 - alpha1);

if (lowerBound  > upperBound), t=upperBound; upperBound=lowerBound; lowerBound=t;   end         % �½�����Ͻ����
sPoints = roots([3*coeff(1) 2*coeff(2) coeff(3)]);                  % �Ӷ���ʽ�����ĸ��ҳ���Сֵ�����ֵ
sPoints(imag(sPoints)~=0)=[];  sPoints(sPoints<lowerBound)=[];  sPoints(sPoints>upperBound)=[]; % �������������
sPoints=[lowerBound sPoints(:)' upperBound];                        % �����п��ܽ⹹������
[f_alpha,index]=min(polyval(coeff,sPoints));    z=sPoints(index);   % ѡ��ȫ����С��
alpha = alpha1 + z*(alpha2 - alpha1);                               % ���ƫ�ã���[0..1]������alpha��

% ��ʾ����ʽ����
if(optim.Display(1)=='p'); 
    vPoints=polyval(coeff,sPoints);
    plot(sPoints*(alpha2 - alpha1)+alpha1,vPoints,'co');
    plot([sPoints(1) sPoints(end)]*(alpha2 - alpha1)+alpha1,[vPoints(1) vPoints(end)],'c*');
    xPoints=linspace(lowerBound/3, upperBound*1.3, 50);
    vPoints=polyval(coeff,xPoints);
    plot(xPoints*(alpha2 - alpha1)+alpha1,vPoints,'c');
end

function [data,fval,grad]=gradient_function(x,funfcn, data, optim)
    
% �����������������ݶȣ�
    if ( nargout <3 )
        timem=tic;   
        fval=funfcn(reshape(x,data.xsizes)); 
        data.timeExtern=data.timeExtern+toc(timem);
        data.funcCount=data.funcCount+1;
    else
        if(strcmp(optim.GradObj,'on'))
            timem=tic;    
            [fval, grad]=feval(funfcn,reshape(x,data.xsizes)); 
            data.timeExtern=data.timeExtern+toc(timem);
            data.funcCount=data.funcCount+1;
            data.gradCount=data.gradCount+1;
        else
            % �������û���ṩ������ǰ���ּ����ݶ�
            grad=zeros(length(x),1);
            fval=funfcn(reshape(x,data.xsizes));
            gstep=data.initialStepLength/1e6; 
            if(gstep>optim.DiffMaxChange), gstep=optim.DiffMaxChange; end
            if(gstep<optim.DiffMinChange), gstep=optim.DiffMinChange; end
            for i=1:length(x),
                x_temp=x; x_temp(i)=x_temp(i)+gstep;
                timem=tic;    
                [fval_g]=feval(funfcn,reshape(x_temp,data.xsizes)); data.funcCount=data.funcCount+1;
                data.timeExtern=data.timeExtern+toc(timem);
                grad(i)=(fval_g-fval)/gstep;
            end
        end
        grad=grad(:);
    end
    
function data = updateQuasiNewtonMatrix_LBFGS(data,optim)

% ���½�����Hessian�������ţ�پ���֧�����ַ�����BFGS��L-BFGS��L-BFGS�У�Hessian���󲻹�����ߴ洢
% ����λ�ü����ε���֮����ݶȲ���

deltaX = data.alpha* data.dir;  deltaG = data.gradient-data.gOld;
        
if ((deltaX'*deltaG) >= sqrt(eps)*max( eps,norm(deltaX)*norm(deltaG) ))
    if(optim.HessUpdate(1)=='b')        % Ĭ�� BFGS���� Nocedal���� 
        p_k = 1 / (deltaG'*deltaX);                
        Vk = eye(data.numberOfVariables) - p_k*deltaG*deltaX';
        data.Hessian = Vk'*data.Hessian *Vk + p_k*(deltaX*deltaX');     % ��Hessian����
        data.dir = -data.Hessian*data.gradient;                         % ���·���
    else                                % ����չ��L-BFGS����Nocedal����
        % ��deltaX��deltaG����ʷ�����б� 
        data.deltaX(:,2:optim.StoreN)=data.deltaX(:,1:optim.StoreN-1); data.deltaX(:,1)=deltaX;
        data.deltaG(:,2:optim.StoreN)=data.deltaG(:,1:optim.StoreN-1); data.deltaG(:,1)=deltaG; 
        data.nStored=data.nStored+1; 
        if(data.nStored>optim.StoreN), data.nStored=optim.StoreN; end

        a=zeros(1,data.nStored);  p=zeros(1,data.nStored);  q=data.gradient;    % ��ʼ������
        for i=1:data.nStored
            p(i)= 1 / (data.deltaG(:,i)'*data.deltaX(:,i));
            a(i) = p(i)* data.deltaX(:,i)' * q;
            q = q - a(i) * data.deltaG(:,i);
        end
        
        % ��ʼHessian���󣨺�Ⱦ�����չ��r = - Hessian * gradient
        p_k = data.deltaG(:,1)'*data.deltaX(:,1) / sum(data.deltaG(:,1).^2);  
        r = p_k * q;       
        for i=data.nStored:-1:1,
            b = p(i) * data.deltaG(:,i)' * r;
            r = r + data.deltaX(:,i)*(a(i)-b);
        end
        data.dir = -r;                  % ���·���
    end
end    
