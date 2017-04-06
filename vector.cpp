#include "vector.h"
#include <QDebug>

Vector::Vector(int length)
{
    vector = gsl_vector_calloc(length);

}

Vector::~Vector() {
    gsl_vector_free( vector );
}

void Vector::set(int idx, double val) {
    if( idx < labels.count())
        gsl_vector_set( vector, idx, val );
}

void Vector::set(QString key, double val){
    int idx = labels.indexOf(key);
    this->set(idx,val);
}

void Vector::setLabel( int idx, QString key ){
    labels.insert(idx,key);
}

bool Vector::contains( QString lbl ) const {
    return labels.contains(lbl);
}


double Vector::get(int idx) const {
    qDebug() << vector->size << idx;
    if( idx < labels.count() )
        return gsl_vector_get( vector, idx );
    else
        return 0.0;
}

double Vector::get(const QString lbl ) const {
    int idx = labels.indexOf( lbl );
    return this->get(idx);
}
