#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include <QSize>
#include <QScreen>
#include <QQmlContext>
#include <QMetaObject>

#include "BalancedComponent.h"
#include "Player.h"
#include "HeroObject.h"

#include "../fkutils/sharedHeaders/loadImageset.h"

#define ADD_QML_TYPE(typeName) qmlRegisterType<typeName>("eh3",1,0,#typeName)

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);
    QGuiApplication app(argc, argv);

    QSize baseSize(600,400);
    QSize screenSize(app.primaryScreen()->size());

    if(!FKUtility::loadImageset("images",screenSize)){
        qDebug("unable load images");
    }
    if(!FKUtility::loadImageset("skillIcons",screenSize)){
        qDebug("unable load skillIcons");
    }

    qreal sizeSet=std::max(((qreal)screenSize.height())/((qreal)baseSize.height()),
                           ((qreal)screenSize.width ())/((qreal)baseSize.width ()));

    QQmlApplicationEngine engine;

    ADD_QML_TYPE(BalancedComponent);
    ADD_QML_TYPE(PlayerBase);
    ADD_QML_TYPE(HeroObject);

    engine.rootContext()->setContextProperty("sizeSet",sizeSet);
    engine.rootContext()->setContextProperty("baseHeight",baseSize.height());
    engine.rootContext()->setContextProperty("baseWidth",baseSize.width());

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));
    QMetaObject::invokeMethod(engine.rootObjects().at(0),"show");

    return app.exec();
}

