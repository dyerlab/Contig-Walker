#ifndef NODE_H
#define NODE_H


#include "graphicitem.h"

class Edge;

class Node : public GraphicItem
{

public:

    explicit Node(QString name = QString("Node"), double size=5.0, GraphicItem *parent = 0);

    QString getLabel() const;
    double getSize() const;
    inline void setSize(double val ) { size = val; }
    QString toString();

    inline void addEdge( Edge *e )  { edges.append( e ); }
    inline Edge* getEdge( int idx ) { return edges.at(idx); }
    inline int degree()             { return edges.count(); }

    // Visualization stuff
    QRectF boundingRect() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
    QVariant itemChange(GraphicsItemChange change, const QVariant &value);
    QPainterPath shape() const;
    bool shouldAdvance();
    inline void toggleLabel()       { showLabel = !showLabel; }

    void stopMoving();
    void nudge(double dX, double dY);

protected:
    double size;
    QString label;
    bool showLabel;

    QList<Edge*> edges;
    QPointF newPosition;
};

#endif // NODE_H
