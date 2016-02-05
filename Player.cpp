#include "Player.h"

Player::Player(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<QObject> Player::heroList(){
    return _heroList.reader(this);
}


void Player::addHero(QObject* value){
    _heroList.append(value);
    emit heroListChanged();
}
