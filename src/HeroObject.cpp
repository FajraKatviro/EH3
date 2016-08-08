#include "HeroObject.h"

HeroObject::HeroObject(QObject *parent) : QObject(parent)
{

}

void HeroObject::addSkill(QObject* skill){
    _skills.append(skill);
    emit skillsChanged();
}

QObject* HeroObject::findStat(const QString& statName){
    QObject* ret=nullptr;
    if(!statName.isEmpty()){
        for(QObject* st:_stats.list){
            if(st->property("name").toString()==statName){
                ret=st;
                break;
            }
        }
    }
    return ret;
}

QQmlListProperty<QObject> HeroObject::stats(){
    return _stats.reader(this);
}

QQmlListProperty<QObject> HeroObject::skills(){
    return _skills.reader(this);
}
