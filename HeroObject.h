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
    void skillAdded(QObject* skill);
public slots:
    void addSkill(QObject* skill);
    QObject* findStat(const QString& statName);
private:
    QQmlListProperty<QObject> stats();
    QQmlListProperty<QObject> skills();

    ListPropertyLayer<QObject> _stats;

    struct SkillPropertyLayer:public ListPropertyLayer<QObject>{
        HeroObject* owner=nullptr;
        virtual QQmlListProperty<QObject> reader(QObject* parent)override{
            owner=static_cast<HeroObject*>(parent);
            return ListPropertyLayer<QObject>::reader(parent);
        }
        virtual void append(QObject* value)override{
            ListPropertyLayer<QObject>::append(value);
            emit owner->skillAdded(value);
        }
    } _skills;

    //friend struct SkillPropertyLayer;
};



#endif // HEROOBJECT_H
