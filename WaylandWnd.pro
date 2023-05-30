TEMPLATE = app
#CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt
CONFIG += debug

DEFINES += QT_DEPRECATED_WARNINGS

LIBS += -lwayland-client -lpng -lm -lpthread


SOURCES += \
        main.cpp \
        os-compatibility.cpp \
        xdg-shell-protocols.c

HEADERS += \
    config.h \
    os-compatibility.h \
    xdg-shell-client-protocol.h \
    zalloc.h

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

