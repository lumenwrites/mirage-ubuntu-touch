import QtQuick 2.0
import Ubuntu.Components 1.1
import "paintLogic.js" as Logic
import "utilities.js" as Utilities
Item {
    property alias mainCanvas: mainCanvas
    property variant docRequested: null

    anchors {
        left: toolbar.right
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }

    Canvas {
        id: mainCanvas
        smooth: true
        anchors.fill:parent



        onPaint: {

            var ctx = mainCanvas.getContext('2d');

            // if (clearRequested) {
            //     print("clear requested");
            //     ctx.reset();
            //     ctx.fillStyle = "white";
            //     ctx.rect(0, 0, width, height);
            //     ctx.fill();
            //     clearRequested = false;
            // }

            if (docRequested) {
                print("doc requested")
                ctx.reset();
                ctx.fillStyle = "white";
                ctx.rect(0, 0, width, height);
                ctx.fill();
                ctx.drawImage(docRequested.contents.src, 0, 0);
                docRequested = null;
            }
        }
    }


    Canvas {
        id: buffer
        property real lastX
        property real lastY
        property color paintColor: colorPicker.paintColor
        smooth: false
        anchors.fill:parent
        // Stroke Opacity while drawing
        opacity: toolbar.brushOpacity

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            property int spacing: 32
            // ##
            property real deltaDab: Math.max(spacing / 100 * toolbar.brushSize, 1)
            property var points: []
            property point lastDrawPoint
            property point startPos
            property point finalPos


            onPressed: { Logic.onPressed(mouseX, mouseY) }

            onPositionChanged: { Logic.onPositionChanged(mouseX, mouseY) }

            onReleased: {Logic.onReleased(mouseX, mouseY)}
        }


    }

    function openDrawing(doc) {
        print("opening " + doc.docId)
        //undoStack.clear();
        var docName = doc.docId;
        docRequested = doc;
        paintView.canvasArea.mainCanvas.requestPaint();
    }
}