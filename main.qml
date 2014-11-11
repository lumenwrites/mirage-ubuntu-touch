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
                ctx.strokeStyle = "red"
                ctx.fillStyle = "red"


                console.log(dab.width/2)
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
