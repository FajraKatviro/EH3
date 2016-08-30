#ifndef PATHMAP_H
#define PATHMAP_H

#include <QObject>

#include <QVariant>
#include <QVector>
#include <QMap>

class QQuickItem;

class PathMap : public QObject{
    Q_OBJECT
    Q_PROPERTY(QQuickItem* location READ location WRITE setLocation NOTIFY locationChanged)
    Q_PROPERTY(qreal cellSize READ cellSize WRITE setCellSize NOTIFY cellSizeChanged)
public:
    explicit PathMap(QObject *parent = 0);
    inline qreal cellSize() const;

signals:
    void locationChanged();
    void cellSizeChanged();

public slots:
    void rebuildTerrainData();
    void relocateObstacle(const QVariant obstacle);

private:
    inline QQuickItem* location()const;
    inline void setLocation(QQuickItem* location);
    QQuickItem* _location=nullptr;

    inline void setCellSize(qreal cellSize);
    qreal _cellSize=10;

    QVector<qint32> _wideBend;
    QMap<QQuickItem*,qint32> _obstacles;

    struct Index{
        qint32 x;
        qint32 y;
    };
    inline Index posFromIndex(const qint32 index)const;
    inline qint32 indexFromPos(const qint32 x, const qint32 y)const;
    qint32 _rowCount=0;
    qint32 _columnCount=0;

    inline qint32 getWideBend(const qint32 x, const qint32 y)const;
    inline qint32 getWideBend(const qint32 index)const;
    inline void setWideBend(const qint32 index, const qint32 value);
    qint32 calculateWideBend(const qint32 index)const;

    void fillObstacle(QQuickItem* obstacle,const qint32 value,const qint32 xShift=0,const qint32 yShift=0);
};




inline QQuickItem* PathMap::location()const{
    return _location;
}

inline void PathMap::setLocation(QQuickItem* location){
    if(_location!=location){
        _location=location;
        emit locationChanged();
    }
}

inline qreal PathMap::cellSize() const{
    return _cellSize;
}

inline void PathMap::setCellSize(qreal cellSize){
    if (_cellSize != cellSize){
        _cellSize = cellSize;
        emit cellSizeChanged();
    }
}

inline PathMap::Index PathMap::posFromIndex(const qint32 index) const{
    qint32 row = index / _columnCount;
    qint32 column = index - row * _columnCount;
    return Index{ column, row };
}

inline qint32 PathMap::indexFromPos(const qint32 x, const qint32 y)const{
    if(x < 0 || x >= _columnCount || y < 0 || y >= _rowCount)
        return -1;
    return y * _columnCount + x;
}

inline qint32 PathMap::getWideBend(const qint32 x, const qint32 y) const{
    return _wideBend.value(indexFromPos(x,y),0);
}

inline qint32 PathMap::getWideBend(const qint32 index) const{
    return _wideBend.value(index,0);
}

inline void PathMap::setWideBend(const qint32 index, const qint32 value){
    if(index>=0 && index<_rowCount*_columnCount){
        _wideBend[index]=value;
    }else{
        qDebug("invalid wide bend cell index found");
    }
}

#endif // PATHMAP_H
