#include "HeroObject.h"

HeroObject::HeroObject(QObject *parent) : QObject(parent)
{

}

void HeroObject::addSkill(QObject* skill){
    _skills.append(skill);
    emit skillsChanged();
}

QQmlListProperty<QObject> HeroObject::stats(){
    return _stats.reader(this);
}

QQmlListProperty<QObject> HeroObject::skills(){
    return _skills.reader(this);
}
