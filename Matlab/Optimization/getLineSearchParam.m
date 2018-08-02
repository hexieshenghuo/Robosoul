function [ SearchParam] = getLineSearchParam( Method,varargin )
   switch Method
       case 'WolfePowell'
           SearchParam=getWolfeParam();
       case 'Back'
           SearchParam=getBackParam();
       case 'Simple1'
           SearchParam=getSimpleSearch1Param();
       case 'Simple2'
           SearchParam=getSimpleSearch2Param();
       case 'Const' %³£Á¿
           SearchParam.lamda=varargin{1};
       case 'Random'
           SearchParam = getRandomParam();
       otherwise
   end   
   SearchParam.Method=Method;
end

