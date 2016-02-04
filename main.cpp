#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "BalancedComponent.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<BalancedComponent>("eh3",1,0,"BalancedComponent");

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}

