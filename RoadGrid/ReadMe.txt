
1.   本程序基于Qt5.6开发平台，采用C/C++语言进行编写，可用Qt5.6及以上版本进行运行。Qt开发平台可从百度网盘（ https://pan.baidu.com/s/1WycYsT7h4vAu0H4FJDDtaw 密码：hrki）
或清华镜像站（https://mirrors.tuna.tsinghua.edu.cn/）获取。
      
2.   本程序输入字符串数据工程目录下的RoadGridParam.txt文件中获取。

3.   项目中各个文件介绍：
             main.cpp: 程序的CPP文件
             RoadGridParam.txt: 存储字符串数据
             图片：样例3*3时运行的结果图
             ReadMe:工程运行说明书
             debug和release文件夹：存储记录程序运行的中间过程与结果
             Make类文件：编译类文件
             
4.     main.cpp中函数功能说明：
        int  main():   程序的入口函数
          
        void twLoadProParam(const char* FileName, RoadGridParam* roadgrid) ：从RoadGridParam.txt中加载字符串数据
       
        int twGetStringVector(vector<string> &StrVector, const char* FileName) ：从RoadGridParam.txt中读取数据

        void twCheckInputValidity(vector<string> Strs)：检验输入的有效性

       void twMazeFactory(RoadGridParam*roadgrid)：迷宫Maze生成与显示的主函数

       void twGetCell(string str,vector<Cell>*first,vector<Cell>*second)：获取RoadGrid中连通Cell的坐标点

       void twGetRenderGrid(vector<vector<string>>&maze,int m,int n)：获取原始渲染网络RenderGrid

       void twGetMaze( vector<vector<string>>&maze,vector<Cell>&first, vector<Cell>&second): //初始RenderGrid+连通规则=最后的maze

 5.    备注：
        运行过过程中出现问题请联系我，电话：13578553727   邮箱：2402951977@qq.com      
        



     
