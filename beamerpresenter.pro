#-------------------------------------------------
#
# Project created by QtCreator 2018-12-23T10:43:06
#
#-------------------------------------------------

QT       += core gui multimedia multimediawidgets xml

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = beamerpresenter
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++14

SOURCES += \
        src/main.cpp \
        src/controlscreen.cpp \
        src/pdfdoc.cpp \
        src/presentationscreen.cpp \
        src/pagelabel.cpp \
        src/clocklabel.cpp \
        src/timer.cpp \
        src/pagenumberedit.cpp \
        src/videowidget.cpp \
        src/cacheupdatethread.cpp \
        src/tocbox.cpp \
        src/tocbutton.cpp \
        src/tocaction.cpp \
        src/externalrenderer.cpp \
        src/embedapp.cpp \
        src/overviewframe.cpp \
        src/overviewbox.cpp

HEADERS += \
        src/controlscreen.h \
        src/enumerates.h \
        src/pdfdoc.h \
        src/presentationscreen.h \
        src/pagelabel.h \
        src/clocklabel.h \
        src/timer.h \
        src/pagenumberedit.h \
        src/videowidget.h \
        src/cacheupdatethread.h \
        src/tocbox.h \
        src/tocbutton.h \
        src/tocaction.h \
        src/externalrenderer.h \
        src/embedapp.h \
        src/overviewframe.h \
        src/overviewbox.h

FORMS += \
        src/controlscreen.ui

INCLUDEPATH += /usr/include/poppler/qt5
LIBS += -L/usr/lib/ -lpoppler-qt5

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
