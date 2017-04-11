/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphicedge.h
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

#ifndef GRAPHICEDGE_H
#define GRAPHICEDGE_H

#include "edge.h"
#include "graphicitem.h"

class GraphicNode;

class GraphicEdge : public GraphicItem, public Edge
{
public:
    GraphicEdge(GraphicNode *node1, GraphicNode *node2, double weight, GraphicItem *graphParent=0, QObject *parent = 0);

    enum{ Type = UserType + 11 };
    int type() const { return Type; }
    inline GRAPHIC_ITEM_TYPE graphItemType() { return GRAPHIC_ITEM_EDGE; }

    void adjust();

protected:
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
    QRectF boundingRect() const;


};

#endif // GRAPHICEDGE_H
