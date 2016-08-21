#ifndef LISTPROPERTYLAYER_H
#define LISTPROPERTYLAYER_H

#include <QQmlListProperty>

template <class T>
struct ListPropertyLayer{
    QList<T*> list;
    virtual ~ListPropertyLayer(){}
    virtual QQmlListProperty<T> reader(QObject* parent){
        QQmlListProperty<T> prop(parent,this,&ListPropertyLayer<T>::append,&ListPropertyLayer<T>::count,&ListPropertyLayer<T>::at,&ListPropertyLayer<T>::clear);
        return prop;
    }
    virtual void append(T* value){
        list.append(value);
    }
    static void append(QQmlListProperty<T>* property, T* value){
        ListPropertyLayer<T>* layer=static_cast<ListPropertyLayer<T>*>(property->data);
        layer->append(value);
    }
    static T* at(QQmlListProperty<T>* property,int index){
        ListPropertyLayer<T>* layer=static_cast<ListPropertyLayer<T>*>(property->data);
        return layer->list.at(index);
    }
    static int count(QQmlListProperty<T>* property){
        ListPropertyLayer<T>* layer=static_cast<ListPropertyLayer<T>*>(property->data);
        return layer->list.count();
    }
    static void clear(QQmlListProperty<T>* property){
        ListPropertyLayer<T>* layer=static_cast<ListPropertyLayer<T>*>(property->data);
        layer->list.clear();
    }
};

#endif // LISTPROPERTYLAYER_H
