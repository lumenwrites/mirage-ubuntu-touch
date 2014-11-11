import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: toolbar
    width: units.gu(6)

    property alias brushSize : sizeSlider.value
    property real brushOpacity : opacitySlider.value

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



        Rectangle {
            id: openColorPicker
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            width: units.gu(4)
            height: units.gu(4)

            Checkerboard {}

            Rectangle {
                anchors.fill: parent
                color: colorPicker.paintColor
            }

            MouseArea {
                id: mousearea
                anchors.fill: parent
                onClicked: {
                    colorPicker.visible = !colorPicker.visible
                }
            }
        }


        VerticalSlider {
            id: opacitySlider
            anchors.horizontalCenter: parent.horizontalCenter
        }

        VerticalSlider {
            id: sizeSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minValue: 1
            maxValue: 80
            defaultValue: 30
        }
    }
} // END toolbar
