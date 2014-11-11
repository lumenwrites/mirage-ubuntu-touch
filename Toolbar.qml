import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: toolbar
    width: units.gu(6)

    property alias brush_size : brush_size.value
    property real brush_opacity : 0.5

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
    }
    color: UbuntuColors.coolGrey

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: units.gu(1)
        }
        spacing: units.gu(2)

        ToolbarSmallButton {
            id: open_color_picker
        }

        Column {
            id: opacity
            anchors {
                left: parent.left
                right: parent.right

            }
            spacing: units.gu(0.5)
            Repeater {
                model: 10
                ToolbarSmallButton {
                    id: open_color_picker
                    text: (index+1)*10 + "%"
                    onClicked: {
                        toolbar.brush_opacity = (index+1)*0.1
                    }
                }
            }
        } // END opacity

        Rectangle {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            height: units.gu(32)
            width: toolbar.width - units.gu(0.5)
            color: UbuntuColors.coolGrey //Qt.darker(UbuntuColors.coolGrey)

            Slider {
                anchors {
                    //top: parent.top
                    //bottom: parent.bottom
                    //verticalCenter: parent.verticalCenter
                }
                id: brush_size
                function formatValue(v) { return v.toFixed(2) }
                minimumValue: 0.1
                maximumValue: 64
                value: 20
                live: true
                transform: Rotation { origin.x: 0; origin.y: 0;
                axis { x: 0; y: 0; z: 1 } angle: 90 }
                x: units.gu(4.2)
                y: units.gu(1)
                width: units.gu(30)
            }
        } // END brush_size
    }
} // END toolbar
