#include "node.h"

Node::Node(QString name, double size, QObject *parent) : QObject(parent)
{
    this->name = name;
    this->size = size;
}


QString Node::getLabel() const {
    return name;
}

double Node::getSize() const  {
    return size;
}

QString Node::toString() {
    return QString("Node: %1: size=%2").arg(name).arg(size);
}
