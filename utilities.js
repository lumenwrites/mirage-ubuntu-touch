// **************** Database and files ****************

function saveDrawing() {
    var document
    var date = new Date()
    var docName = Qt.formatDateTime(date, "yyMMddhhmmss");

    document = {};
    document = drawingTemplate;
    document.docId = docName;
    document.contents = {"src": paintView.canvasArea.mainCanvas.toDataURL("image/png")};
}

function undo() {
    // print("undoing");
    undoRequested = true;
    canvas.requestPaint();
}
