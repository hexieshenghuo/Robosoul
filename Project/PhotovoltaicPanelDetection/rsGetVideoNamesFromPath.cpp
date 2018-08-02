#include<iostream>
#include<vector>
#include<io.h>
#include<string>

using namespace std;

int rsGetVideoNamesFromPath(char* Path,vector<string> &VideoNames)
{
    VideoNames.clear();
    struct _finddata_t c_file;
    long handle_File;

    string FilePath=Path;
    FilePath+="\\*.avi";

    if( (handle_File = _findfirst( FilePath.c_str(), &c_file )) == -1L)
    {
        return -1;
    }
    else
    {
        string FileName=Path;
        FileName+="\\";
        FileName+=c_file.name;
        VideoNames.push_back(FileName);
        while( _findnext( handle_File, &c_file ) == 0 )
        {
            string FileName=Path;
            FileName+="\\";
            FileName+=c_file.name;
            VideoNames.push_back(FileName);
        }
    }
    _findclose( handle_File );
    return 0;
}
int main()
{
  char*path="D:\\test\\3";
  vector<string> VideoNames;
  rsGetVideoNamesFromPath(path,VideoNames);

  for(int i=0;i<VideoNames.size();i++)
  {
      cout<<VideoNames[i]<<endl;
  }
  return 0;
}
