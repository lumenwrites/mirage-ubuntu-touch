import QtQuick 2.0
import Ubuntu.Components 1.1

Canvas {
    id: canvas
    property real lastX
    property real lastY
    property color paintColor: colorPicker.paintColor

    anchors {
        left: toolbar.right
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }


    onPaint: {
        // Setup
        var ctx = getContext("2d")
        ctx.lineWidth = toolbar.brushSize
        ctx.strokeStyle = canvas.paintColor
        ctx.fillStyle = canvas.paintColor

        ctx.beginPath()
        ctx.moveTo(lastX, lastY)
        lastX = mouse_area.mouseX
        lastY = mouse_area.mouseY

        if (!toolbar.brushShape){
            ctx.arc(lastX, lastY, toolbar.brushSize, 0, Math.PI*2, true);
            ctx.fill();
        } else {
            ctx.fillRect(mouse_area.mouseX-toolbar.brushSize,
            mouse_area.mouseY-toolbar.brushSize,
            toolbar.brushSize*2,
            toolbar.brushSize*2);
            ctx.closePath();
            ctx.fill();
        }

    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        onPressed: {
            canvas.lastX = mouseX
            canvas.lastY = mouseY
        }
        onPositionChanged: {
            canvas.requestPaint()
        }
    }


}
