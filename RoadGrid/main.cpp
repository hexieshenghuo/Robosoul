#include<stdio.h>
#include<string>
#include<vector>
#include<iostream>
#include <fstream>

using namespace std;

struct Cell{
    int x;
    int y;
};

struct RoadGridParam{
    int m;
    int n;
    string str;
};

//从文件中读取数据
int twGetStringVector(vector<string> &StrVector, const char* FileName)
{
    fstream File(FileName,ios::in);//只读方式打开!
    if (!File.is_open())
    {
        return -1;
    }
    string Str;
    StrVector.clear();//清理!
    for (;getline(File,Str);)//读取一行字符!
    {
        StrVector.push_back(Str);
    }
    File.close();
    return 0;
}

//获取连通RoadGrid中Cell的坐标点
void twGetCell(string str,vector<Cell>*first,vector<Cell>*second)
{
    int length =str.length();
    Cell temp_first,temp_second;
    for(int i=0;i<(length+1);i+=8)
    {
       temp_first.x=str[i]-'0';
       temp_first.y=str[i+2]-'0';
//       cout<<"a: "<<temp_first.x<<" "<<"b: "<<temp_first.y<<endl;
       if(temp_first.x<0||temp_first.y<0)
       {
           cout<<"Number out of range​."<<endl;
       }
       else{
           first->push_back(temp_first);
       }

       temp_second.x=str[i+4]-'0';
       temp_second.y=str[i+6]-'0';
//       cout<<"c: "<<temp_second.x<<" "<<"d: "<<temp_second.y<<endl;
       if(temp_second.x<0||temp_second.y<0)
       {
           cout<<"Number out of range​."<<endl;
       }
       else{
           second->push_back(temp_second);
       }
    }
//    cout<<"first: "<<first->size()<<" "<<"second: "<<second->size()<<endl;
}

//检查输入的有效性
void twCheckInputValidity(vector<string> Strs)
{
    for(int i=0;i<Strs.size();i++)
    {
        if(Strs[i].empty())
        {
            cout<<"  NO INPUT！！！ "<<endl;
        }
    }

    for(int j=0;j<Strs[0].length();j++)
    {
        if(Strs[0][0]>'9'||Strs[0][0]<'0'||Strs[0][1]>'9'||Strs[0][0]<'0')
        {
            cout<<"Invalid number format."<<endl;
        }
    }

    for(int k=0;k<Strs[1].length();k+=8)
    {
        if(Strs[1][k]>'9'||Strs[1][k]<'0'||Strs[1][k+2]>'9'||Strs[1][k+2]<'0'||Strs[1][k+4]>'9'||Strs[1][k+4]<'0'||Strs[1][k+6]>'9'||Strs[1][k+6]<'0')
        {
            cout<<"Invalid number format."<<endl;
        }
    }
}

//加载输入参数
void twLoadProParam(const char* FileName, RoadGridParam* roadgrid)
{
    vector<string> Strs;
    twGetStringVector(Strs,FileName);

    twCheckInputValidity(Strs);

    sscanf(Strs[0].c_str(),"%d %d\n",&roadgrid->m,&roadgrid->n);
    roadgrid->str=Strs[1];

    if(roadgrid->m<0||roadgrid->n<0)
    {
          cout<<"Number out of range."<<endl;
    }
}

//获取原始渲染网络
void twGetRenderGrid(vector<vector<string>>&maze,int m,int n)
{
    maze.resize(m*2+1);
    for(int i=0;i<maze.size();i++)
    {
        maze[i].resize(n*2+1);
    }

    int num=0;
    for(int i=0;i<maze.size();i++)
    {
        for(int j=0;j<maze[i].size();j++)
        {
          if(i%2!=0&&j%2!=0)
          {
            maze[i][j]="[R]";

         }
         else {
             maze[i][j]="[W]";
        }

          num++;
          if(num%maze[i].size()==0)
          {
             cout<<maze[i][j]<<" "<<endl;
          }
          else
          {
           cout<<maze[i][j]<<" ";
          }
        }
   }
}

