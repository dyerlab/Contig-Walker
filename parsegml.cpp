#include "parsegml.h"

#include <QFile>
#include <QDebug>
#include <QByteArray>
#include <QXmlStreamReader>

ParseGML::ParseGML(QString path, QObject *parent) : Parser(path, parent)
{

}


bool ParseGML::parse() {
    if( path.isEmpty() ) {
        errors << "Path not set";
        return false;
    }
    else {
        qDebug() << "Parsing GML file: " << path;
    }

    QFile file(path);
    if( !file.open(QIODevice::ReadOnly)) {
        errors << "Cannot open file " << path;
        return false;
    }

    QXmlStreamReader *reader = new QXmlStreamReader();
    QByteArray contents = file.readAll();
    reader->addData( contents );

    while( !reader->atEnd() ){
        reader->readNext();

        if( reader->isStartDocument() ){
            qDebug() << "Reading GraphML: ";
            qDebug() << "Document Version: " << reader->documentVersion();
            qDebug() << "Document Encoding: " << reader->documentEncoding().toString();
        }

        QString value = reader->name().toString();
        qDebug() << "StartElement: " << value;

        if( reader->isStartElement()){
            if( value != "graphml") {
                errors << "Not GraphML document!  Aborting";
                file.close();
                return false;
            }

            // good file, read it in.


        }

        if ( reader->isEndElement()){
            qDebug() << "End Element: " << value;
        }



    }
    file.close();
    return true;
}
