#ifndef HEROOBJECT_H
#define HEROOBJECT_H

#include <QObject>

#include "ListPropertyLayer.h"

class HeroObject : public QObject{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<QObject> stats READ stats NOTIFY statsChanged)
    Q_PROPERTY(QQmlListProperty<QObject> skills READ skills NOTIFY skillsChanged)
public:
    explicit HeroObject(QObject *parent = 0);
signals:
    void statsChanged();
    void skillsChanged();
public slots:
    void addSkill(QObject* skill);
private:
    QQmlListProperty<QObject> stats();
    QQmlListProperty<QObject> skills();

    ListPropertyLayer<QObject> _stats;
    ListPropertyLayer<QObject> _skills;
};

#endif // HEROOBJECT_H
