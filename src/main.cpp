#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include <QSize>
#include <QScreen>
#include <QQmlContext>
#include <QMetaObject>

#include <QResource>

#include "BalancedComponent.h"
#include "Player.h"
#include "HeroObject.h"
#include "PathMap.h"
#include "PathFinder.h"
#include "PathFinderAlgorithm.h"
#include "PathFinderAStarAlgorithm.h"

#include "../fkutils/sharedHeaders/loadImageset.h"

#define ADD_QML_TYPE(typeName) qmlRegisterType<typeName>("eh3",1,0,#typeName)
#define ADD_QML_ABSTRACT_TYPE(typeName) qmlRegisterUncreatableType<typeName>("eh3",1,0,#typeName,"abstract class")

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);
    QGuiApplication app(argc, argv);

    QSize baseSize(1280,1024);
    QSize screenSize(app.primaryScreen()->size());

    if(!FKUtility::loadImageset("images",screenSize)){
        qDebug("unable load images");
    }
    if(!FKUtility::loadImageset("skillIcons",screenSize)){
        qDebug("unable load skillIcons");
    }

    FKUtility::ResourceLocator resources;
    if(resources.load("music")!=FKUtility::ResourceLocator::loadingSuccess){
        qDebug("unable load music resource");
    }
    if(!resources.load("models")!=FKUtility::ResourceLocator::loadingSuccess){
        qDebug("unable load models resource");
    }
    if(!resources.load("sprites")!=FKUtility::ResourceLocator::loadingSuccess){
        qDebug("unable load sprites resource");
    }

    qreal sizeSet=std::max(((qreal)screenSize.height())/((qreal)baseSize.height()),
                           ((qreal)screenSize.width ())/((qreal)baseSize.width ()));

    QQmlApplicationEngine engine;

    ADD_QML_TYPE(BalancedComponent);
    ADD_QML_TYPE(PlayerBase);
    ADD_QML_TYPE(HeroObject);
    ADD_QML_TYPE(PathMap);
    ADD_QML_TYPE(PathFinder);

    ADD_QML_ABSTRACT_TYPE(PathFinderAlgorithm);
    ADD_QML_TYPE(PathFinderAStarAlgorithm);

    engine.rootContext()->setContextProperty("sizeSet",sizeSet);
    engine.rootContext()->setContextProperty("baseHeight",baseSize.height());
    engine.rootContext()->setContextProperty("baseWidth",baseSize.width());

    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));
    QMetaObject::invokeMethod(engine.rootObjects().at(0),"show");

    return app.exec();
}

