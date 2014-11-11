import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: toolbar
    width: units.gu(6)

    property alias brushSize : sizeSlider.value
    property real brushOpacity : opacitySlider.value
    property int brushShape : 0

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
            defaultValue: 0.5
        }

        VerticalSlider {
            id: sizeSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minValue: 1
            maxValue: 80
            defaultValue: 30
        }

        Rectangle {
            id: circularBrush
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            width: units.gu(4)
            height: units.gu(4)
            color: "transparent"

            Rectangle {
                id: circularBrushShape
                anchors.fill: parent
                color: Qt.lighter("gray")
                radius: height
                border.color: "white"
                border.width: 2
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    circularBrushShape.border.width = 2
                    circularBrushShape.color = Qt.lighter("gray")
                    rectangularBrushShape.border.width = 0
                    rectangularBrushShape.color = "gray"
                    toolbar.brushShape = 0
                }
            }
        }

        Rectangle {
            id: rectangularBrush
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            width: units.gu(4)
            height: units.gu(4)
            color: "transparent"

            Rectangle {
                id: rectangularBrushShape
                anchors.fill: parent
                color: "gray"
                border.color: "white"
                border.width: 0
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    circularBrushShape.border.width = 0
                    circularBrushShape.color = "gray"
                    rectangularBrushShape.border.width = 2
                    rectangularBrushShape.color = Qt.lighter("gray")
                    toolbar.brushShape = 1
                }
            }
        }


    }
} // END toolbar
