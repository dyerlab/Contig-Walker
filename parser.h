#ifndef PARSER_H
#define PARSER_H

#include <QFile>
#include <QDebug>
#include <QString>
#include <QStringList>
#include <QObject>

typedef enum {
    PARSER_STATUS_OK,
    PARSER_STATUS_WARNING,
    PARSER_STATUS_ERROR,
    PARSER_STATUS_FUBAR
} PARSER_STATUS;

class Parser : public QObject
{
    Q_OBJECT
public:

    explicit Parser(QString path = QString(), QObject *parent = 0);

    virtual bool parse() = 0 ;
    PARSER_STATUS getStatus() const;
    QString getFeedback() const;

    inline QStringList getErrors() { return errors; }
    inline QStringList getWarnings() { return warnings; }

signals:

public slots:

protected:
    QString path;
    QStringList errors;
    QStringList warnings;

};

#endif // PARSER_H
