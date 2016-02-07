#include "BalancedComponent.h"

BalancedComponent::BalancedComponent(QObject* parent)
    :QObject(parent){

}

void BalancedComponent::refreshBalance(){
    qreal newSum=0.0;
    for(BalancedComponent* child:_childComponents){
        newSum+=child->_importance;
    }
    if(newSum!=_childrenImportanceBalance){
        _childrenImportanceBalance=newSum;
        emit childrenImportanceBalanceChanged();
    }
}

void BalancedComponent::addBalancedChild(BalancedComponent* value){
    if(!_childComponents.contains(value)){
        _childComponents.append(value);
        value->setParentBalancedComponent(this);
        refreshBalance();
        emit childBalancedComponentsChanged();
    }
}

BalancedComponent* BalancedComponent::parentBalancedComponent() const{
    return _parentComponent;
}

QQmlListProperty<BalancedComponent> BalancedComponent::childBalancedComponents(){
    return QQmlListProperty<BalancedComponent>(this,nullptr,&addBalancedChild,&countBalancedChildren,&getBalancedChild,&clearBalancedChildren);
}

qreal BalancedComponent::importance() const{
    return _importance;
}

qreal BalancedComponent::childrenImportanceBalance() const{
    return _childrenImportanceBalance;
}

void BalancedComponent::setParentBalancedComponent(BalancedComponent* parent){
    if(_parentComponent!=parent){
        _parentComponent=parent;
        emit parentBalancedComponentChanged();
    }
}

void BalancedComponent::setImportance(qreal arg){
    if(_importance!=arg){
        _importance=arg;
        emit importanceChanged();
        if(_parentComponent){
            _parentComponent->refreshBalance();
        }
    }
}

void BalancedComponent::addBalancedChild(QQmlListProperty<BalancedComponent>* property, BalancedComponent* value){
    BalancedComponent* obj=static_cast<BalancedComponent*>(property->object);
    obj->_childComponents.append(value);
    value->setParentBalancedComponent(obj);
    obj->refreshBalance();
}

BalancedComponent* BalancedComponent::getBalancedChild(QQmlListProperty<BalancedComponent>* property, int index){
    BalancedComponent* obj=static_cast<BalancedComponent*>(property->object);
    return obj->_childComponents.at(index);
}

int BalancedComponent::countBalancedChildren(QQmlListProperty<BalancedComponent>* property){
    BalancedComponent* obj=static_cast<BalancedComponent*>(property->object);
    return obj->_childComponents.count();
}

void BalancedComponent::clearBalancedChildren(QQmlListProperty<BalancedComponent>* property){
    BalancedComponent* obj=static_cast<BalancedComponent*>(property->object);
    for(BalancedComponent* child:obj->_childComponents){
        child->setParentBalancedComponent(nullptr);
    }
    obj->_childComponents.clear();
    obj->_childrenImportanceBalance=0.0;
}

