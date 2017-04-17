/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  graphops
*
*  Created: 4 2017 by rodney
*
*  Copyright 2017 rodney.  All Rights Reserved.
*
* This file may be distributed under the terms of GNU Public License version
* 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
* license should have been included with this file, or the project in which
* this file belongs to. You may also find the details of GPL v3 at:
*
* http://www.gnu.org/licenses/gpl-3.0.txt
*
* If you have any questions regarding the use of this file, feel free to
* contact the author of this file, or the owner of the project in which
* this file belongs to.
*
******************************************************************************/
#include "graphops.h"

#include "graph.h"


void transferNodeLocations( Graph* fromGraph, Graph *toGraph ) {
    Q_ASSERT( fromGraph->numNodes() == toGraph->numNodes());

    for( int i=0;i<fromGraph->numNodes();i++){
        int idx = toGraph->indexOf( fromGraph->getNode(i)->getLabel());
        if( idx != -1 ){
            toGraph->getNode(idx)->setPos( fromGraph->getNode(i)->pos());
        }
        else {
            toGraph->getNode(idx)->setPos(400,400);
        }
    }
}



gsl_vector* degreeCentrality( QList<Node*> nodes) {
    int N = nodes.count();
    gsl_vector *vec = gsl_vector_calloc(N);

    for(int i=0;i<N;i++){
        gsl_vector_set( vec, i, (double)nodes.at(i)->degree() );
    }

    return vec;
}


gsl_vector* betweennessCentrality( gsl_matrix *A ) {
    Q_ASSERT( A->size1 == A->size2 );
    unsigned N = A->size1;
    gsl_matrix *D = gsl_matrix_calloc( N, N );
    double gMax = matrixSum( A );
    gsl_vector *btwn = gsl_vector_calloc(N);

    // Set up D
    for(unsigned i=0;i<N;++i){
        for( unsigned j=0;j<N;++j){
            if( i != j ) {
                double val = gsl_matrix_get(A,i,j);

                if( val > 0 )
                    gsl_matrix_set( D, i, j, val );

                else
                    gsl_matrix_set( D, i, j, gMax);

            }
        }
    }

    // Cycle through the Floyd Warshall Algorithm
    for( unsigned k=0;k<N;++k){
        for( unsigned i=0;i<N;++i){
            for( unsigned j=0;j<N;++j){
                if( i != j && i != k && j != k ){
                    double curDist = gsl_matrix_get(D,i,j);
                    double newDist = gsl_matrix_get(D,i,k) + gsl_matrix_get(D,k,j);

                    if( curDist < gMax && newDist < gMax ) {
                        if( curDist < newDist ){
                            gsl_matrix_set( D, i, j, curDist );
                        }
                        else {
                            gsl_vector_set( btwn, k, (gsl_vector_get( btwn, k) + 1.0) );
                            gsl_matrix_set( D, i, j, newDist );
                        }
                    }

                    else if( newDist < gMax )
                        gsl_matrix_set( D,i,j,newDist);
                }
            }
        }
    }

    gsl_matrix_free( D );
    gsl_vector_scale(btwn, (N-1.0)*(N-2)/2);

    return( btwn );
}


gsl_vector* closenessCentrality( gsl_matrix *A ) {
    unsigned N = A->size1;
    gsl_vector *close = gsl_vector_calloc(N);

    gsl_matrix *D = shortestPathFloydWarshall(A);

    for( size_t i=0;i<N;i++){
        for( size_t j=0;j<N;j++){
            gsl_vector_set(close, i, gsl_matrix_get(D,i,j)+gsl_vector_get(close,i) );
        }
    }
    gsl_matrix_free( D );
    return close;
}









