#ifndef LISTPROPERTYLAYER_H
#define LISTPROPERTYLAYER_H

#include <QQmlListProperty>

template <class T>
struct ListPropertyLayer{
    QList<T*> list;
    QQmlListProperty<T> reader(QObject* parent){
        return QQmlListProperty<T>(parent,this,&append,&count,&at,&clear);
    }
    void append(T* value){
        list.append(value);
    }
    static void append(QQmlListProperty<T>* property, T* value){
        ListPropertyLayer<T>* layer=static_cast<ListPropertyLayer<T>*>(property->data);
        layer->list.append(value);
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
