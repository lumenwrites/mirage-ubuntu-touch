import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: root
    width: units.gu(64)
    height: units.gu(64)
    color: Qt.darker(UbuntuColors.coolGrey)
    opacity: 0
    property color paintColor: Qt.rgba(1,0,0, toolbar.brush_opacity)
} // END color_picker