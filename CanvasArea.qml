import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    Canvas {
        id: buffer
        property real lastX
        property real lastY
        property color paintColor: colorPicker.paintColor
        smooth: false
        opacity: 0.5

        anchors {
            left: toolbar.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }



        // Mouse Area
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            property int spacing: 64
            // ##
            property real deltaDab: Math.max(spacing / 100 * toolbar.brushSize, 1)
            property var points: []
            property point lastDrawPoint
            property point startPos
            property point finalPos

            // Bezier Curve
            function bezierCurve(start, control, end, t) {
                var x, y
                // linear bezier curve
                if (!control) {
                    x = (1 - t) * start.x + t * end.x
                    y = (1 - t) * start.y + t * end.y
                }
                // quad bezier curve
                else {
                    x = Math.pow((1 - t), 2) * start.x + 2 * t * (1 - t) * control.x + t * t * end.x
                    y = Math.pow((1 - t), 2) * start.y + 2 * t * (1 - t) * control.y + t * t * end.y
                }
                return Qt.point(x, y)
            }

            onPressed: {
                var point = Qt.point(mouseX, mouseY)

                startPos = Qt.point(point.x, point.y)
                finalPos = Qt.point(point.x, point.y)

                lastDrawPoint = point
                drawDab(point)
                points = []
                points.push(point)
            }

            onPositionChanged: {
                var currentPoint = Qt.point(mouseX, mouseY)
                var startPoint = lastDrawPoint

                // ##
                var currentSpacing = Math.sqrt(Math.pow(currentPoint.x - startPoint.x, 2) + Math.pow(currentPoint.y - startPoint.y, 2))
                var numDabs = Math.floor(currentSpacing / deltaDab)

                // ##
                if (points.length == 1 || numDabs < 3) {
                    var endPoint = currentPoint
                } else {
                    var controlPoint = points[points.length - 1]
                    endPoint = Qt.point((controlPoint.x + currentPoint.x) / 2, (controlPoint.y + currentPoint.y) / 2)
                }

                // ##
                var deltaT = 1 / numDabs
                var betweenPoint = startPoint
                var t = deltaT
                var diff
                while (t > 0 && t <= 1) {
                    var point = bezierCurve(startPoint, controlPoint, endPoint, t)
                    var deltaPoint = Math.sqrt(Math.pow(point.x - betweenPoint.x, 2) + Math.pow(point.y - betweenPoint.y, 2))
                    // check on bezier loop
                    if (diff && Math.abs(deltaPoint - deltaDab) > Math.abs(diff)) { break; }
                    diff = deltaPoint - deltaDab
                    if (Math.abs(diff <= 0.5)) {
                        drawDab(point)
                        diff = undefined
                        betweenPoint = point
                        t += deltaT
                    } else {
                        t -= diff / deltaDab * deltaT
                    }
                }
                points.push(currentPoint)
                lastDrawPoint = betweenPoint
            } // END onPositionChaned

            // On Released
            onReleased: {
                var bufferCtx = buffer.getContext("2d")
                //var canvasCtx = canvas.getContext("2d"

                //saving image
                //var undoArea = canvasCtx.getImageData(startPos.x, startPos.y, finalPos.x - startPos.x, finalPos.y - startPos.y)

                // Grab Buffer image
                var bufferImage = bufferCtx.getImageData(0, 0, width, height)

                // Clear the buffer
                bufferCtx.clearRect(0, 0, width, height)
                parent.requestPaint()

                /// Redraw the buffer image
                bufferCtx.drawImage(bufferImage, 0, 0)
            }

            function drawDab(point) {
                var ctx = buffer.getContext("2d")
                ctx.lineWidth = toolbar.brushSize
                ctx.strokeStyle = buffer.paintColor
                ctx.fillStyle = buffer.paintColor

                // if (!toolbar.brushShape){
                    //     ctx.arc(point.x, point.y, toolbar.brushSize, 0, Math.PI*2, true);
                    //     ctx.closePath();
                    //     ctx.fill();
                    // } else {
                        //     ctx.fillRect(point.x-toolbar.brushSize,
                        //     point.y-toolbar.brushSize,
                        //     toolbar.brushSize*2,
                        //     toolbar.brushSize*2);
                        //     ctx.closePath();
                        //     ctx.fill();
                        // }

                        // >>>>>
                        ctx.drawImage(dab, point.x-toolbar.brushSize, point.y-toolbar.brushSize)
                        ctx.restore()
                        //buffer.markDirty(x, y, dab.width, dab.height)
                        buffer.requestPaint()

                    }


                } // END mouseArea


            }
        }