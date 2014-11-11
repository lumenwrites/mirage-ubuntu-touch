import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    id:root
    //From minValue to maxValue
    property real value: map_range(sliderValue, 0, 1, minValue, maxValue)
    // From 0 to 1
    property real sliderValue: (1 - handle.y/(handleArea.height-handle.height))
    property real minValue: 0
    property real maxValue: 1
    property real defaultValue: 1

    function map_range(value, low1, high1, low2, high2) {
        return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
    }

    width: units.gu(4); height: units.gu(32)


    // Background
    Rectangle {
        anchors.fill: parent
        color: Qt.darker(UbuntuColors.coolGrey)
        radius: units.gu(2)
    }

    Item {
        id: handleArea
        anchors.fill: parent
        anchors.margins: units.gu(0.4)
        // Handle
            width: parent.width
            Rectangle {
                id: handle

                //Default Value
                y: map_range(defaultValue, minValue, maxValue, 1, 0)
                *(handleArea.height-handle.height)

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: units.gu(3)
                color: Qt.lighter(UbuntuColors.coolGrey)
                radius: units.gu(2)
            }
    }

    MouseArea {
        anchors.fill: parent
        function handleMouse(mouse) {
            if (mouse.buttons & Qt.LeftButton) {
                handle.y = Math.max(0, Math.min(handleArea.height-handle.height, mouse.y))
            }
        }
        onPositionChanged: handleMouse(mouse)
        onPressed: handleMouse(mouse)
    }
}