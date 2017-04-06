#include "graph.h"

Graph::Graph(QObject *parent) : QObject(parent)
{

}


QString Graph::toString() {
    QStringList ret;
    ret << "Graph:";

    ret << QString( "Node Set (K=%1):").arg(nodes.count());
    for(int i=0;i<nodes.count();i++)
        ret << QString(" - %1").arg( nodes.at(i)->toString());

    ret << QString( "Edge Set (J=%1):").arg(edges.count());
    for(int i=0;i<edges.count();i++)
        ret << QString(" - %1").arg( edges.at(i)->toString());

    return ret.join("\n");
}

Node* Graph::getNode(int idx) {
    return nodes.at(idx);
}

Edge* Graph::getEdge(int idx) {
    return edges.at(idx);
}

bool Graph::addEdge( int source, int target, double weight ){
    Node *n1 = nodes.at(source);
    Node *n2 = nodes.at(target);
    Edge *e = new Edge(n1,n2,weight);

    edges.append(e);

    return true;
}


gsl_matrix* Graph::asAdjacencyMatrix(){
    gsl_matrix *m = gsl_matrix_calloc( numNodes(), numNodes() );

    for(int i=0;i<numEdges();i++){
        Edge *e = edges.at(i);
        int x = nodes.indexOf( e->sourceNode() );
        int y = nodes.indexOf( e->targetNode() );
        double wt = e->getWeight();
        gsl_matrix_set(m,x,y,wt);
    }

    return m;

}
