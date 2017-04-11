/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphicnode.h
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

#ifndef GRAPHICNODE_H
#define GRAPHICNODE_H

#include "node.h"
#include <QPointF>
#include "graphicitem.h"

class GraphicNode : public GraphicItem, public Node
{
public:
    GraphicNode(QString name = QString("Node"), double size=5.0, QObject *parent = 0, QGraphicsItem *graphic_parent = 0);

    enum { Type = UserType + 10 };
    int type() const { return Type; }

    inline GRAPHIC_ITEM_TYPE graphicType() { return GRAPHIC_ITEM_NODE; }

    // overloaded functions
    QRectF boundingRect() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
    QVariant itemChange(GraphicsItemChange change, const QVariant &value);
    QPainterPath shape() const;
    bool shouldAdvance();

    void calculateForces( double maxVelocity );

    inline void toggleLabel() { showLabel = !showLabel; }


protected:
    QPointF newPosition;
    bool showLabel;


};

#endif // GRAPHICNODE_H
