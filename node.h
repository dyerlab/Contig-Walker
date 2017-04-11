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
    inline void setSize(double val ) { size = val; }
    QString toString();

    inline void addEdge( Edge *e )  { edges.append( e ); }
    inline int degree()             { return edges.count(); }

signals:

public slots:

protected:
    QString name;
    double size;

    QList<Edge*> edges;
};

#endif // NODE_H
