#ifndef PATHFINDER_H
#define PATHFINDER_H

#include <QObject>

#include <QPoint>
#include <QLinkedList>

#include "PathMap.h"

class PathFinder : public QObject{
    Q_OBJECT
    Q_PROPERTY(QPoint target READ target WRITE setTarget NOTIFY targetChanged)
    Q_PROPERTY(QPoint nextPos READ nextPos NOTIFY nextPosChanged)
    Q_PROPERTY(QPoint pos READ pos WRITE setPos NOTIFY posChanged)
    Q_PROPERTY(PathMap* pathMap READ pathMap WRITE setPathMap NOTIFY pathMapChanged)
    Q_PROPERTY(bool hasSolution READ hasSolution NOTIFY hasSolutionChanged)
public:
    explicit PathFinder(QObject *parent = 0);

signals:
    void targetChanged();
    void nextPosChanged();
    void posChanged();
    void pathMapChanged();
    void hasSolutionChanged();
    void cellSizeChanged();
private:
    QPoint target()const;
    QPoint nextPos()const;
    QPoint pos()const;
    bool hasSolution()const;
    void setTarget(const QPoint& p);
    void setPos(const QPoint& p);
    QPoint _target;
    QPoint _pos;

    PathMap* pathMap()const;
    void setPathMap(PathMap* pathMap);
    PathMap* _pathMap=nullptr;

    void rebuildPath();
    QLinkedList<QPoint> _path;
};

#endif // PATHFINDER_H
