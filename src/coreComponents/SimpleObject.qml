import QtQml 2.2

QtObject{
    id:obj
    //add children property and overwork existing qml bug https://bugreports.qt.io/browse/QTBUG-26810
    property list<QtObject> children
    default property alias childrenProperty:obj.children
}
