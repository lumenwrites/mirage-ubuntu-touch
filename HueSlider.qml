import QtQuick 2.0
import Ubuntu.Components 1.1

// HueSlider
Item {
    width: units.gu(5); height: parent.height
    property real value: (1 - verticalSlider.y/(height-units.gu(2)))

    Rectangle {
        id: background
        anchors.fill:parent
        color: Qt.darker(UbuntuColors.coolGrey)
        width: 15; height: 300

        // Color Gradient
        Rectangle {
            id: colorGradient
            anchors.fill: parent
            anchors.margins: units.gu(1)
            gradient: Gradient {
                GradientStop { position: 1.0;  color: "#FF0000" }
                GradientStop { position: 0.85; color: "#FFFF00" }
                GradientStop { position: 0.76; color: "#00FF00" }
                GradientStop { position: 0.5;  color: "#00FFFF" }
                GradientStop { position: 0.33; color: "#0000FF" }
                GradientStop { position: 0.16; color: "#FF00FF" }
                GradientStop { position: 0.0;  color: "#FF0000" }
            }
        }

        Item {
            id: verticalSlider
            width: parent.width
            anchors.margins: units.gu(1)
            Rectangle {
                x: -units.gu(1); y: 0
                width: parent.width + units.gu(2); height: units.gu(2)
                border.color: "black"; border.width: 2
                color: "transparent"
                Rectangle {
                    anchors.fill: parent; anchors.margins: 2
                    border.color: "white"; border.width: 1
                    color: "transparent"
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            function handleMouse(mouse) {
                if (mouse.buttons & Qt.LeftButton) {
                    verticalSlider.y = Math.max(0, Math.min(height-units.gu(2), mouse.y))
                }
            }
            onPositionChanged: handleMouse(mouse)
            onPressed: handleMouse(mouse)
        }
    } // Rectangle.end
}