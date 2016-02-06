#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "BalancedComponent.h"
#include "Player.h"
#include "HeroObject.h"

#define ADD_QML_TYPE(typeName) qmlRegisterType<typeName>("eh3",1,0,#typeName)

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ADD_QML_TYPE(BalancedComponent);
    ADD_QML_TYPE(Player);
    ADD_QML_TYPE(HeroObject);

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}

