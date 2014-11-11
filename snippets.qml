// Draw a square dab
ctx.fillRect(mouse_area.mouseX-brush_size.value/2,
mouse_area.mouseY-brush_size.value/2,
brush_size.value,
brush_size.value )

// Draw a line-dab
ctx.lineTo(lastX, lastY)
ctx.stroke()
