
import Igis
import Scenes
import ScenesControls

extension Point : Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

class DrawBox : RenderableEntity, MouseDownHandler, MouseUpHandler, MouseMoveHandler {
    static let defaultBox : Rect = Rect(topLeft:Point(x:50,y:50), size:Size(width:800,height:800))
    
    let boundingBox : Rect

    var isDrawing : Bool = false

    var color : Color = Color(.black)
    var lineWidth : Int = 1

    var clearQueued = false
    
    var pointsToDraw : Set<Point> = []
    var linesToDraw : [Lines] = []
    
    init(boundingBox:Rect?=nil) {
        self.boundingBox = boundingBox ?? DrawBox.defaultBox
    }

    func clear(canvas:Canvas) {
        canvas.render(StrokeStyle(color:Color(.black)), FillStyle(color:Color(.white)))
        canvas.render(Rectangle(rect:boundingBox, fillMode:.fillAndStroke))
    }

    func draw(canvas:Canvas) {
        
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        print("SETUP")
        clear(canvas:canvas)
        dispatcher.registerMouseDownHandler(handler:self)
        dispatcher.registerMouseUpHandler(handler:self)
        dispatcher.registerMouseMoveHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterMouseDownHandler(handler:self)
        dispatcher.unregisterMouseUpHandler(handler:self)
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }
    
    override func calculate(canvasSize:Size) {

    }

    

    func onMouseDown(globalLocation:Point) {
        if boundingBox.containment(target:globalLocation).contains(.containedFully) {
            isDrawing = true
            print(globalLocation)
            pointsToDraw.insert(globalLocation)
        }
    }

    func onMouseUp(globalLocation:Point) {
        isDrawing = false
    }

    func onMouseMove(globalLocation:Point, movement:Point) {
        if boundingBox.containment(target:globalLocation).contains(.containedFully) && isDrawing {

            pointsToDraw.insert(globalLocation)
            let comingFrom = globalLocation - movement
            linesToDraw.append(Lines(from:comingFrom, to:globalLocation))
        }
        if !boundingBox.containment(target:globalLocation).contains(.containedFully) {
            isDrawing = false
        }
    }
    
    override func render(canvas:Canvas) {

        if clearQueued {
            clear(canvas:canvas)
            clearQueued = false
        }
        
        canvas.render(StrokeStyle(color:color), FillStyle(color:color), LineWidth(width:lineWidth * 2))
        if !linesToDraw.isEmpty {
            for line in linesToDraw {
                canvas.render(line)
            }
        }
        linesToDraw = []
        if !pointsToDraw.isEmpty {
            for point in pointsToDraw {
                let rect = Rect(topLeft:point, size:Size(width:lineWidth, height:lineWidth))
                canvas.render(Rectangle(rect:rect, fillMode:.fill))
            }
        }
        pointsToDraw = []
    }
}
