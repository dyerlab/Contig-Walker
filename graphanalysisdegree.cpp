
#include "graphanalysisdegree.h"


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
    in_degree = gsl_vector_calloc( theGraph->numNodes() );
    out_degree = gsl_vector_calloc( theGraph->numNodes());

    for(int i=0;i<theGraph->numEdges();i++){
        Edge *e = theGraph->getEdge(i);
        int inIdx = theGraph->indexOf( e->sourceNode());
        int outIdx = theGraph->indexOf( e->targetNode());

        if( inIdx > -1 && outIdx > -1 ){
            double inDeg = 1 + gsl_vector_get(in_degree,inIdx);
            double outDeg = 1 + gsl_vector_get(out_degree, outIdx);

            gsl_vector_set( in_degree, inIdx, inDeg );
            gsl_vector_set( out_degree, outIdx, outDeg);
        }
    }

    return true;
}


gsl_vector* GraphAnalysisDegree::getDegreeDistribution() {
    int k = theGraph->numNodes();
    gsl_vector *vec = gsl_vector_alloc( k );

    for(int i=0;i<k;i++){
        gsl_vector_set( vec, i, (gsl_vector_get(in_degree, i) + gsl_vector_get(out_degree,i)) );
    }
    return vec;
}



