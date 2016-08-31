#ifndef PATHFINDERASTARALGORITHM_H
#define PATHFINDERASTARALGORITHM_H

#include "PathFinderAlgorithm.h"

class PathFinderAStarAlgorithm : public PathFinderAlgorithm{
    Q_OBJECT
public:
    PathFinderAStarAlgorithm(QObject* parent=0):PathFinderAlgorithm(parent){}
    virtual void computePath(QLinkedList<QPoint>& path, const QPoint& startPoint, const QPoint& endPoint, const qreal pathWidth, const PathMap &pathMap) override;
private:
    struct Node;
};

#endif // PATHFINDERASTARALGORITHM_H
