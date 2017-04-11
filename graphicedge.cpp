/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphicedge.cpp
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
#include "graphicedge.h"

GraphicEdge::GraphicEdge(GraphicNode *node1, GraphicNode *node2, double weight, GraphicItem *graphParent, QObject *parent) :
    GraphicItem( graphParent ), Edge(node1, node2, weight, parent)
{
    setPen( QPen( Qt::black ) );
    setZValue( 1 );
}

void GraphicEdge::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) {
    Q_UNUSED( widget );
    Q_UNUSED( option );
    GraphicNode *source =   (GraphicNode*)sourceNode();
    GraphicNode *destination = (GraphicNode*)targetNode();

    QLineF line( source->pos(), destination->pos() );
    if( qFuzzyCompare( line.length(),qreal(0.0)))
        return;

    painter->setPen(pen);
    painter->drawLine( line );

}

void GraphicEdge::adjust() {
    GraphicNode *source =   (GraphicNode*)sourceNode();
    GraphicNode *destination = (GraphicNode*)targetNode();
    if( !source || !destination )
        return;

    //QLineF line( mapFromItem(source,0,0), mapFromItem(destination,0,0));
    this->prepareGeometryChange();
}

QRectF GraphicEdge::boundingRect() const {
    GraphicNode *source =   (GraphicNode*)sourceNode();
    GraphicNode *destination = (GraphicNode*)targetNode();

    if( !source || !destination )
        return QRectF(0,0,0,0);
    QPointF pt1 = source->pos();
    QPointF pt2 = destination->pos();

    QPointF pt( pt1.x() < pt2.x() ? pt1.x() : pt2.x(),
                pt1.y() < pt2.y() ? pt1.y() : pt2.y());
    QSizeF sz( qAbs( pt1.x()-pt2.x()), qAbs(pt1.y()-pt2.y()));
    return QRectF(pt,sz);
}
