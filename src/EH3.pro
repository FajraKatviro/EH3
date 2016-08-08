TEMPLATE = app

QT += qml quick
CONFIG += c++11

INCLUDEPATH += $PWD/src

SOURCES += main.cpp \
    BalancedComponent.cpp \
    Player.cpp \
    HeroObject.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    BalancedComponent.h \
    Player.h \
    ListPropertyLayer.h \
    HeroObject.h

DISTFILES += MainMenu.jpg

