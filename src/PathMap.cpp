#include "PathMap.h"

#include <QQuickItem>
#include <QQmlProperty>

PathMap::PathMap(QObject *parent) : QObject(parent){

}

void PathMap::rebuildTerrainData(){
    //reset obstacles
    for(auto obstacle=_obstacles.constBegin();obstacle!=_obstacles.constEnd();++obstacle){
        disconnect(obstacle.key(),SIGNAL(relocated(QVariant)),this,SLOT(relocateObstacle(QVariant)));
    }
    _obstacles.clear();
    _wideBend.clear();

    if(_location){
        //clear data
        qreal width=_location->width(), height=_location->height();
        _columnCount = width/_cellSize, _rowCount = height/_cellSize;
        qint32 cellCount=_columnCount*_rowCount;
        _wideBend.fill(1,cellCount);

        //fill obstacles
        for(auto item:_location->childItems()){
            if(QQmlProperty::read(item, "obstacle").toBool()){
                connect(item,SIGNAL(relocated(QVariant)),this,SLOT(relocateObstacle(QVariant)));
                qint32 row=item->y()/_cellSize, col=item->x()/_cellSize;
                _obstacles.insert(item,indexFromPos(col,row));
                fillObstacle(item,0);
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
    qint32 newRow=item->y()/_cellSize;
    qint32 newCol=item->x()/_cellSize;
    qint32 newIndex=indexFromPos(newCol,newRow);
    if(lastIndex!=newIndex){
        Index lastPos=posFromIndex(lastIndex);
        //clear last place
        fillObstacle(item,1,lastPos.x-newRow,lastPos.y-newCol);
        //fill new position
        fillObstacle(item,0);
        //recalculate changed area
        qint32 x=std::max(newCol,lastPos.x), y=std::max(newRow,lastPos.y);
        for(qint32 col=0;col<=x;++col){
            for(qint32 row=0;row<=y;++row){
                qint32 index=indexFromPos(col,row);
                setWideBend(index,calculateWideBend(index));
            }
        }
    }
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
    qint32 row=obstacle->y()/_cellSize, col=obstacle->x()/_cellSize;
    qint32 width=(obstacle->x()+obstacle->width())/_cellSize+1-col,
           height=(obstacle->y()+obstacle->height())/_cellSize+1-row;
    for(qint32 x=0;x<width;++x){
        for(qint32 y=0;y<height;++y){
            setWideBend(indexFromPos(col+x+xShift,row+y+yShift),value);
        }
    }
}

