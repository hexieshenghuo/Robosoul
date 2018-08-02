/****************************************************************************
** Meta object code from reading C++ file 'Detector.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../Detector.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Detector.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Detector_t {
    QByteArrayData data[11];
    char stringdata0[68];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Detector_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Detector_t qt_meta_stringdata_Detector = {
    {
QT_MOC_LITERAL(0, 0, 8), // "Detector"
QT_MOC_LITERAL(1, 9, 11), // "ShowMessage"
QT_MOC_LITERAL(2, 21, 0), // ""
QT_MOC_LITERAL(3, 22, 3), // "Str"
QT_MOC_LITERAL(4, 26, 7), // "Display"
QT_MOC_LITERAL(5, 34, 3), // "img"
QT_MOC_LITERAL(6, 38, 5), // "Clean"
QT_MOC_LITERAL(7, 44, 4), // "Time"
QT_MOC_LITERAL(8, 49, 9), // "ShowCount"
QT_MOC_LITERAL(9, 59, 4), // "good"
QT_MOC_LITERAL(10, 64, 3) // "bad"

    },
    "Detector\0ShowMessage\0\0Str\0Display\0img\0"
    "Clean\0Time\0ShowCount\0good\0bad"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Detector[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   34,    2, 0x06 /* Public */,
       4,    1,   37,    2, 0x06 /* Public */,
       6,    1,   40,    2, 0x06 /* Public */,
       8,    2,   43,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QImage,    5,
    QMetaType::Void, QMetaType::Long,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    9,   10,

       0        // eod
};

void Detector::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Detector *_t = static_cast<Detector *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->ShowMessage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->Display((*reinterpret_cast< QImage(*)>(_a[1]))); break;
        case 2: _t->Clean((*reinterpret_cast< long(*)>(_a[1]))); break;
        case 3: _t->ShowCount((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Detector::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Detector::ShowMessage)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (Detector::*_t)(QImage );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Detector::Display)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (Detector::*_t)(long );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Detector::Clean)) {
                *result = 2;
                return;
            }
        }
        {
            typedef void (Detector::*_t)(int , int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Detector::ShowCount)) {
                *result = 3;
                return;
            }
        }
    }
}

const QMetaObject Detector::staticMetaObject = {
    { &QThread::staticMetaObject, qt_meta_stringdata_Detector.data,
      qt_meta_data_Detector,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Detector::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Detector::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Detector.stringdata0))
        return static_cast<void*>(const_cast< Detector*>(this));
    return QThread::qt_metacast(_clname);
}

int Detector::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QThread::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void Detector::ShowMessage(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Detector::Display(QImage _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Detector::Clean(long _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Detector::ShowCount(int _t1, int _t2)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_END_MOC_NAMESPACE
