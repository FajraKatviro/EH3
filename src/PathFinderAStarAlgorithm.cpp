#include "PathFinderAStarAlgorithm.h"

#include <QPoint>
#include <QLinkedList>
#include <QVector>

#include "PathMap.h"

struct PathFinderAStarAlgorithm::Node{
    Node(const qint32 x,const qint32 y,const qint32 wb):x(x),y(y),wideBend(wb){}
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
        g = parent ? parent->g + getGCost(*parent) : 0;
        h = (qAbs(end.x - x) + qAbs(end.y - y)) * 10;
        f = g + h;
    }
    qint32 getGCost(const Node& other){
        return (x == other.x || y == other.y) ? 10 : 14;
    }
    static bool compareF(Node* first,Node* second){
        return first->f < second->f;
    }
};

void PathFinderAStarAlgorithm::computePath(QLinkedList<QPoint> &path, const QPoint &startPoint, const QPoint &endPoint, const qreal pathWidth, const PathMap& pathMap){
    qint32 columnCount = pathMap.getColumnCount();
    qint32 rowCount = pathMap.getRowCount();
    qreal cellSize = pathMap.cellSize();
    qint32 widthRequired = std::ceil( pathWidth / cellSize );

    QVector<Node*> nodes;
    nodes.resize(columnCount*rowCount);

    for(qint32 col=0;col<columnCount;++col){
        for(qint32 row=0;row<rowCount;++row){
            nodes[row*columnCount+col]=new Node(col,row,pathMap.getWideBend(col,row));
        }
    }

    qint32 targetX=endPoint.x()/cellSize,
           targetY=endPoint.y()/cellSize,
           sourceX=startPoint.x()/cellSize,
           sourceY=startPoint.y()/cellSize;

    Node *start     = nodes.value(sourceX+sourceY*columnCount,nullptr),
         *end       = nodes.value(targetX+targetY*columnCount,nullptr),
         *current   = nullptr,
         *best      = start;

    QLinkedList<Node*> openList;
    QLinkedList<Node*> closedList;

    openList.append(start);
    start->opened=true;
    start->computeScores(*end);

    forever{
        current = *(std::min_element(openList.constBegin(),openList.constEnd(),Node::compareF));
        if(current == end){
            break;
        }

        openList.removeOne(current);
        current->opened = false;

        closedList.append(current);
        current->closed = true;

        if(current->h < best->h){
            best=current;
        }

        for(qint32 x = -1; x<=1; ++x){
            for(qint32 y = -1; y<=1; ++y){
                if(x || y){
                    qint32 col=current->x + x,
                           row=current->y + y;
                    if(col >= 0 && col < columnCount && row >= 0 && row < rowCount){
                        Node* node=nodes.value(row*columnCount+col);
                        if(node->closed || node->wideBend < widthRequired){
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
            current = best;
            break;
        }
    }

    if(current){
        while(current!=start){
            path.prepend(QPoint(current->x*cellSize,current->y*cellSize));
            current=current->parent;
        }
    }

    qDeleteAll(nodes);
}
