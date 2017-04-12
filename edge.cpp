#include "edge.h"

Edge::Edge(Node *source, Node *target, double weight, GraphicItem *parent) : GraphicItem(parent)
{
    this->source = source;
    this->target = target;
    this->weight = weight;

    source->addEdge(this);
    target->addEdge(this);

    setPen( QPen(Qt::black) );
    setZValue(1);

}


QString Edge::toString() {
    return QString("Edge: %1 - %2; weight=%3").arg( source->getLabel() ).arg( target->getLabel() ).arg( weight );
}


/*******************   Visualization Stuff    ************************/
void Edge::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) {
    Q_UNUSED( widget );
    Q_UNUSED( option );
    Node *source =   (Node*)sourceNode();
    Node *destination = (Node*)targetNode();

    QLineF line( source->pos(), destination->pos() );
    if( qFuzzyCompare( line.length(),qreal(0.0)))
        return;

    painter->setPen(pen);
    painter->drawLine( line );

}

void Edge::adjust() {
    Node *source =   (Node*)sourceNode();
    Node *destination = (Node*)targetNode();
    if( !source || !destination )
        return;

    //QLineF line( mapFromItem(source,0,0), mapFromItem(destination,0,0));
    this->prepareGeometryChange();
}

QRectF Edge::boundingRect() const {
    Node *source =   (Node*)sourceNode();
    Node *destination = (Node*)targetNode();

    if( !source || !destination )
        return QRectF(0,0,0,0);
    QPointF pt1 = source->pos();
    QPointF pt2 = destination->pos();

    QPointF pt( pt1.x() < pt2.x() ? pt1.x() : pt2.x(),
                pt1.y() < pt2.y() ? pt1.y() : pt2.y());
    QSizeF sz( qAbs( pt1.x()-pt2.x()), qAbs(pt1.y()-pt2.y()));
    return QRectF(pt,sz);
}
