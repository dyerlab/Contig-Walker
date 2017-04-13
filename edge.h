#ifndef EDGE_H
#define EDGE_H


#include <QGraphicsItem>

class Edge : public QGraphicsItem
{

public:
    explicit Edge(QGraphicsItem *source, QGraphicsItem *target, double weight=1.0, QGraphicsItem *parent = 0);

    inline QGraphicsItem* sourceNode() const { return source; }
    inline QGraphicsItem* targetNode() const { return target; }
    QGraphicsItem* otherNode(QGraphicsItem *node);
    inline double getWeight() const { return weight; }


    // Visualization stuff
    void adjust();
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
    QRectF boundingRect() const;



protected:
    QGraphicsItem *source;
    QGraphicsItem *target;
    double weight;
};

#endif // EDGE_H
