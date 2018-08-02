#include "mainwindow.h"
#include <QApplication>

//#include <iostream>
//using namespace std;

#define MAIN    (0)
#define TEST    (1)

#define Run     MAIN

#if (Run==MAIN)
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    MainWindow w;
    w.show();

    return a.exec();
}
#elif (Run==TEST)

#include <QDebug>
#include <QString>
#include <QFileDialog>
#include <QFileInfo>
int main()
{
}


#endif
