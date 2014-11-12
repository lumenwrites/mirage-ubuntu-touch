import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: root

    property alias text: label.text
    property alias iconSource: icon.source
    signal clicked

    anchors.horizontalCenter: parent.horizontalCenter
    width: units.gu(4)
    height: units.gu(4)
    color: Qt.darker(UbuntuColors.coolGrey)

    Text {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
    }

    // OrientationHelper {
    //     anchors.fill: parent
        Image {
            id: icon
            anchors.fill: parent
            anchors.margins: 2
        }
    //}

    MouseArea {
        id: mousearea
        anchors.fill: parent
        onClicked: root.clicked()
    }

}
