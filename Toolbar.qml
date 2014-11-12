import QtQuick 2.0
import Ubuntu.Components 1.1
import "utilities.js" as Utilities

Rectangle {
    id: toolbar
    width: units.gu(6)

    property alias brushSize : sizeSlider.value
    property real brushOpacity : opacitySlider.value
    property int brushShape : 0
    property alias maxBrushSize: sizeSlider.maxValue
    property alias pickColorButton: pickColor

    //Make it above the canvas?
    //z: 8
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

        ToolbarSmallButton {
            id: pickColor
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                if (canvasArea.mouseArea.isColor ==false){
                    canvasArea.mouseArea.isColor = true
                    border.width = 2
                } else {
                    canvasArea.mouseArea.isColor = false
                    border.width = 0
                }
            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            border.color: "white"
            border.width: 0
            iconSource: "icons/color-picker.png"
        }



        VerticalSlider {
            id: opacitySlider
            anchors.horizontalCenter: parent.horizontalCenter
            defaultValue: 1
            height: units.gu(16)
        }

        VerticalSlider {
            id: sizeSlider
            anchors.horizontalCenter: parent.horizontalCenter
            minValue: units.gu(4)
            maxValue: units.gu(32)
            defaultValue: units.gu(8)
            height: units.gu(16)
        }

        Rectangle {
            id: brushes
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            width: units.gu(4)
            height: units.gu(4)
            color: "transparent"

            Rectangle {
                id: brushShapeIcon
                anchors.fill: parent
                color: Qt.lighter("gray")
                border.color: "white"
                border.width: 2
                radius:height
                Image {
                    anchors.fill: parent
                    anchors.margins: 0
                    source: "icons/brush.png"
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (toolbar.brushShape == 1) {
                        toolbar.brushShape = 0
                        brushShapeIcon.radius = brushShapeIcon.height
                    } else {
                        toolbar.brushShape = 1
                        brushShapeIcon.radius = 0
                    }

                    dab.requestPaint()
                }
            }
        }

        ToolbarSmallButton {
            id: separator
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
            color: Qt.lighter(UbuntuColors.coolGrey)
        }

        ToolbarSmallButton {
            id: fillWithColor
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var ctx = canvasArea.mainCanvas.getContext("2d")
                ctx.fillStyle = colorPicker.paintColor
                //clearRect(0, 0, canvasArea.mainCanvas.width, canvasArea.mainCanvas.height)
                ctx.fillRect(0, 0, canvasArea.mainCanvas.width, canvasArea.mainCanvas.height)
                canvasArea.mainCanvas.requestPaint()
            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            iconSource: "icons/fill-with-color.png"
        }

        ToolbarSmallButton {
            id: savePainting
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                Utilities.saveDrawing()
            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            iconSource: "icons/save-icon.png"
        }



        ToolbarSmallButton {
            id: openDrawer
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                pageStack.push(paintingsView)
            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            iconSource: "icons/drawer-icon.png"
        }


    }
} // END toolbar
