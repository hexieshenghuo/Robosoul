/****************************************************************************
** Meta object code from reading C++ file 'pvDetector.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../pvDetector.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'pvDetector.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_pvDetector_t {
    QByteArrayData data[7];
    char stringdata0[53];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_pvDetector_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_pvDetector_t qt_meta_stringdata_pvDetector = {
    {
QT_MOC_LITERAL(0, 0, 10), // "pvDetector"
QT_MOC_LITERAL(1, 11, 11), // "ShowMessage"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 3), // "Str"
QT_MOC_LITERAL(4, 28, 7), // "Display"
QT_MOC_LITERAL(5, 36, 3), // "img"
QT_MOC_LITERAL(6, 40, 12) // "ClearMessage"

    },
    "pvDetector\0ShowMessage\0\0Str\0Display\0"
    "img\0ClearMessage"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_pvDetector[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   29,    2, 0x06 /* Public */,
       4,    1,   32,    2, 0x06 /* Public */,
       6,    0,   35,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QImage,    5,
    QMetaType::Void,

       0        // eod
};

void pvDetector::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        pvDetector *_t = static_cast<pvDetector *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->ShowMessage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->Display((*reinterpret_cast< QImage(*)>(_a[1]))); break;
        case 2: _t->ClearMessage(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (pvDetector::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&pvDetector::ShowMessage)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (pvDetector::*_t)(QImage );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&pvDetector::Display)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (pvDetector::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&pvDetector::ClearMessage)) {
                *result = 2;
                return;
            }
        }
    }
}

const QMetaObject pvDetector::staticMetaObject = {
    { &QThread::staticMetaObject, qt_meta_stringdata_pvDetector.data,
      qt_meta_data_pvDetector,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *pvDetector::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *pvDetector::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_pvDetector.stringdata0))
        return static_cast<void*>(const_cast< pvDetector*>(this));
    return QThread::qt_metacast(_clname);
}

int pvDetector::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QThread::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void pvDetector::ShowMessage(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void pvDetector::Display(QImage _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void pvDetector::ClearMessage()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
