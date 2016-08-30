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
    if((int)(_target.x/_pathMap->cellSize()) != (int)(p.x/_pathMap->cellSize()) ||
       (int)(_target.y/_pathMap->cellSize()) != (int)(p.y/_pathMap->cellSize())){
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
            if((int)(next.x/_pathMap->cellSize()) == (int)(p.x/_pathMap->cellSize()) &&
               (int)(next.y/_pathMap->cellSize()) == (int)(p.y/_pathMap->cellSize())){
                    _path.removeFirst();
                    emit nextPosChanged();
                    if(_path.isEmpty())
                        emit hasSolutionChanged();
            }
        }
        emit posChanged();
    }
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
