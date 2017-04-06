#include "graphanalysisdegree.h"
#include "vectorops.h"

GraphAnalysisDegree::GraphAnalysisDegree(Graph *theGraph) : GraphAnalysis( theGraph )
{

}


bool GraphAnalysisDegree::run() {
    /*
    if( !check() )
        return false;
    */

    qDebug() << "Run";

    // Set up the in and out
    in_degree = new Vector( theGraph->numNodes() );
    out_degree = new Vector( theGraph->numNodes() );

    // go through the nodes
    for( int i=0;i<theGraph->numNodes();++i){
        QString key = theGraph->getNode(i)->getLabel();
        in_degree->setLabel(i,key);
        out_degree->setLabel(i,key);
        in_degree->set(i,0.0);
        out_degree->set(i,0.0);
    }


    for(int i=0;i<theGraph->numEdges();i++){
        Edge *e = theGraph->getEdge(i);
        qDebug() << e;

        QString f = e->sourceNode()->getLabel();
        QString t = e->targetNode()->getLabel();

        qDebug() << f << t;

        int inDeg = in_degree->get(t);
        int outDeg = out_degree->get(f);

        qDebug() << "Degrees: " << inDeg << outDeg;

        in_degree->set( t, ++inDeg );
        out_degree->set( f, ++outDeg );

    }

    return true;
}


Vector* GraphAnalysisDegree::getDegreeDistribution() {
    int k = theGraph->numNodes();
    Vector *vec = new Vector(k);
    for(int i=0;i<k;i++){
        vec->setLabel(i,theGraph->getNode(i)->getLabel());
        vec->set(i, in_degree->get(i) + out_degree->get(i));
    }
    return vec;
}

Vector* GraphAnalysisDegree::getDegreeHistogram() {
    Vector* v = getDegreeDistribution();
    double numBins = gsl_vector_max( v->raw() );
    qDebug() << "bins" << numBins;
    Vector* ret = vector2bins( v, numBins );

    delete v;
    return ret;
}

