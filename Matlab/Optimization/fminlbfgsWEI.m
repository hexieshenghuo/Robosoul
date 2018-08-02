function [x,fval,exitflag,output,grad]=fminlbfgsWEI(funfcn,x_init,optim)

%FMINLBFGS 寻找多变量函数局部最小值 
%   此优化器为具有大量未知变量的图像配准方法而开发 
%
%   所支持优化方法：
%	- 拟牛顿法（BFGS）  
%   - 有限存储BFGS (L-BFGS)
%   - 最陡梯度下降优化
%   
%   [X,FVAL,EXITFLAG,OUTPUT,GRAD] = FMINLBFGS(FUN,X0,OPTIONS) 
%
%   输入
%		FUN: 被最小化函数的句柄或字符串，返回误差值，误差梯度如在输出指定也返回
%		X0: 未知量初始值，可为标量，向量，或矩阵（可选）
%		OPTIONS: 对应优化器可选项的结构变量，自定义或者来自optimset,(optimset不支持所有输入选项）
%
%   输出
%		X : 所找到的最小化函数的位置（值）
%		FVAL : 所找到的最小值
%		EXITFLAG : 解释优化器停止原因（条件）所对应的值
%		OUTPUT : 含所有重要输出值与参数的结构变量
%		GRAD : 此位置上的梯度 
%
%   输入/输出变量扩展描述 
%   OPTIONS,
%		OPTIONS.GoalsExactAchieve : 置0，线搜索（一维搜索）；置1，满足Wolfe条件的正态线搜索（默认）
%		OPTIONS.GradConstr, 如果梯度调用是CPU代价高昂的（默认），置变量值为真;如置为假，梯度调用多，函数调用少
%	    OPTIONS.HessUpdate : 置为 'bfgs',采用BFGS优化方法（默认），未知量多于3000时，切换到有限内存BFGS方法，
%               与置为'lbfgs'相同；置为 'steepdesc', 采用最陡梯度下降优化方法 
%		OPTIONS.StoreN : 用于L-BFGS中近似Hessian矩阵的迭代次数，默认值20；对不平滑函数，小值可能更好，
%               因为Hessian仅在特定位置有效；对二次式推荐用大值 
%		OPTIONS.GradObj : 如果有梯度，置为 'on'；否则采用有限差分
%     	OPTIONS.Display : 显示的等级。 'off' 不显示输出；'plot'显示图中所有线搜索结果； 
%               'iter'显示每一次迭代的输出；'final'只显示最终输出； 'notify'仅在函数不收敛时显示输出 
%	    OPTIONS.TolX : x的中止容限，默认值 1e-6.
%	    OPTIONS.TolFun : 函数值中止容限，默认值 1e-6.
%		OPTIONS.MaxIter : 最大迭代次数，默认值 400.
% 		OPTIONS.MaxFunEvals : 函数估值最大次数，默认值为未知变量数目100倍
%		OPTIONS.DiffMaxChange : 有限差分梯度用最大步长
%		OPTIONS.DiffMinChange : 有限差分梯度用最小步长
%		OPTIONS.OutputFcn : 用户定义函数，优化器函数在每次迭代时调用
%		OPTIONS.rho : 梯度的Wolfe条件, 默认值 0.01
%		OPTIONS.sigma : 梯度的Wolfe条件, 默认值 0.9 
%		OPTIONS.tau1 : 步长变大时的搜索范围扩展，默认值 3
%		OPTIONS.tau2 : 范围切分阶段（section phase）左边界缩减，默认值 0.1
%		OPTIONS.tau3 : 范围切分阶段（section phase）右边界缩减，默认值 0.5
%   FUN,
%		同时提供X处梯度能改进优化器速度，把 FUN 函数写为如下形式
%   	function [f,g]=FUN(X)
%       	f , X处的值计算;
%   	if ( nargout > 1 )
%       	g , X处的梯度计算
%   	end
%	EXITFLAG,
%		EXITFLAG可能的取值，对应退出条件
%		1, 'Change in the objective function value was less than the specified tolerance TolFun.'
%           （目标函数值变化小于指定的容限TolFun）
%  		2, 'Change in x was smaller than the specified tolerance TolX.';
%           （X变化小于指定容限TolX）
%  		3, 'Magnitude of gradient smaller than the specified tolerance';
%           （梯度值小于指定容限）
%  		4, 'Boundary fminimum reached.'
%           （达到fminimum边界）
%  		0, 'Number of iterations exceeded options. MaxIter or number of function evaluations exceeded options.FunEvals.'
%           （迭代次数超限，MaxIter或者函数估值次数超过options.FunEvals）
%  		-1, 'Algorithm was terminated by the output function.'
%           （输出函数（output）中止了算法）
%  		-2, 'Line search cannot find an acceptable point along the current search';
%           （沿着当前搜索，线搜索无法找到一个可接受点）
%
%   举例
%       options = optimset('GradObj','on');
%       X = fminlbfgs(@myfun,2,options)
%
%   	% 其中 myfun是一个MATLAB函数，例如
%       function [f,g] = myfun(x)
%       f = sin(x) + 3;
%	    if ( nargout > 1 ), g = cos(x); end
%
% See also OPTIMSET, FMINSEARCH, FMINBND, FMINCON, FMINUNC, @, INLINE.
%
% Function is written by D.Kroon University of Twente (Updated Nov. 2010)

% 读优化参数
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
    
% 初始化数据结构
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

% 未知量超过3000时切换到 L-BFGS 方法
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

% 显示各列名称
if(strcmp(optim.Display,'iter'))
     disp('     Iteration  Func-count   Grad-count         f(x)         Step-size');
end

% 计算初始误差与梯度
data.initialStepLength=1;
[data,fval,grad]=gradient_function(data.xInitial,funfcn, data, optim);
data.gradient=grad;
data.dir = -data.gradient;
data.fInitial = fval;
data.fPrimeInitial= data.gradient'*data.dir(:);
data.fOld=data.fInitial;
data.xOld=data.xInitial;
data.gOld=data.gradient;
    
gNorm = norm(data.gradient,Inf);  data.initialStepLength = min(1/gNorm,5);      % 梯度范数
 

% 显示当前迭代信息
if (strcmp(optim.Display,'iter'))
    s=sprintf('     %5.0f       %5.0f       %5.0f       %13.6g    ',data.iteration,data.funcCount,data.gradCount,data.fInitial); disp(s); disp(s);
end
  
% Hessian矩阵初始化
if (optim.HessUpdate(1)=='b'),	data.Hessian=eye(data.numberOfVariables);   end

% 调用输出函数
if (call_output_function(data,optim,'init')),   exitflag=-1;    end
    
% 开始最小化
while(true)
    data.iteration=data.iteration+1;     % 更新迭代次数

    % 置当前线搜索参数
    data.TolFunLnS = eps(max(1,abs(data.fInitial )));
    data.fminimum = data.fInitial - 1e16*(1+abs(data.fInitial));
    
	% 产生存储线搜素结果的数组
    data.storefx=[]; data.storepx=[]; data.storex=[]; data.storegx=[];

    % 如果option显示选项为plot, 开始新图
    if (optim.Display(1)=='p'), figure, hold on; end
		
    % 找到梯度方向合适步长：线搜索
    if (optim.GoalsExactAchieve==1),	data=linesearch(funfcn, data,optim);
    else  data=linesearch_simple(funfcn, data, optim);
    end
	
	% 线搜索绘图
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
	
    % 检查 exitflag 是否设置
    if(~isempty(data.exitflag)),
        exitflag=data.exitflag;     data.xInitial=data.xOld; 
        data.fInitial=data.fOld;    data.gradient=data.gOld;
        break, 
    end;
    
    data.xInitial=data.xInitial+data.alpha*data.dir;                % 用alpha步长更新x
    data.fInitial =  data.f_alpha;  data.gradient = data.grad;      % 置当前误差与梯度
	
    data.initialStepLength = 1;         % 置初始步长为1
    gNorm = norm(data.gradient,Inf);    % 梯度范数
    
    % 置退出标志 
    if (gNorm <optim.TolFun),   exitflag=1;     end
    if (max(abs(data.xOld-data.xInitial)) <optim.TolX),         exitflag=2;     end
    if (data.iteration>=optim.MaxIter),         exitflag=0;     end
    
    if (~isempty(exitflag)), break, end     % 检查退出标志是否设置

    % 更新逆Hessian矩阵
    if (optim.HessUpdate(1)~='s')           % 拟牛顿法更新Hessian矩阵
        data = updateQuasiNewtonMatrix_LBFGS(data,optim);
    else
        data.dir = -data.gradient;
    end
    data.fPrimeInitial= data.gradient'*data.dir(:);     % 方向导数

    % 调用输出函数
    if (call_output_function(data,optim,'iter')),   exitflag=-1;    end
    
    % 显示当前迭代
    if(strcmp(optim.Display(1),'i')||strcmp(optim.Display(1),'p'))
        s=sprintf('     %5.0f       %5.0f       %5.0f       %13.6g   %13.6g',data.iteration,data.funcCount,data.gradCount,data.fInitial,data.alpha); disp(s);
    end
    
    % 保留变量用于下次迭代
    data.fOld=data.fInitial;    data.xOld=data.xInitial;    data.gOld=data.gradient;
end

% 置输出参数，x变形回原来尺寸
fval = data.fInitial;           grad = data.gradient;       x = data.xInitial;      x = reshape(x,data.xsizes);   

if(call_output_function(data,optim,'done')), exitflag=-1;   end     % 调用输出函数

% 形成已有输出结构
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

% 显示最终结果
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

data = bracketingPhase_simple(funfcn, data, optim);     % 寻找可接受点范围
if (data.bracket_exitflag  == 2)                        % BracketingPhase找到包含可接受点范围，现在在范围内找一点
   data = sectioningPhase_simple(funfcn, data, optim);  data.exitflag = data.section_exitflag; 
else   data.exitflag = data.bracket_exitflag;           % 已经找到可接受点，或者达到了MaxFunEvals
end

function data = bracketingPhase_simple(funfcn, data,optim)

itw=0;          % 迭代次数；
data.beta=0;    data.f_beta=data.fInitial;  data.fPrime_beta=data.fPrimeInitial;  % 较小值点，初值
alpha = data.initialStepLength;     % 初始步长等于前面步骤的alpha
hill  = false;  % 登山

% 搜索范围
while(true)
    if(optim.GradConstr)            % 计算配准误差梯度
        [data,f_alpha]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
        fPrime_alpha=nan;           grad=nan;
    else
        [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
        fPrime_alpha = grad'*data.dir(:);
    end
    
	% 存储线搜索值
	data.storefx=[data.storefx f_alpha];    data.storepx=[data.storepx fPrime_alpha]; 
	data.storex=[data.storex alpha];        data.storegx=[data.storegx grad(:)];
    
    % 更新步长值
    if(data.f_beta<f_alpha),    
        alpha=alpha*optim.tau3;             % 换较小步长
        hill=true;                          % 置位 hill变量
    else                                    % 保存当前最小值点
        data.beta=alpha;                    data.f_beta=f_alpha; 
        data.fPrime_beta=fPrime_alpha;      data.grad=grad;
        if (~hill), alpha = alpha*optim.tau1;   end
    end
 
    itw=itw+1;              % 更新迭代循环数，如果没有找到新最佳值，则线搜索失败	
    if (itw>(log(optim.TolFun)/log(optim.tau3))),   data.bracket_exitflag=-2;     break;    end
    
    if (data.beta>0&&hill)  % 围绕最小值确认范围，从存储数据挑出范围A
            [~,i]=sort(data.storex,'ascend');
            storefx=data.storefx(i);    storepx=data.storepx(i);    storex=data.storex(i);
            [~,i]=find(storex>data.beta,1);
            if(isempty(i)),     [~,i]=find(storex==data.beta,1);    end
            alpha=storex(i);            f_alpha=storefx(i);         fPrime_alpha=storepx(i);
            
            % 从存储数据挑出范围B
            [~,i]=sort(data.storex,'descend');
            storefx=data.storefx(i);    storepx=data.storepx(i);    storex=data.storex(i);
            [~,i]=find(storex<data.beta,1);
            if(isempty(i)),     [~,i]=find(storex==data.beta,1);    end
            beta=storex(i);     f_beta=storefx(i);                  fPrime_beta=storepx(i);
            
            % 如果还没有算出导数则计算导数
            if(optim.GradConstr)
                gstep=data.initialStepLength/1e6; 
                if(gstep>optim.DiffMaxChange), gstep=optim.DiffMaxChange; end
                if(gstep<optim.DiffMinChange), gstep=optim.DiffMinChange; end
                [data,f_alpha2]=gradient_function(data.xInitial(:)+(alpha+gstep)*data.dir(:),funfcn, data, optim);
                [data,f_beta2]=gradient_function(data.xInitial(:)+(beta+gstep)*data.dir(:),funfcn, data, optim);
                fPrime_alpha=(f_alpha2-f_alpha)/gstep;
                fPrime_beta=(f_beta2-f_beta)/gstep;
            end

            % 置范围A与B，结束确定范围阶段
            data.a=alpha;   data.f_a=f_alpha;   data.fPrime_a=fPrime_alpha;
            data.b=beta;    data.f_b=f_beta;    data.fPrime_b=fPrime_beta;    
            data.bracket_exitflag  = 2;         return         
    end
	if(data.funcCount>=optim.MaxFunEvals), data.bracket_exitflag=0;     return;     end     % 达到最大函数评估次数
end
    

function data = sectioningPhase_simple(funfcn, data, optim)

brcktEndpntA=data.a; brcktEndpntB=data.b;       % 取到两个范围

% 计算两个范围之间最小值
[alpha,f_alpha_estimated] = pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,data.a,data.b,data.f_a,data.fPrime_a,data.f_b,data.fPrime_b,optim);  
if (isfield(data,'beta')&&(data.f_beta<f_alpha_estimated)), alpha=data.beta;    end

[~,i]=find(data.storex==alpha,1);
if ((~isempty(i))&&(~isnan(data.storegx(i)))),          f_alpha=data.storefx(i);   grad=data.storegx(:,i);
else               % 为下一次最小化迭代计算误差与梯度
    [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
    if(isfield(data,'beta')&&(data.f_beta<f_alpha)),    alpha=data.beta; 
        if ((~isempty(i))&&(~isnan(data.storegx(i)))),  f_alpha=data.storefx(i);    grad=data.storegx(:,i);
        else       [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data,optim);
        end
    end
end

data.storefx=[data.storefx f_alpha];    data.storex=[data.storex alpha];        % 存储值线搜索
fPrime_alpha = grad'*data.dir(:);       data.alpha=alpha;                       
data.fPrime_alpha= fPrime_alpha;        data.f_alpha= f_alpha;  data.grad=grad;

data.section_exitflag=[];               % 置成功退出标志   


function data=linesearch(funfcn, data, optim)

data = bracketingPhase(funfcn, data,optim);         % 找到一个可接受点范围
if   (data.bracket_exitflag  == 2)                  % BracketingPhase找到可接受点范围，在范围内找一个点 
     data = sectioningPhase(funfcn, data, optim);   data.exitflag = data.section_exitflag; 
else data.exitflag = data.bracket_exitflag;         % 已找到可接受点，或者达到最大评估次数（MaxFunEvals）
end

function data = sectioningPhase(funfcn, data, optim)

% sectioningPhase 在包含可接受点的给定范围[a,b]内找到一个可接受点 alpha 
% 注意 funcCount 计数对函数评估总数，包括那些在搜寻范围阶段的评估次数  

while(true)
    
    % 从缩减范围挑出alpha
    brcktEndpntA = data.a + min(optim.tau2,optim.sigma)*(data.b - data.a); 
    brcktEndpntB = data.b - optim.tau3*(data.b - data.a);
    
    % 找到范围[brcktEndpntA,brcktEndpntB]内的3度多项式全局最小化点，多项式在"a" 与"b"内插 f() 与 f'() 
    alpha = pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,data.a,data.b,data.f_a,data.fPrime_a,data.f_b,data.fPrime_b,optim);  

    % 没有发现可接受点
    if (abs( (alpha - data.a)*data.fPrime_a ) <= data.TolFunLnS), data.section_exitflag = -2; return; end
    
    % 计算当前alpha值（如果不另耗时间也计算梯度） 
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
    
	data.storefx=[data.storefx f_alpha];    data.storex=[data.storex alpha];    % 存储值线搜索  
    aPrev = data.a; f_aPrev = data.f_a;     fPrime_aPrev = data.fPrime_a;       % 存储当前范围A位置

    % 更新当前范围
    if ((f_alpha > data.fInitial + alpha*optim.rho*data.fPrimeInitial) || (f_alpha >= data.f_a))
        data.b = alpha; data.f_b = f_alpha; data.fPrime_b = fPrime_alpha;       % 更新范围B为当前alpha
    else                                    % Wolfe 条件，如为真则可接受点找到 
        if (abs(fPrime_alpha) <= -optim.sigma*data.fPrimeInitial), 
            if  (optim.GradConstr)          % 因为时间代价，梯度还没有计算
                [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
                fPrime_alpha = grad'*data.dir(:);
            end    
            data.alpha=alpha;       data.fPrime_alpha= fPrime_alpha;            % 存储找到的alpha值
            data.f_alpha= f_alpha;  data.grad=grad;
            data.section_exitflag = [];     return 
        end
   
        data.a = alpha; data.f_a = f_alpha; data.fPrime_a = fPrime_alpha;       % 更新范围A     
        if (data.b - data.a)*fPrime_alpha >= 0                                  % B成为旧范围A
            data.b = aPrev;    data.f_b = f_aPrev;   data.fPrime_b = fPrime_aPrev;
        end
    end
     
    if (abs(data.b-data.a) < eps), data.section_exitflag = -2;  return,     end             % 无法找到可接受点
    if(data.funcCount >optim.MaxFunEvals), data.section_exitflag = -1;  return,     end     % 达到 maxFunEvals 
end

function data = bracketingPhase(funfcn, data, optim)

% bracketingPhase 找到包含可接受点的范围[a,b]，范围（bracket）与闭合区间一样，但允许 a>b 
% 输出 f_a 与 fPrime_a 是在范围的端点'a'估计的函数值与导数，端点 'b'记号类似 

% 范围A、B的参数
data.a = [];    data.f_a = [];  data.fPrime_a = []; 
data.b = [];    data.f_b = [];  data.fPrime_b = [];

% 首次试探 alpha 由用户提供，f_alpha 包含所有试探点alpha的 f(alpha)；fPrime_alpha 包含所有试探点alpha的 f'(alpha) 
alpha = data.initialStepLength;     f_alpha = data.fInitial;    fPrime_alpha = data.fPrimeInitial;

% 置 alpha最大值（由fminimum 决定)
alphaMax = (data.fminimum - data.fInitial)/(optim.rho*data.fPrimeInitial);  alphaPrev = 0;

while(true) 
  fPrev = f_alpha;  fPrimePrev = fPrime_alpha;      % 评估f(alpha) and f'(alpha)
          
  % 计算当前alpha的函数值(如果没有额外时间消耗也计算梯度） 
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
  
  data.storefx=[data.storefx f_alpha]; data.storex=[data.storex alpha];     % 存储值线搜索 	
  if (f_alpha <= data.fminimum), data.bracket_exitflag = 4; return; end     % 如果 f<fminimum，中止
  
  % 范围定位了，- 情形1 (Wolfe 条件)
  if (f_alpha > (data.fInitial + alpha*optim.rho*data.fPrimeInitial)) || (f_alpha >= fPrev)  % 置范围值，结束搜索范围阶段
     data.a = alphaPrev;     data.f_a = fPrev;       data.fPrime_a = fPrimePrev;
     data.b = alpha;         data.f_b = f_alpha;     data.fPrime_b = fPrime_alpha; 
     data.bracket_exitflag  = 2;    return 
  end

  % 可接受的步长找到了
  if (abs(fPrime_alpha) <= -optim.sigma*data.fPrimeInitial), 
      if(optim.GradConstr)                  % 由于时间消耗，梯度还没有计算
          [data,f_alpha, grad]=gradient_function(data.xInitial(:)+alpha*data.dir(:),funfcn, data, optim);
          fPrime_alpha = grad'*data.dir(:);
      end
     
      data.alpha=alpha;                     % 存储找到的alpha值
      data.fPrime_alpha= fPrime_alpha;      data.f_alpha= f_alpha;      data.grad=grad;
      data.bracket_exitflag = []; return    % 结束搜索范围阶段，没必要调用切分阶段
  end
  
  % 范围定位了，- 情形 2  
  if (fPrime_alpha >= 0)                    % 置范围值，结束搜素范围阶段
    data.a = alpha; data.f_a = f_alpha;     data.fPrime_a = fPrime_alpha;
    data.b = alphaPrev; data.f_b = fPrev;   data.fPrime_b = fPrimePrev;
    data.bracket_exitflag  = 2;   return
  end
 
  % 更新 alpha
  if (2*alpha - alphaPrev < alphaMax )
        brcktEndpntA = 2*alpha-alphaPrev;   brcktEndpntB = min(alphaMax,alpha+optim.tau1*(alpha-alphaPrev));
      
        % 找到3度多项式在范围[brcktEndpntA,brcktEndpntB]的全局最小化点，多项式在alphaPrev点和alpha点内插f()与f'() 
        alphaNew = pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,alphaPrev,alpha,fPrev,fPrimePrev,f_alpha,fPrime_alpha,optim);
        alphaPrev = alpha;    alpha = alphaNew;
  else  alpha = alphaMax;
  end
  if (data.funcCount >optim.MaxFunEvals), data.bracket_exitflag = -1; return, end    % 达到最大评估次数（maxFunEvals）
end

function [alpha,f_alpha]= pickAlphaWithinInterval(brcktEndpntA,brcktEndpntB,alpha1,alpha2,f1,fPrime1,f2,fPrime2,optim)

% 找到在alpha1与alpha2内插f()与f'()的立方多项式（3度多项式），其在范围[brcktEndpntA,brcktEndpntB]内的全局最小化点alpha 
% 这里 f(alpha1) = f1, f'(alpha1) = fPrime1, f(alpha2) = f2, f'(alpha2) = fPrime2

% 确定立方多项式系数，要满足 c(alpha1) = f1, c'(alpha1) = fPrime1, c(alpha2) = f2, c'(alpha2) = fPrime2.
coeff = [(fPrime1+fPrime2)*(alpha2-alpha1)-2*(f2-f1) 3*(f2-f1)-(2*fPrime1+fPrime2)*(alpha2-alpha1) (alpha2-alpha1)*fPrime1 f1];

lowerBound = (brcktEndpntA - alpha1)/(alpha2 - alpha1);             % 边界转换到Z空间
upperBound = (brcktEndpntB - alpha1)/(alpha2 - alpha1);

if (lowerBound  > upperBound), t=upperBound; upperBound=lowerBound; lowerBound=t;   end         % 下界高于上界调换
sPoints = roots([3*coeff(1) 2*coeff(2) coeff(3)]);                  % 从多项式导数的根找出最小值与最大值
sPoints(imag(sPoints)~=0)=[];  sPoints(sPoints<lowerBound)=[];  sPoints(sPoints>upperBound)=[]; % 消除虚根与界外点
sPoints=[lowerBound sPoints(:)' upperBound];                        % 用所有可能解构成向量
[f_alpha,index]=min(polyval(coeff,sPoints));    z=sPoints(index);   % 选择全局最小点
alpha = alpha1 + z*(alpha2 - alpha1);                               % 添加偏置，从[0..1]调整回alpha域

% 显示多项式搜索
if(optim.Display(1)=='p'); 
    vPoints=polyval(coeff,sPoints);
    plot(sPoints*(alpha2 - alpha1)+alpha1,vPoints,'co');
    plot([sPoints(1) sPoints(end)]*(alpha2 - alpha1)+alpha1,[vPoints(1) vPoints(end)],'c*');
    xPoints=linspace(lowerBound/3, upperBound*1.3, 50);
    vPoints=polyval(coeff,xPoints);
    plot(xPoints*(alpha2 - alpha1)+alpha1,vPoints,'c');
end

function [data,fval,grad]=gradient_function(x,funfcn, data, optim)
    
% 调用误差函数处理误差（与梯度）
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
            % 如果函数没有提供，则用前向差分计算梯度
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

% 更新近似逆Hessian矩阵的拟牛顿矩阵。支持两种方法，BFGS与L-BFGS。L-BFGS中，Hessian矩阵不构造或者存储
% 计算位置及各次迭代之间的梯度差异

deltaX = data.alpha* data.dir;  deltaG = data.gradient-data.gOld;
        
if ((deltaX'*deltaG) >= sqrt(eps)*max( eps,norm(deltaX)*norm(deltaG) ))
    if(optim.HessUpdate(1)=='b')        % 默认 BFGS，见 Nocedal描述 
        p_k = 1 / (deltaG'*deltaX);                
        Vk = eye(data.numberOfVariables) - p_k*deltaG*deltaX';
        data.Hessian = Vk'*data.Hessian *Vk + p_k*(deltaX*deltaX');     % 置Hessian矩阵
        data.dir = -data.Hessian*data.gradient;                         % 置新方向
    else                                % 带扩展的L-BFGS，见Nocedal描述
        % 用deltaX与deltaG的历史更新列表 
        data.deltaX(:,2:optim.StoreN)=data.deltaX(:,1:optim.StoreN-1); data.deltaX(:,1)=deltaX;
        data.deltaG(:,2:optim.StoreN)=data.deltaG(:,1:optim.StoreN-1); data.deltaG(:,1)=deltaG; 
        data.nStored=data.nStored+1; 
        if(data.nStored>optim.StoreN), data.nStored=optim.StoreN; end

        a=zeros(1,data.nStored);  p=zeros(1,data.nStored);  q=data.gradient;    % 初始化变量
        for i=1:data.nStored
            p(i)= 1 / (data.deltaG(:,i)'*data.deltaX(:,i));
            a(i) = p(i)* data.deltaX(:,i)' * q;
            q = q - a(i) * data.deltaG(:,i);
        end
        
        % 初始Hessian矩阵（恒等矩阵）扩展，r = - Hessian * gradient
        p_k = data.deltaG(:,1)'*data.deltaX(:,1) / sum(data.deltaG(:,1).^2);  
        r = p_k * q;       
        for i=data.nStored:-1:1,
            b = p(i) * data.deltaG(:,i)' * r;
            r = r + data.deltaX(:,i)*(a(i)-b);
        end
        data.dir = -r;                  % 置新方向
    end
end    
