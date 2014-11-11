import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    property real value: (1 - verticalSlider.y/height)
    width: 15; height: 300
    Item {
        id: verticalSlider
        width: parent.width
        Rectangle {
            x: -units.gu(1); y: -height*0.5
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
                verticalSlider.y = Math.max(0, Math.min(height, mouse.y))
            }
        }
        onPositionChanged: handleMouse(mouse)
        onPressed: handleMouse(mouse)
    }
}