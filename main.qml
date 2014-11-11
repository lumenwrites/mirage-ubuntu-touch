import QtQuick 2.0
import Ubuntu.Components 1.1

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.rayalez.mirage"
    automaticOrientation: true
    useDeprecatedToolbar: false
    width: units.gu(100)
    height: units.gu(75)

    Page {
        Toolbar {
            id: toolbar
        }

        Text {
            y:40
            anchors.horizontalCenter : parent.horizontalCenter
            text: "Hue : " + colorPicker.hue + "<br/>"
            + "Saturation : " + colorPicker.saturation + "<br/>"
            + "Brightness : " + colorPicker.brightness + "<br/>"
            + "Opacity : " + toolbar.brushOpacity + "<br/>"
            + "Size : " + toolbar.brushSize + "<br/>"
        }

        ColorPicker {
            id: colorPicker
            visible: true
            anchors {
                left: toolbar.right
            }
        }

        CanvasArea {
        }

    } // END Column
}
