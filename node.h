#ifndef NODE_H
#define NODE_H

#include <QObject>

class Edge;

class Node : public QObject
{
    Q_OBJECT
public:
    explicit Node(QString name = QString("Node"), double size=5.0, QObject *parent = 0);

    QString getLabel() const;
    double getSize() const;
    QString toString();

signals:

public slots:

protected:
    QString name;
    double size;
};

#endif // NODE_H
