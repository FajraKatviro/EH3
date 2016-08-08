#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <QList>
#include <QQmlListProperty>

#include "ListPropertyLayer.h"

class PlayerBase : public QObject{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<QObject> heroList READ heroList NOTIFY heroListChanged)
public:
    explicit PlayerBase(QObject *parent = 0);
signals:
    void heroListChanged();
public slots:
    void addHero(QObject* value);
private:
    QQmlListProperty<QObject> heroList();

    ListPropertyLayer<QObject> _heroList;
};

#endif // PLAYER_H
