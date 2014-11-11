import QtQuick 2.0
import Ubuntu.Components 1.1
Item {
    id: root
    anchors.fill: parent
    property color hueColor
    //units.gu(2) to compensate for margin
    property real saturation: pickerCursor.x/colorGradient.width
    property real brightness: 1-pickerCursor.y/colorGradient.height
    // Color Gradient
    Rectangle {
        id: colorGradient
        anchors.fill: parent
        anchors.margins: units.gu(1)
        rotation: -90
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FFFFFFFF" }
            GradientStop { position: 1.0; color: hueColor }
        }
    }

    // Black Gradient
    Rectangle {
        anchors.fill: parent
        anchors.margins: units.gu(1)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000000" }
            GradientStop { position: 1.0; color: "#FF000000" }
        }
    }

    // Just for margins
    Item {
        anchors.fill: parent
        anchors.margins: units.gu(1)
        // Picker Cursor
        Item {
            id: pickerCursor
            property int r : units.gu(1.5)
            x: 0; y: 0;
            width: units.gu(2); height: units.gu(2);
            Rectangle {
                x: -parent.r; y: -parent.r
                width: parent.r*2; height: parent.r*2
                radius: parent.r
                border.color: "black"; border.width: 2
                color: "transparent"
                Rectangle {
                    anchors.fill: parent; anchors.margins: 2;
                    border.color: "gray"; border.width: 2
                    radius: width/2
                    color: "transparent"
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            function handleMouse(mouse) {
                pickerCursor.x = Math.max(0, Math.min(width, mouse.x));
                pickerCursor.y = Math.max(0, Math.min(height, mouse.y));
                // pickerCursor.x = mouse.x + pickerCursor.width/2
                // pickerCursor.y = mouse.y + pickerCursor.height/2
            }
            onPositionChanged: handleMouse(mouse)
            onPressed: handleMouse(mouse)
        }
    }
}