//初始RenderGrid+连通规则=最后的maze
void twGetMaze( vector<vector<string>>&maze,vector<Cell>&first, vector<Cell>&second)
{
//  cout<<"M: "<<maze.size()<<"F: "<<first[8].x<<"S: "<<second.size()<<endl;//值已传到此

  vector<Cell>RFirst,RSecond;
  Cell temp_RFirst,temp_RSecond;
  for(int i=0;i<first.size();i++)
  {
    //将RoadGrid中Cell坐标 映射到 RenderGrid中的Cell坐标
    temp_RFirst.x=2*first[i].x+1;
    temp_RFirst.y=2*first[i].y+1;
    RFirst.push_back(temp_RFirst);

    temp_RSecond.x=2*second[i].x+1;
    temp_RSecond.y=2*second[i].y+1;
    RSecond.push_back(temp_RSecond);
  }

//  cout<<"RF: "<<RFirst[0].y<<" "<<"RS: "<<RSecond.size()<<endl;

  for(int i=0;i<first.size();i++)
  {
      if(RFirst[i].x-RSecond[i].x==2&&RFirst[i].y-RSecond[i].y==0)
      {
//         cout<<"up"<<endl;
         maze[RFirst[i].x-1][RFirst[i].y]="[R]";
      }
      else if (RFirst[i].x-RSecond[i].x==-2&&RFirst[i].y-RSecond[i].y==0)
      {
//          cout<<"down"<<endl;
          maze[RFirst[i].x+1][RFirst[i].y]="[R]";
      }
      else if (RFirst[i].x-RSecond[i].x==0&&RFirst[i].y-RSecond[i].y==2)
      {
//          cout<<"right"<<endl;
          maze[RFirst[i].x][RFirst[i].y-1]="[R]";
      }
      else if (RFirst[i].x-RSecond[i].x==0&&RFirst[i].y-RSecond[i].y==-2)
      {
//         cout<<"left"<<endl;
         maze[RFirst[i].x][RFirst[i].y+1]="[R]";
      }
      else
         {
          cout<<" "<<endl;
          cout<<"Maze format error."<<endl;  //连通性错误提示标语
      }
  }
}

//迷宫maze生成及显示主函数
void twMazeFactory(RoadGridParam*roadgrid)
{
     int m=roadgrid->m;
     int n=roadgrid->n;
     string str=roadgrid->str;

     vector<Cell>cell1;
     vector<Cell>cell2;

     twGetCell(str,&cell1,&cell2);

//     cout<<"cell1:  "<<cell1.size()<<" "<<"cell2: "<<cell2.size()<<endl;//查看cell1 cell2是否有值

     vector<vector<string>>maze;

     cout<<"Rendergrid:"<<endl;
     twGetRenderGrid(maze,m,n);

//     cout<<"maze: "<<maze.size()<<endl;//查看maze是否有值

     twGetMaze(maze,cell1,cell2);
     cout<<"  "<<endl;
     cout<<"Maze: "<<endl;
     int NUM=0;
     for(int i=0;i<2*m+1;i++)
     {
         for(int j=0;j<2*n+1;j++)
         {
             NUM++;
             if(NUM%maze[i].size()==0)
             {
                cout<<maze[i][j]<<" "<<endl;
             }
             else
             {
              cout<<maze[i][j]<<" ";
             }
         }
     }
}
//程序入口
int main()
{
    const char* FileName="RoadGridParam.txt";  //加载输入文件
    RoadGridParam*roadgrid = new RoadGridParam;
    twLoadProParam(FileName,roadgrid);
    cout<<"m: "<<roadgrid->m<<endl;
    cout<<"n: "<<roadgrid->n<<endl;
    cout<<"connectedness: "<<roadgrid->str<<endl;

    cout<<" "<<endl;

    twMazeFactory(roadgrid);

    return 0;
}
