#ifndef VECTOR_H
#define VECTOR_H

#include <QStringList>
#include <gsl/gsl_vector.h>

class Vector
{
public:
    Vector(int length);
    ~Vector();

    inline int count() const { return (int)vector->size; }

    void set(int idx, double val);
    void set(QString key, double val);
    void setLabel( int idx, QString key );
    bool contains( QString lbl ) const;
    inline QStringList getLabels() const { return labels; }

    double get(int idx) const;
    double get(const QString lbl ) const;




    inline gsl_vector* raw() const { return vector; }

private:
    QStringList labels;
    gsl_vector *vector;
};

#endif // VECTOR_H
