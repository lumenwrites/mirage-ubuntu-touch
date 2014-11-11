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

        ColorPicker {
            id: color_picker
            anchors {
                left: toolbar.right
            }
        }

        CanvasArea {
        }

    } // END Column
}
