#include "ImageWidget.h"

ImageWidget::ImageWidget(QWidget *parent) : QWidget(parent)
{
    Display=new QLabel(this);
//    Display->setGeometry(0,0,this->width(),this->height());
}
