#include "graphanalysis.h"

GraphAnalysis::GraphAnalysis(Graph *graph)
{
    theGraph = graph;
}


bool GraphAnalysis::check() {

    if( !theGraph ) {
        errors << "Cannot run analysis, graph is NULL";
        return false;
    }

    if( !theGraph->numNodes() ) {
        errors << "Cannot run analysis on graph with no nodes...";
        return false;
    }

    return true;
}
