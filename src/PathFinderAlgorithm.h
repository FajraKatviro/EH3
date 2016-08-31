#ifndef PATHFINDERALGORITHM_H
#define PATHFINDERALGORITHM_H

#include <QObject>

class PathMap;
class QPoint;

template<class T> class QLinkedList;

class PathFinderAlgorithm:public QObject{
    Q_OBJECT
public:
    PathFinderAlgorithm(QObject* parent=0):QObject(parent){}
    virtual ~PathFinderAlgorithm(){}
    virtual void computePath(QLinkedList<QPoint>& path,const QPoint& startPoint, const QPoint& endPoint,const qreal pathWidth,const PathMap& pathMap)=0;
};

#endif // PATHFINDERALGORITHM_H
