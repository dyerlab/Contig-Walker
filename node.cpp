#include "node.h"
#include "edge.h"

Node::Node(QString name, double size, GraphicItem *parent) : GraphicItem(parent)
{
    this->label = name;
    this->size = size;
    showLabel = true;
    setPos( QPointF( qrand() % 800, qrand() % 800 ));

    setFlag( QGraphicsItem::ItemIsMovable, true );
    setFlag( QGraphicsItem::ItemIsSelectable, true );
    setFlag( QGraphicsItem::ItemSendsGeometryChanges, true);

    setPen( QPen(Qt::black));
    setBrush( Qt::darkRed );
    setZValue(3);

}


QString Node::getLabel() const {
    return label;
}

double Node::getSize() const  {
    return size;
}

QString Node::toString() {
    return QString("Node: %1: size=%2").arg(label).arg(size);
}


void Node::stopMoving() {
    newPosition = pos();
}

void Node::nudge(double dX, double dY){
    setPos( QPointF(dX,dY) );

}





/****************   Overrides for Plotting *******************/
QRectF Node::boundingRect() const {

    QRectF bRect = QRectF(-size/2,-size/2,size,size);

    /*
     *
    QFont font("Helvetica [Cronyx]", 12, QFont::Normal);
    QFontMetrics metrics(font);
    QRect fontRect = metrics.boundingRect(label);

    bRect.setLeft( -size/2 );
    if( size < fontRect.height())
        bRect.setTop(fontRect.height() + size/2 + 4);
    else
        bRect.setTop(-size/2);
    bRect.setWidth( size + 4 + fontRect.width() );
    bRect.setHeight( size + 4 + fontRect.height() );
    */
    //


    return bRect;
}

void Node::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) {
    Q_UNUSED( option );
    Q_UNUSED( widget );
    painter->setPen( pen );
    painter->setBrush( brush );

    // set up the gradient
    QRadialGradient gradient(-size/8,-size/8,size/2);
    gradient.setColorAt(0, brush.color().lighter(250));
    gradient.setColorAt(1, brush.color().darker(150));

    painter->setBrush( gradient);
    painter->drawEllipse(-size/2,-size/2,size,size);

    // show the label if necessary
    /*
    if( showLabel ) {
        painter->setFont( QFont("Helvetica [Cronyx]", 12, QFont::Normal) );
        //painter->drawText(size/2+2,size/2, label);
        painter->drawText(size/2+2,0, label);
    }
    */
}

QVariant Node::itemChange(GraphicsItemChange change, const QVariant &value) {
    switch( change ) {
    case ItemPositionChange:
        foreach( Edge *edge, edges )
            edge->adjust();
        break;

    default:
        break;
    }

    return QGraphicsItem::itemChange( change, value );
}

QPainterPath Node::shape() const {
    QPainterPath path;
    path.addEllipse(boundingRect());
    return path;
}

bool Node::shouldAdvance() {
    if( newPosition == pos() )
        return false;
    setPos(newPosition);
    return true;
}

