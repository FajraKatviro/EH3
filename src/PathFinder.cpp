#include "PathFinder.h"

#include "PathFinderAlgorithm.h"

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
                qint32 requiredSpace=std::ceil( _pathWidth / cellSize() );
                if(_pathMap && _pathMap->getWideBend(_path.first().x(),_path.first().y())>=requiredSpace){
                    emit nextPosChanged();
                    if(_path.isEmpty()){
                        emit hasSolutionChanged();
                    }
                }else{
                    rebuildPath();
                }
            }
        }
        emit posChanged();
    }
}

qint32 PathFinder::cellSize() const{
    return _pathMap ? _pathMap->cellSize() : 10;
}

qreal PathFinder::pathWidth() const{
    return _pathWidth;
}

void PathFinder::setPathWidth(const qreal pathWidth){
    if(_pathWidth!=pathWidth){
        _pathWidth=pathWidth;
        emit pathWidthChanged();
    }
}

PathMap* PathFinder::pathMap() const{
    return _pathMap;
}

void PathFinder::setPathMap(PathMap *pathMap){
    if(_pathMap!=pathMap){
        if(_pathMap){
            disconnect(_pathMap,SIGNAL(locationChanged()),this,SLOT(rebuildPath()));
        }
        _pathMap=pathMap;
        if(_pathMap){
            connect(_pathMap,SIGNAL(locationChanged()),this,SLOT(rebuildPath()));
        }
        emit pathMapChanged();
        rebuildPath();
    }
}

PathFinderAlgorithm* PathFinder::algorithm() const{
    return _algorithm;
}

void PathFinder::setAlgorithm(PathFinderAlgorithm *algorithm){
    if(_algorithm!=algorithm){
        _algorithm=algorithm;
        emit algorithmChanged();
        rebuildPath();
    }
}

void PathFinder::rebuildPath(){
   if(!_algorithm){
       qDebug("unable rebuild path: algorithm is not set");
       return;
   }
   if(!_pathMap){
       qDebug("unable rebuild path: path map is not not set");
       return;
   }
   if(_pathMap->isEmpty()){
       qDebug("unable rebuild path: path map is empty");
       return;
   }
   _path.clear();
    _algorithm->computePath(_path,_pos,_target,_pathWidth,*_pathMap);
    emit nextPosChanged();
    emit hasSolutionChanged();
}
