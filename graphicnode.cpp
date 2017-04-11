/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphicnode.cpp
*
*  Created: 4 2017 by rodney
*
*  Copyright 2017 rodney.  All Rights Reserved.
*
* This file may be distributed under the terms of GNU Public License version
* 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
* license should have been included with this file, or the project in which
* this file belongs to. You may also find the details of GPL v3 at:
*
* http://www.gnu.org/licenses/gpl-3.0.txt
*
* If you have any questions regarding the use of this file, feel free to
* contact the author of this file, or the owner of the project in which
* this file belongs to.
*
******************************************************************************/


#include "graphicnode.h"

GraphicNode::GraphicNode(QString name, double size, QObject *parent, QGraphicsItem *graphic_parent) :
    GraphicItem(graphic_parent), Node(name,size,parent)
{
    setPos( QPointF(qrand() % 800, qrand() % 800));

    setFlag( QGraphicsItem::ItemIsMovable, true );
    setFlag( QGraphicsItem::ItemIsSelectable, true );
    setFlag( QGraphicsItem::ItemSendsGeometryChanges, true);
    setCacheMode( DeviceCoordinateCache );
    setZValue( 2 );
    showLabel = true;
}

QRectF GraphicNode::boundingRect() const {
    QFont font("Helvetica [Cronyx]", 12, QFont::Normal );
    QFontMetrics metrics(font);
    QRectF fontRect = metrics.boundingRect(this->getLabel());

    double left = size/2;
    double top = (size < fontRect.height() ) ? fontRect.height() + size/2 + 4 : -size/2;
    double width = size + 4 + fontRect.width();
    double height = size + 4 + fontRect.height();

    return QRectF(left,top,width,height);
}

void GraphicNode::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) {
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
        painter->drawText( size/2+2,0, name );
    }


}

QVariant GraphicNode::itemChange(GraphicsItemChange change, const QVariant &value) {

    /* ADJUST EDGES WHEN ADDED
    switch( change ) {
    case ItemPositionChange:
        foreach( GraphicEdge *edge, edges )
            edge->adjust();
        break;

    default:
        break;
    }
    */
    return QGraphicsItem::itemChange( change, value );
}

QPainterPath GraphicNode::shape() const {
    QPainterPath path;
    path.addEllipse(boundingRect());
    return path;
}

bool GraphicNode::shouldAdvance() {
    if( newPosition == pos() )
        return false;
    setPos(newPosition);
    return true;
}

void GraphicNode::calculateForces( double maxVelocity ){

}
