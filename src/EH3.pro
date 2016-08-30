TEMPLATE = app

QT += qml quick 3dcore 3drender 3dinput 3dlogic
CONFIG += c++11

DESTDIR = $$PWD/../game

INCLUDEPATH += $PWD/src

SOURCES += main.cpp \
    BalancedComponent.cpp \
    Player.cpp \
    HeroObject.cpp \
    PathMap.cpp \
    PathFinder.cpp

RESOURCES += qml.qrc
LARGE_RESOURCES += ../models/models.qrc \
                   ../music/music.qrc   \
                   ../sprites/sprites.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Build imagesets
ART_FOLDER = $$PWD/../art
ART_BUILD_FOLDER = $$OUT_PWD/artBuild
include(../fkutils/fktools/fkimageset.pri)

# Deployment rules
VERSION = 0.0.0
ICON = $$PWD/../icons/icon128x128.png
RC_ICONS = $$PWD/../icons/icon.ico
QMAKE_TARGET_PRODUCT = "EH3_demo"
QMAKE_TARGET_COMPANY = "Fajra Katviro"
LICENSE = $$PWD/../LICENSE
DEPLOY_BUILD_FOLDER = $$OUT_PWD/packageBuild
UPGRADE_CODE = "11b4e5ee-c292-40d8-9458-5be3501ba287"
SHORT_DESCRIPTION = "EH3 demo"
LONG_DESCRIPTION = $$PWD/../description.txt
include(../fkutils/deployTool/fkdeploy.pri)

HEADERS += \
    BalancedComponent.h \
    Player.h \
    ListPropertyLayer.h \
    HeroObject.h \
    PathMap.h \
    PathFinder.h

DISTFILES += MainMenu.jpg

OTHER_FILES += $$LARGE_RESOURCES
