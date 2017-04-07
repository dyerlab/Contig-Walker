#ifndef GRAPH_H
#define GRAPH_H


#include "node.h"
#include "edge.h"

#include <QList>
#include <QObject>

#include <gsl/gsl_matrix.h>

class Graph : public QObject
{
    Q_OBJECT
public:
    explicit Graph(QObject *parent = 0);

    inline int numNodes() { return nodes.count(); }
    inline void addNode(Node *node) { nodes.append( node ); }
    Node* getNode( int idx );
    int indexOf( Node* node );

    inline int numEdges() { return edges.count(); }
    bool addEdge( int source, int target, double weight );
    Edge* getEdge( int idx );

    QString toString();
    QStringList nodeLabels() const;

    gsl_matrix* asAdjacencyMatrix();

signals:

public slots:

protected:
    QList<Node*> nodes;
    QList<Edge*> edges;
};

#endif // GRAPH_H
