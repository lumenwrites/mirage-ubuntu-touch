var spacing = 6400000 //32

var deltaDab = Math.max(spacing * toolbar.brushSize, 8)
var points = []
var lastDrawPoint
var startPos
var finalPos


function onPressed(mouseX, mouseY) {
    var point = Qt.point(mouseX, mouseY)

    startPos = Qt.point(point.x, point.y)
    finalPos = Qt.point(point.x, point.y)

    lastDrawPoint = point
    drawDab(point)
    points = []
    points.push(point)

    //Hide Color Picker later move it to the whole screen.
    colorPicker.visible = false

}


function onPositionChanged(mouseX, mouseY) {
    var currentPoint = Qt.point(mouseX, mouseY)
    var startPoint = lastDrawPoint


    // Rotating the dab

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

function onReleased (mouseX, mouseY) {
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
