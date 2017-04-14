#-------------------------------------------------
#
# Project created by QtCreator 2017-04-03T08:21:25
#
#-------------------------------------------------

QT       += core gui xml charts


greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ChromosomeWalking
TEMPLATE = app
MOC_DIR = objs
OBJECTS_DIR = objs

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += main.cpp\
        mainwindow.cpp \
    parser.cpp \
    parsegml.cpp \
    parsegraphjson.cpp \
    node.cpp \
    edge.cpp \
    graph.cpp \
    vectorops.cpp \
    plotops.cpp \
    graphops.cpp \
    matrixops.cpp \
    graphicitem.cpp \
    dataset.cpp \
    graphdatatablemodel.cpp \
    graphview.cpp \
    graphscene.cpp

HEADERS  += mainwindow.h \
    parser.h \
    parsegml.h \
    parsegraphjson.h \
    node.h \
    edge.h \
    graph.h \
    vectorops.h \
    plotops.h \
    graphops.h \
    matrixops.h \
    graphicitem.h \
    dataset.h \
    graphdatatablemodel.h \
    graphview.h \
    graphscene.h

FORMS    += mainwindow.ui

macx: LIBS += -L/usr/local/Cellar/gsl/2.3/lib/ -lgsl

INCLUDEPATH += /usr/local/Cellar/gsl/2.3/include
DEPENDPATH += /usr/local/Cellar/gsl/2.3/include

macx: PRE_TARGETDEPS += /usr/local/Cellar/gsl/2.3/lib/libgsl.a

DISTFILES += \
    AppStyleSheet.css

RESOURCES += \
    chromosomewalking.qrc
