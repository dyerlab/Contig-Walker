#include "edge.h"

Edge::Edge(Node *source, Node *target, double weight, QObject *parent) : QObject(parent)
{
    this->source = source;
    this->target = target;
    this->weight = weight;
}


QString Edge::toString() {
    return QString("Edge: %1 - %2; weight=%3").arg( source->getLabel() ).arg( target->getLabel() ).arg( weight );
}
