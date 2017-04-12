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



void Node::calculateForces( double maxVelocity ){
    qDebug() << "calculateforces";
}




/****************   Overrides for Plotting *******************/
QRectF Node::boundingRect() const {
    QFont font("Helvetica [Cronyx]", 12, QFont::Normal );
    QFontMetrics metrics(font);
    QRectF fontRect = metrics.boundingRect(this->getLabel());

    double left = size/2;
    double top = (size < fontRect.height() ) ? fontRect.height() + size/2 + 4 : -size/2;
    double width = size + 4 + fontRect.width();
    double height = size + 4 + fontRect.height();

    return QRectF(left,top,width,height);
}

void Node::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) {
    Q_UNUSED( widget );
    Q_UNUSED( option );

    painter->setPen( pen );
    painter->setBrush( brush );

    // make nodes a gradient
    QRadialGradient gradient( -size/8, -size/8, size/2 );
    gradient.setColorAt(0, brush.color().lighter(250) );
    gradient.setColorAt(1, brush.color().darker(150) );
    painter->setBrush( gradient );

    painter->drawEllipse( -size/2, -size/2, size, size );

    if( showLabel ){
        painter->setFont( QFont("Helvetica [Cronyx]", 12, QFont::Normal) );
        painter->drawText( size/2+2,0, label );
    }
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

