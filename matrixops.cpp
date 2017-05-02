/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  matrixops
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

#include "matrixops.h"
#include <QtGlobal>
#include <gsl/gsl_math.h>

double matrixSum( gsl_matrix *A ) {
    double ret = 0.0;

    for( size_t i=0;i<A->size1;++i){
        for(size_t j=0;j<A->size2;++j){
            ret += gsl_matrix_get(A,i,j);
        }
    }

    return ret;
}


gsl_matrix* shortestPathFloydWarshall( gsl_matrix *A ){
    Q_ASSERT( A->size1 > 0 );
    Q_ASSERT( A->size1 == A->size2 );

    unsigned N = A->size1;
    gsl_matrix *D = gsl_matrix_calloc( N, N );
    double gMax = matrixSum( A );

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
                double curDist = gsl_matrix_get(D,i,j);
                double newDist = gsl_matrix_get(D,i,k) + gsl_matrix_get(D,k,j);

                if( curDist < gMax && newDist < gMax )
                    gsl_matrix_set( D, i, j, qMin( curDist, newDist )  );

                else if( newDist < gMax )
                    gsl_matrix_set( D,i,j,newDist);
            }
        }
    }

    // Set unreached connections to a VERY LARGE NUMBER
    for(unsigned i=0;i<N;i++){
        for(unsigned j=0;j<N;j++){
            if( gsl_matrix_get(D,i,j) == gMax )
                gsl_matrix_set( D, i, j, GSL_POSINF );
        }
    }

    return D;
}






