var document
var date = new Date()
var docName = Qt.formatDateTime(date, "yyMMddhhmmss");
var docRequested = null
// **************** Database and files ****************
function newDrawing() {
    print("New Drawing");
    //undoStack.clear();
    var date = new Date();
    docName = Qt.formatDateTime(date, "yyMMddhhmmss");
    clearRequested = true;
    canvas.requestPaint();
    canvas.width = mainView.width;
    canvas.height = mainView.height;
}

function saveDrawing() {
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
