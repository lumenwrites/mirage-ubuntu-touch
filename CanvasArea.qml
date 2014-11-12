import QtQuick 2.0
import Ubuntu.Components 1.1
//import "paintLogic.js" as Logic
import "utilities.js" as Utilities
Item {
    property alias mainCanvas: mainCanvas
    property alias mouseArea: mouseArea
    property variant docRequested: null

    anchors {
        left: toolbar.right
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }
    //make it whole screen, under toolbar?
    //anchors.fill:parent
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
            id: pickCanvas
            width: 1
            height: 1
            visible: false
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

                property int spacing: 32 //32
                // ##
                property real deltaDab: Math.max(spacing / 100 * toolbar.brushSize, 1)
                property var points: []
                property point lastDrawPoint
                property point startPos
                property point finalPos
                property bool isColor: false

                // Bezier painting:

                // onPressed: { Logic.onPressed(mouseX, mouseY) }

                // onPositionChanged: { Logic.onPositionChanged(mouseX, mouseY) }

                // onReleased: {Logic.onReleased(mouseX, mouseY)}

                onPressed: {
                    var point = Qt.point(mouseX, mouseY)
                    points = []
                    if (!isColor) {
                        startPos = Qt.point(point.x, point.y)
                        finalPos = Qt.point(point.x, point.y)
                        lastDrawPoint = point
                        if (toolbar.brushShape != 1) {//if brush is not square
                            drawDab(point)
                        }
                        points = []
                        points.push(point)
                    } else {
                         var pc = pickCanvas.getContext("2d")
                         pc.clearRect(0, 0, 1, 1)
                        //pick color
                        var ctx = mainCanvas.getContext("2d")
                        var image = ctx.getImageData(mouseX, mouseY, mouseX+1, mouseY+1)

                        // fill pick canvas with white color before drawing image on top
                        // so that when I'm picking from empty canvas, it wouldn't be 0,0,0,0
                        pc.rect(0,0,1,1);
                        pc.fillStyle="white";
                        pc.fill();
                        pc.drawImage(image, 0, 0)

                        var p = pc.getImageData(0, 0, 1, 1).data
                        var hex = "#" + ("000000" + rgbToHex(p[0], p[1], p[2])).slice(-6)
                        colorPicker.paintColor = hex

                        // var i = 0
                        // for (i = 0; i < 10; i++){
                        //     console.log("canvas data: "+ p[i])
                        // }
                        // console.log("hex: " + hex)
                        dab.requestPaint()
                    }
                    //Hide Color Picker later move it to the whole screen.
                    colorPicker.visible = false
                }


                onPositionChanged: {
                    if (!isColor) {
                    var currentPoint = Qt.point(mouseX, mouseY)
                    var startPoint = lastDrawPoint


                    //Rotating the dab
                    if (toolbar.brushShape == 1) {//if brush is square
                        spacing = 16

                        if ( (currentPoint.x > startPoint.x))
                        {
                            dab.brushAngle = find_angle(Qt.point(startPoint.x, startPoint.y-10),
                            startPoint, currentPoint)
                            dab.requestPaint()
                        } else {
                            dab.brushAngle = - find_angle(Qt.point(startPoint.x, startPoint.y-10),
                            startPoint, currentPoint)
                            dab.requestPaint()
                        }
                    } else {
                        spacing = 32
                    }

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
                }
                }

                onReleased: {
                    if (!isColor) {
                    var bufferCtx = buffer.getContext("2d")
                    var canvasCtx = mainCanvas.getContext("2d")

                    //saving image
                    //var undoArea = canvasCtx.getImageData(startPos.x, startPos.y, finalPos.x - startPos.x, finalPos.y - startPos.y)

                    // Grab Buffer image
                    var bufferImage = bufferCtx.getImageData(0, 0, width, height)

                    // Clear the buffer
                    bufferCtx.clearRect(0, 0, width, height)
                    buffer.requestPaint()

                    /// Redraw the buffer image
                    canvasCtx.save()
                    // Stroke opacity!!
                    canvasCtx.globalAlpha = toolbar.brushOpacity
                    canvasCtx.drawImage(bufferImage, 0, 0)

                    canvasCtx.restore()
                    mainCanvas.requestPaint()
                } else {
                    isColor = false
                    paintView.toolbar.pickColorButton.border.width = 0


                }


                }

                function drawDab(point) {
                    var ctx = buffer.getContext("2d")
                    ctx.save()
                    var size = toolbar.maxBrushSize //toolbar.brushSize
                    var x = point.x - size / 2 // + size / 100 * (1 - 2 * Math.random())
                    var y = point.y - size / 2 // + size / 100 * (1 - 2 * Math.random())
                    if (x < startPos.x) { startPos.x = Math.min(0, x) }
                    if (y < startPos.y) { startPos.y = Math.min(0, y) }
                    if (x > finalPos.x) { finalPos.x = Math.max(x, buffer.width) }
                    if (y > finalPos.y) { finalPos.y = Math.max(y, buffer.height) }
                    ctx.drawImage(dab, x, y)
                    ctx.restore()

                    buffer.requestPaint()

                }

                // **************** Other ****************
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

                // Find Angle
                function find_angle(A,B,C) {
                    var AB = Math.sqrt(Math.pow(B.x-A.x,2)+ Math.pow(B.y-A.y,2));
                    var BC = Math.sqrt(Math.pow(B.x-C.x,2)+ Math.pow(B.y-C.y,2));
                    var AC = Math.sqrt(Math.pow(C.x-A.x,2)+ Math.pow(C.y-A.y,2));
                    return Math.acos((BC*BC+AB*AB-AC*AC)/(2*BC*AB));
                }

            }


        }

        function newPainting() {
            print("New Drawing");
            //undoStack.clear();
            // var date = new Date();
            // docName = Qt.formatDateTime(date, "yyMMddhhmmss");
            // clearRequested = true;
            // canvas.requestPaint();
            // canvas.width = mainView.width;
            // canvas.height = mainView.height;

            mainCanvas.getContext("2d").clearRect(0, 0, canvasArea.mainCanvas.width, canvasArea.mainCanvas.height)
            mainCanvas.requestPaint()

        }

        function openDrawing(doc) {
            print("opening " + doc.docId)
            //undoStack.clear();
            var docName = doc.docId;
            docRequested = doc;
            paintView.canvasArea.mainCanvas.requestPaint();
        }

        // Convert RGB to HEX
        function rgbToHex(r, g, b) {
            if (r > 255 || g > 255 || b > 255)
            throw "Invalid color component";
            return ((r << 16) | (g << 8) | b).toString(16);
        }

    }