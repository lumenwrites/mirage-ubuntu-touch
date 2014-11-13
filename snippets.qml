// Draw a square dab
ctx.fillRect(mouse_area.mouseX-brush_size.value/2,
mouse_area.mouseY-brush_size.value/2,
brush_size.value,
brush_size.value )
Can
// Draw a line-dab
ctx.lineTo(lastX, lastY)
ctx.stroke()

// Old canvas mouse area
onPressed: {
    canvas.lastX = mouseX
    canvas.lastY = mouseY
}
onPositionChanged: {
    canvas.requestPaint()
}


    onPaint: {
        // Setup
        var ctx = getContext("2d")
        ctx.lineWidth = toolbar.brushSize
        ctx.strokeStyle = canvas.paintColor
        ctx.fillStyle = canvas.paintColor

        ctx.beginPath()
        ctx.moveTo(lastX, lastY)
        lastX = mouseArea.mouseX
        lastY = mouseArea.mouseY

        drawDab(lastX, lastY)
    }
