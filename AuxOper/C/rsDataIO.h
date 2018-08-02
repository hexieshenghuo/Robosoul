
#ifndef RS_USE_QT
   #define RS_USE_QT   528
#endif

#ifdef RS_USE_QT
 #include <QMap>
 #include <QString>
 #include <QList>
 #include <QXmlStreamReader>
 #include <QFile>
 #include <QDebug>
 #else

#endif

#include <vector>

#ifdef QT_VERSION
//从XML中导入信息目前只可以导入两层格式
int rsLoadxmlInformation(QString FileName, QList< QMap<QString,QString> > &MapsList,QString FirstLabelName, QString SecondLabelName);

//显示Information
int rsShowXMLInformation(QList< QMap<QString,QString> > &Information);
#endif


