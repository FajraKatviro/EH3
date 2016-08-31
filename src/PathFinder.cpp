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
        _pathMap=pathMap;
        emit pathMapChanged();
        rebuildPath();
    }
}

void PathFinder::getPathWithAStarAlgorithm(){

    if(!_pathMap){
        qDebug("unable find path: path map is null");
        return;
    }

    struct Node{
        qint32 x=0;
        qint32 y=0;
        qint32 wideBend=10;
        qint32 g=0;
        qint32 h=0;
        qint32 f=0;
        Node* parent=nullptr;
        bool opened=false;
        bool closed=false;
        void computeScores(const Node& end){
            g = parent->g + getGCost(*parent);
            h = (qAbs(end.x - x) + qAbs(end.y - y)) * 10;
            f = g + h;
        }
        qint32 getGCost(const Node& other){
            return (x == other.x || y == other.y) ? 10 : 14;
        }
        static bool compareF(Node* first,Node* second){
            return first->f < second->f;
        }
        Node(const qint32 x,const qint32 y,const qint32 wb):x(x),y(y),wideBend(wb){}
    };

    qint32 columnCount = _pathMap->getColumnCount();
    qint32 rowCount = _pathMap->getRowCount();

    QVector<Node*> nodes;
    nodes.resize(columnCount*rowCount);

    for(qint32 col=0;col<columnCount;++col){
        for(qint32 row=0;row<rowCount;++row){
            nodes[row*columnCount+col]=new Node(col,row,_pathMap->getWideBend(col,row));
        }
    }

    qint32 targetX=_target.x()/cellSize(),
           targetY=_target.y()/cellSize(),
           sourceX=_pos.x()/cellSize(),
           sourceY=_pos.y()/cellSize();

    Node *start     = nodes.value(sourceX+sourceY*columnCount,nullptr),
         *end       = nodes.value(targetX+targetY*columnCount,nullptr),
         *current   = nullptr;

    QLinkedList<Node*> openList;
    QLinkedList<Node*> closedList;

    openList.append(start);
    start->opened=true;

    forever{
        current = *(std::min_element(openList.constBegin(),openList.constEnd(),Node::compareF));
        if(current == end){
            break;
        }

        openList.removeOne(current);
        current->opened = false;

        closedList.append(current);
        current->closed = true;

        for(qint32 x = -1; x<=1; ++x){
            for(qint32 y = -1; y<=1; ++y){
                if(x || y){
                    qint32 col=current->x + x,
                           row=current->y + y;
                    if(col >= 0 && col < columnCount && row >= 0 && row < rowCount){
                        Node* node=nodes.value(row*columnCount+col);
                        if(node->closed || node->wideBend < _pathWidth){
                            continue;
                        }
                        if(!node->opened){
                            openList.append(node);
                            node->opened = true;
                            node->parent = current;
                            node->computeScores(*end);
                        }else{
                            if(node->g > current->g + node->getGCost(*current)){
                                node->parent = current;
                                node->computeScores(*end);
                            }
                        }
                    }
                }
            }
        }

        if(openList.isEmpty()){
            current = nullptr;
            break;
        }
    }

    if(current){
        while(current!=start){
            _path.prepend(QPoint(current->x*cellSize(),current->y*cellSize()));
            current=current->parent;
        }
    }

    qDeleteAll(nodes);
}

void PathFinder::rebuildPath(){
    _path.clear();

    getPathWithAStarAlgorithm();

    emit nextPosChanged();
    emit hasSolutionChanged();
}
