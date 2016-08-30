#include "PathFinder.h"

PathFinder::PathFinder(QObject *parent):QObject(parent){

}

QPoint PathFinder::target() const{
    return _target;
}

QPoint PathFinder::nextPos() const{
    return _path.isEmpty() ? _pos : _path.first();
}

QPoint PathFinder::pos() const{
    return _pos;
}

bool PathFinder::hasSolution() const{
    return !_path.isEmpty();
}

void PathFinder::setTarget(const QPoint &p){
    qint32 oldX=_target.x()/cellSize(),
           oldY=_target.y()/cellSize(),
           newX=p.x()/cellSize(),
           newY=p.y()/cellSize();
    if(oldX != newX || oldY != newY){
            _target=p;
            emit targetChanged();
            rebuildPath();
    }
}

void PathFinder::setPos(const QPoint &p){
    if(p!=_pos){
        _pos=p;
        if(!_path.isEmpty()){
            const QPoint& next=_path.first();
            qint32 oldX=next.x()/cellSize(),
                   oldY=next.y()/cellSize(),
                   newX=p.x()/cellSize(),
                   newY=p.y()/cellSize();
            if(oldX == newX && oldY == newY){
                    _path.removeFirst();
                    emit nextPosChanged();
                    if(_path.isEmpty())
                        emit hasSolutionChanged();
            }
        }
        emit posChanged();
    }
}

qint32 PathFinder::cellSize() const{
    return _pathMap ? _pathMap->cellSize() : 10;
}

PathMap* PathFinder::pathMap() const{
    return _pathMap;
}

void PathFinder::setPathMap(PathMap *pathMap){
    if(_pathMap!=pathMap){
        _pathMap=pathMap;
        emit pathMapChanged();
        rebuildPath();
    }
}

void PathFinder::rebuildPath(){
    _path.clear();
    _path<<QPoint(200,300)<<QPoint(500,600)<<QPoint(100,900);
    emit nextPosChanged();
    emit hasSolutionChanged();
}
