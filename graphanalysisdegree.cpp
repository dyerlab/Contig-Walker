#include "graphanalysisdegree.h"

GraphAnalysisDegree::GraphAnalysisDegree(Graph *theGraph) : GraphAnalysis( theGraph )
{

}


bool GraphAnalysisDegree::run() {

    if( !check() )
        return false;

    for(int i=0;i<theGraph->numEdges();i++){
        Edge *e = theGraph->getEdge(i);
        QString f = e->sourceNode()->getLabel();
        QString t = e->targetNode()->getLabel();

        int inDeg = in_degree->contains(t) ? in_degree->get(t) : 0;
        int outDeg = out_degree->contains(f) ? out_degree->get(f) : 0;

        in_degree->set( t, ++inDeg );
        out_degree->set( f, ++outDeg );


    }

    return true;
}
