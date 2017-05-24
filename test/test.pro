# qmake -spec macx-xcode test.pro

TARGET = test
TEMPLATE = app
QT += core gui widgets opengl
CONFIG += c++11

OBJECTS_DIR = Debug/.obj
MOC_DIR = Debug/.moc
RCC_DIR = Debug/.rcc
UI_DIR = Debug/.ui

DEFINES += DEBUG

INCLUDEPATH += ..
HEADERS += ../QtFont3D.h
SOURCES += ../QtFont3D.cpp

HEADERS += test.h
SOURCES += test.cpp
