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
            visible: false
            anchors {
                left: toolbar.right
            }
        }

        CanvasArea {
        }

        //export canvas
        // Canvas {
        //     id: mainCanvas
        //     width: imageSize.width
        //     height: imageSize.height
        //     onAvailableChanged: {
        //         for (var i = layerModel.count - 1; i > -1; i--) {
        //             var canvas = layerModel.get(i).canvas
        //             var image = canvas.getContext("2d").getImageData(0, 0, width, height)
        //             getContext("2d").drawImage(canvas, 0, 0)
        //         }
        //         finished()
        //     }
        // }

        Component.onCompleted: dab.requestPaint()
        Canvas {
            id: dab
            visible: false
            antialiasing: true
            smooth: false
            onAvailableChanged: requestPaint()
            width: 80
            height: 80
            onPaint: {
                var ctx = getContext("2d")
                ctx.save()
                ctx.clearRect(0, 0, width, height)
                ctx.fillStyle = colorPicker.paintColor

                var originX = width/2
                var originY = width/2
                ctx.translate(originX, originY)

                ctx.arc(0, 0, width/2, 0, Math.PI*2, true);
                ctx.fill();

                ctx.fill()
                dab.requestPaint()
                ctx.restore();
            }
        }
        } // END Column
    }
