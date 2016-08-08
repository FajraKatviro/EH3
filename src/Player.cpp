#include "Player.h"

PlayerBase::PlayerBase(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<QObject> PlayerBase::heroList(){
    return _heroList.reader(this);
}


void PlayerBase::addHero(QObject* value){
    _heroList.append(value);
    emit heroListChanged();
}
