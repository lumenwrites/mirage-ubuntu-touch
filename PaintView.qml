import QtQuick 2.0
import Ubuntu.Components 1.1

Page {
    property alias canvasArea: canvasArea
    property alias toolbar: toolbar

    Toolbar {
        id: toolbar
    }

    // Test Text
    Text {
        y:40
        anchors.horizontalCenter : parent.horizontalCenter
        text: "Hue : " + colorPicker.hue + "<br/>"
        + "Saturation : " + colorPicker.saturation + "<br/>"
        + "Brightness : " + colorPicker.brightness + "<br/>"
        + "Opacity : " + toolbar.brushOpacity + "<br/>"
        + "Size : " + toolbar.brushSize + "<br/>"
        + "Dab Width : " + dab.width + "<br/>"
        + "Dab Height : " + dab.height + "<br/>"
    }

    ColorPicker {
        id: colorPicker
        visible: false
        anchors {
            left: toolbar.right
        }
    }

    CanvasArea {
        id: canvasArea
    }

    // Component.onCompleted: {
    //     dab.requestPaint()
    // }

    // Canvas {
    //     x:300;y:300

    //     id: dab
    //     visible: false
    //     antialiasing: false //true
    //     smooth: false
    //     width: toolbar.maxBrushSize
    //     height: toolbar.maxBrushSize

    //     property real brushWidth: toolbar.brushSize
    //     property real brushHeight: toolbar.brushSize

    //     onAvailableChanged:requestPaint()

    //     property real brushAngle: 0

    //     onPaint: {
    //         var ctx = getContext("2d")
    //         ctx.save()
    //         ctx.clearRect(0, 0, width, height)
    //         ctx.fillStyle = colorPicker.paintColor

    //         // ctx.lineWidth = 4
    //         // ctx.strokeStyle = "blue"


    //         var originX = width/2
    //         var originY = width/2
    //         ctx.translate(originX, originY)

    //         if (toolbar.brushShape == 0) {
    //             ctx.beginPath();
    //             ctx.arc(0, 0, brushWidth/2 ,0,Math.PI*2,true);
    //         } else {
    //             ctx.beginPath()
    //             ctx.rotate(brushAngle)
    //             // ctx.fillRect(-brushWidth/4, -brushWidth/8,
    //             // brushWidth/2, brushWidth/4)
    //             ctx.roundedRect(-brushWidth/4, -brushWidth/8,
    //             brushWidth/2, brushWidth/4, 2, 2)
    //         }

    //         ctx.fill()
    //         dab.requestPaint()
    //         ctx.restore();

    //     }
    // }
}
