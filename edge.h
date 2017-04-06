#ifndef EDGE_H
#define EDGE_H

#include <QObject>
#include <QString>

#include "node.h"

class Edge : public QObject
{
    Q_OBJECT
public:
    explicit Edge(Node *source, Node *target, double weight=1.0, QObject *parent = 0);

    inline Node* sourceNode() const { return source; }
    inline Node* targetNode() const { return target; }
    inline double getWeight() const { return weight; }

    QString toString();

signals:

public slots:

protected:
    Node *source;
    Node *target;
    double weight;
};

#endif // EDGE_H
