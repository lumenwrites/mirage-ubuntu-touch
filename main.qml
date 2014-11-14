import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.rayalez.mirage"
    automaticOrientation: true
    useDeprecatedToolbar: false
    width: units.gu(100)
    height: units.gu(75)

    PageStack {
        id: pageStack
        anchors.fill:parent
        Component.onCompleted: {
            push(paintView)

            paintView.canvasArea.mainCanvas.onAvailableChanged.connect(function() {
                if (paintView.canvasArea.mainCanvas.available){
                    paintView.canvasArea.newPainting()
                }
            });


        }




        PaintView {
            id: paintView
            visible: false
        }

        PaintingsView {
            id: paintingsView
            visible: false
        }
    }

    // Create database
    U1db.Database {
        id: mirageDB
        path: "mirage.u1db"
    }

    // Create Document
    U1db.Document {
        id: drawingTemplate
        docId: "template"
        database: mirageDB
    }
    U1db.Index {
        database: mirageDB
        id: by_src
        expression: ["src"]
    }
    U1db.Query {
        id: modelQuery
        index: by_src
        query: [{"src":"*"}]
    }

}
