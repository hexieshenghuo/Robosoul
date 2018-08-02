#ifndef TRAINWIDGET_H
#define TRAINWIDGET_H

#include <QWidget>
#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextEdit>
#include <QList>
#include <QString>
#include <QFile>
#include <QFileDialog>
#include <QStringList>
#include <QMessageBox>
#include <QTextStream>

#include<RandomForest.h>
#include <Categorizer.h>


class TrainWidget : public QWidget
{
    Q_OBJECT
public:
    explicit TrainWidget(QWidget *parent = 0);
    ~TrainWidget();
    QTextEdit *textEdit;
    QPushButton *LoadBtn;
    QPushButton *SaveFileBtn;
    QPushButton *TrainBtn;
    QPushButton *LoadModelBtn;
    QPushButton *SaveModelBtn;
    QPushButton *TestBtn;
    QLabel *label;

public:
    vector<string>  SamplePath;//样本文件夹名
    vector<int>     SamplePathLabel;

    string SamplePathFileName;
    string HoGFeatParamFileName;
    string RFParamFileName;
    string TestPatch;

public:
    RandomForest* RF;

signals:

public slots:
    int LoadPathText();
    int SavePathText();
    int Train();
    int Train1();
    int Test();
};

#endif // TRAINWIDGET_H
