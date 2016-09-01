#include "PathMap.h"

#include <QQuickItem>
#include <QQmlProperty>

PathMap::PathMap(QObject *parent) : QObject(parent){

}

QVector<qint32> PathMap::getTerrainSpace(const qint32 x, const qint32 y, const qint32 width, const qint32 height, QQuickItem *walker) const{

}

void PathMap::rebuildTerrainData(){
    //reset obstacles
    for(auto obstacle=_obstacles.constBegin();obstacle!=_obstacles.constEnd();++obstacle){
        disconnect(obstacle.key(),SIGNAL(relocated(QVariant)),this,SLOT(relocateObstacle(QVariant)));
    }
    _obstacles.clear();
    _wideBend.clear();

    //reset walkers
    for(auto walker=_walkers.constBegin();walker!=_walkers.constEnd();++walker){
        disconnect(walker.value(),SIGNAL(relocated(QVariant)),this,SLOT(relocateWalker(QVariant)));
    }
    _walkers.clear();

    if(_location){
        //clear data
        qreal width=_location->width(), height=_location->height();
        _columnCount = toCellCoordinate(width), _rowCount = toCellCoordinate(height);
        qint32 cellCount=_columnCount*_rowCount;
        _wideBend.fill(1,cellCount);

        //fill obstacles
        for(auto item:_location->childItems()){
            if(QQmlProperty::read(item, "obstacle").toBool()){
                if(QQmlProperty::read(item, "walker").toBool()){
                    connect(item,SIGNAL(relocated(QVariant)),this,SLOT(relocateWalker(QVariant)));
                    addWalker(item);
                }else{
                    connect(item,SIGNAL(relocated(QVariant)),this,SLOT(relocateObstacle(QVariant)));
                    qint32 row=toCellCoordinate(item->y()), col=toCellCoordinate(item->x());
                    _obstacles.insert(item,indexFromPos(col,row));
                    fillObstacle(item,0);
                }
            }
        }

        //calculate wide bends
        for(qint32 i=0;i<cellCount;++i){
            setWideBend(i,calculateWideBend(i));
        }
    }else{
        qDebug("unable rebuild terrain data for null location");
    }
}

void PathMap::relocateObstacle(const QVariant obstacle){
    QQuickItem* item=qobject_cast<QQuickItem*>(obstacle.value<QObject*>());
    qint32 lastIndex=_obstacles.value(item,-1);
    qint32 newRow=toCellCoordinate(item->y());
    qint32 newCol=toCellCoordinate(item->x());
    qint32 newIndex=indexFromPos(newCol,newRow);
    if(lastIndex!=newIndex){
        _obstacles[item]=newIndex;
        Index lastPos=posFromIndex(lastIndex);
        //clear last place
        fillObstacle(item,1,lastPos.x-newCol,lastPos.y-newRow);
        //fill new position
        fillObstacle(item,0);
        //recalculate changed area
        qint32 width=toCellCoordinate(item->width()),
               height=toCellCoordinate(item->height());
        qint32 x=std::max(newCol,lastPos.x)+width, y=std::max(newRow,lastPos.y)+height;
        for(qint32 col=0;col<=x;++col){
            for(qint32 row=0;row<=y;++row){
                qint32 index=indexFromPos(col,row);
                setWideBend(index,calculateWideBend(index));
            }
        }
    }
}

void PathMap::relocateWalker(const QVariant walker){

}

qint32 PathMap::calculateWideBend(const qint32 index) const{
    auto pos=posFromIndex(index);
    if(getWideBend(index)==0)
        return 0;

    qint32 wideBend = 0;
    bool obstacleFound = false;
    while(!obstacleFound){
        ++wideBend;
        for(qint32 shift=0;shift<=wideBend;++shift){
            if(getWideBend(pos.x+shift,pos.y+wideBend)==0 ||
               getWideBend(pos.x+wideBend,pos.y+shift)==0){
                obstacleFound=true;
                break;
            }
        }
    }

    return wideBend;
}

void PathMap::fillObstacle(QQuickItem *obstacle, const qint32 value, const qint32 xShift, const qint32 yShift){
    qint32 row=toCellCoordinate(obstacle->y()),
           col=toCellCoordinate(obstacle->x()),
           width=toCellCoordinate(obstacle->width()),
           height=toCellCoordinate(obstacle->height());
    for(qint32 x=0;x<width;++x){
        for(qint32 y=0;y<height;++y){
            setWideBend(indexFromPos(col+x+xShift,row+y+yShift),value);
        }
    }
}

void PathMap::addWalker(QQuickItem *walker){
    qint32 row=toCellCoordinate(walker->y()),
           col=toCellCoordinate(walker->x()),
           width=toCellCoordinate(walker->width()),
           height=toCellCoordinate(walker->height());
    for(qint32 x=0;x<width;++x){
        for(qint32 y=0;y<height;++y){
            _walkers.insert(indexFromPos(col,row),walker);
        }
    }
}

