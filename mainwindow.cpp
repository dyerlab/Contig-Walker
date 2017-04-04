/******************************************************************************
*                       _                 _       _
*                    __| |_   _  ___ _ __| | __ _| |__
*                   / _` | | | |/ _ \ '__| |/ _` | '_ \
*                  | (_| | |_| |  __/ |  | | (_| | |_) |
*                   \__,_|\__, |\___|_|  |_|\__,_|_.__/
*                         |___/
*
*  mainwindow.cpp
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

#include <QMenu>
#include <QDebug>

#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::makeActions(){
    actionOpenDataFolder = new QAction( tr("&Open Data Folder"));
    actionOpenDataFolder->setShortcut(tr("CTRL+O"));
    connect( actionOpenDataFolder, SIGNAL(triggered(bool)),
             this, SLOT(slotSetFolder()));
}

void MainWindow::makeMenus() {
    QMenu *fileMenu = this->menuBar()->addMenu(tr("&File"));
    fileMenu->addAction( actionOpenDataFolder );
    QAction *actionQuit = new QAction(tr("&Quit"));
    connect( actionQuit, SLOT(triggered(bool)),
             qApp, SLOT(closeAllWindows()));

}

void MainWindow::makeUI() {

}





void MainWindow::slotSetFolder(){
    qDebug() << "slotSetFolder";
}






