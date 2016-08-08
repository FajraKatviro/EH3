#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "BalancedComponent.h"
#include "Player.h"
#include "HeroObject.h"

#define ADD_QML_TYPE(typeName) qmlRegisterType<typeName>("eh3",1,0,#typeName)

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ADD_QML_TYPE(BalancedComponent);
    ADD_QML_TYPE(PlayerBase);
    ADD_QML_TYPE(HeroObject);

    //engine.load(QUrl(QStringLiteral("../EH3/main.qml")));
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}

