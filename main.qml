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

        // Canvas {
        //     id: dab
        //     visible: false
        //     antialiasing: true
        //     smooth: false
        //     onAvailableChanged: requestPaint()
        //     onPaint: {
        //         var ctx = getContext("2d")
        //         ctx.save()
        //         ctx.clearRect(0, 0, width, height)
        //         var originX = width / 2
        //         var originY = width / 2
        //         ctx.translate(originX, originY)
        //         ctx.rotate(brushSettings.angle / 180 * Math.PI)
        //         ctx.scale(1.0, brushSettings.roundness / 100)
        //         ctx.translate(-originX, -originY)
        //         var color = Qt.rgba(colorPicker.color.r, colorPicker.color.g, colorPicker.color.b, brushSettings.flow / 100)
        //         var gradient = ctx.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, width / 2)
        //         gradient.addColorStop(0, color);
        //         gradient.addColorStop(brushSettings.hardness / 100, color);
        //         gradient.addColorStop(1, Qt.rgba(colorPicker.color.r, colorPicker.color.g, colorPicker.color.b, brushSettings.hardness / 100 < 1 ? 0 : brushSettings.flow / 100));
        //         ctx.ellipse(0, 0, width, width)
        //         ctx.fillStyle = gradient
        //         ctx.fill()
        //         ctx.restore();
        //     }
        } // END Column
    }
