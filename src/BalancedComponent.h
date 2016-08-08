#ifndef BALANCEDCOMPONENT_H
#define BALANCEDCOMPONENT_H

#include <QObject>
#include <QQmlListProperty>

class BalancedComponent : public QObject{
    Q_OBJECT
    Q_PROPERTY(BalancedComponent* parentBalancedComponent READ parentBalancedComponent WRITE setParentBalancedComponent NOTIFY parentBalancedComponentChanged)
    Q_PROPERTY(QQmlListProperty<BalancedComponent> childBalancedComponents READ childBalancedComponents NOTIFY childBalancedComponentsChanged)
    Q_PROPERTY(qreal importance READ importance WRITE setImportance NOTIFY importanceChanged)
    Q_PROPERTY(qreal childrenImportanceBalance READ childrenImportanceBalance NOTIFY childrenImportanceBalanceChanged)
    Q_CLASSINFO("DefaultProperty", "childBalancedComponents")
public:
    explicit BalancedComponent(QObject *parent = 0);
signals:
    void parentBalancedComponentChanged();
    void childBalancedComponentsChanged();
    void importanceChanged();
    void childrenImportanceBalanceChanged();
public slots:
    void refreshBalance();
    void addBalancedChild(BalancedComponent* value);
    void removeBalancedChild(qint32 index);
private:
    BalancedComponent* parentBalancedComponent()const;
    QQmlListProperty<BalancedComponent> childBalancedComponents();
    qreal importance()const;
    qreal childrenImportanceBalance()const;

    void setParentBalancedComponent(BalancedComponent* parent);
    void setImportance(qreal arg);

    static void addBalancedChild(QQmlListProperty<BalancedComponent>* property,BalancedComponent* value);
    static BalancedComponent* getBalancedChild(QQmlListProperty<BalancedComponent>* property,int index);
    static int countBalancedChildren(QQmlListProperty<BalancedComponent>* property);
    static void clearBalancedChildren(QQmlListProperty<BalancedComponent>* property);

    qreal _importance=0.0;
    qreal _childrenImportanceBalance=0.0;
    BalancedComponent* _parentComponent=nullptr;
    QList<BalancedComponent*> _childComponents;
};

#endif
