/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphitem.h
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

#ifndef GRAPHITEM_H
#define GRAPHITEM_H

#include <QPen>
#include <QBrush>
#include <QGraphicsItem>

typedef enum {
    GRAPHIC_ITEM_UNDEF,
    GRAPHIC_ITEM_EDGE,
    GRAPHIC_ITEM_NODE
} GRAPHIC_ITEM_TYPE;


class GraphicItem : public QGraphicsItem
{
public:
    GraphicItem( QGraphicsItem *parent = 0);

    inline GRAPHIC_ITEM_TYPE Type()   { return GRAPHIC_ITEM_UNDEF; }

    inline QColor getColor()        {return brush.color(); }
    inline void setPen( QPen p)     { pen = p; }
    inline void setBrush( QBrush b) { brush = b; }

protected:
    QPen pen;
    QBrush brush;

};

#endif // GRAPHITEM_H