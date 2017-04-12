#ifndef EDGE_H
#define EDGE_H


#include "node.h"
#include "graphicitem.h"



class Edge : public GraphicItem
{

public:
    explicit Edge(Node *source, Node *target, double weight=1.0, GraphicItem *parent = 0);

    enum { Type = UserType + 11 };
    int type() const { return Type; }

    inline Node* sourceNode() const { return source; }
    inline Node* targetNode() const { return target; }
    inline double getWeight() const { return weight; }

    QString toString();

    // Visualization stuff
    void adjust();
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
    QRectF boundingRect() const;



protected:
    Node *source;
    Node *target;
    double weight;
};

#endif // EDGE_H
