#include "rsDataIO.h"

#ifdef QT_VERSION
int rsLoadxmlInformation(QString FileName, QList< QMap<QString,QString> > &MapsList,QString FirstLabelName,QString SecondLabelName)
{
    QFile File(FileName);
    if (!File.open(QFile::ReadOnly | QFile::Text))
    {
        return -1;
    }
    QXmlStreamReader reader(&File);

    QMap<QString,QString> map;

    //开始读取

    for(;!reader.atEnd();)
    {
        reader.readNext();
        if(reader.isStartElement())
        {
            //遇到根元素
            if(reader.name()==FirstLabelName)
            {
                reader.readNext();
                continue;
            }
            if(reader.name()==SecondLabelName)
            {
                reader.readNext();
                map["UnityType"]=SecondLabelName;
                continue;
            }
            map[reader.name().toString()]=reader.readElementText();
        }

        if(reader.isEndElement())
        {
            if(reader.name()==SecondLabelName )
            {
                MapsList.append(map);
                map.clear();
            }
        }
    }

    File.close();

    return 0;
}

int rsShowXMLInformation(QList< QMap<QString,QString> > &Information)
{
    qDebug()<<Information.size();
    for(int i=0;i<Information.size();i++)
    {
        qDebug()<<i<<":";
        QMap<QString,QString> StrList=Information[i];
        QMap<QString,QString>::Iterator   it=StrList.begin();
        //遍历QMap
        for(;it!=StrList.end();++it)
        {
            qDebug()<<"Label:"<<i<<it.key()<<"Value:"<<it.value();
        }
    }
    return 0;
}
#endif

int rsGetFileNamesFromPath(char* Path,vector<string> &FileNames,char* Res)
{
    FileNames.clear();
    struct _finddata_t c_file;//文件结构!
    long hFile;
    string FilePath=Path;//文件路径!
    FilePath+="\\*.";
    FilePath+=Res;
    int Count=0;//文件数!

    if( (hFile = _findfirst( FilePath.c_str(), &c_file )) == -1L)
    {
        return -1;
    }
    else
    {
        string FileName=Path;
        FileName+="\\";
        FileName+=c_file.name;
        //FileName+=Res;
        FileNames.push_back(FileName);
        while( _findnext( hFile, &c_file ) == 0 )
        {
            string FileName=Path;
            FileName+="\\";
            FileName+=c_file.name;
            FileNames.push_back(FileName);
        }
    }
    _findclose( hFile );
    return 0;
}
