import Igis
import Scenes
import ScenesControls

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer {
    let paintControlStyle = ControlStyle(foregroundStrokeStyle:StrokeStyle(color:Color(.black)),
                                         backgroundFillStyle:FillStyle(color:Color(.gray)),
                                         backgroundHoverFillStyle:FillStyle(color:Color(.gray)),
                                         padding:5)

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")


        // Create a standalone button, insert into LAYER, and assign handler
        let independentButton = Button(name:"Clear", labelString:"Clear",topLeft:Point(x:0, y:0), fixedSize:Size(width:100, height:20), controlStyle:paintControlStyle )
        insert(entity:independentButton, at:.front)
        independentButton.clickHandler = onButtonClickHandler
        

        // Create two panels, one vertical and one horizontal

        createPanel(name:"Horizontal", topLeft:Point(x:100, y:0), layoutStyle:.uniformRow)
    }


    // Create a labeled panel with several buttons
    func createPanel(name:String, labelString:String="", topLeft:Point, layoutStyle:Panel.LayoutStyle) {
        // Create and insert the panel into the LAYER
        let panel = Panel(name:name, topLeft:topLeft, layoutStyle:layoutStyle, controlStyle:paintControlStyle)
        insert(entity:panel, at:.front)

        // Create labels and buttons for panel and insert into PANEL
        let title = TextLabel(name:name+"title", labelString:".-=-=Paint=-=-.", controlStyle:paintControlStyle)
        let button2 = Button(name:name+"Button 1", labelString:"Black", controlStyle:paintControlStyle)
        let button3 = Button(name:name+"Button 2", labelString:"Red", controlStyle:paintControlStyle)
        let button4 = Button(name:name+"Button 3", labelString:"Blue", controlStyle:paintControlStyle)

        panel.insert(owningLayer:self, entity:title)
        panel.insert(owningLayer:self, entity:button2)
        panel.insert(owningLayer:self, entity:button3)
        panel.insert(owningLayer:self, entity:button4)
        
        // Assign handlers
       
        button2.clickHandler = onButtonClickHandler
        button3.clickHandler = onButtonClickHandler
        button4.clickHandler = onButtonClickHandler
    }
    
    // Labels can respond to clicks but usually don't
    func onLabelClickHandler(control:Control, localLocation:Point) {
        if let textLabel = control as? TextLabel {
            //textLabel.labelString += " More"
        }
    }

    // Buttons are generally only useful if they do respond to clicks
    func onButtonClickHandler(control:Control, localLocation:Point) {
        if let button = control as? Button {
            //button.labelString += " More"
            let label = button.text.text
            if let ms = scene as? MainScene {
                let dBox = ms.foregroundLayer.drawBox
                switch(label) {
                case "Black": dBox.color = Color(.black)
                case "Red": dBox.color = Color(.red)
                case "Blue": dBox.color = Color(.blue)
                case "Clear": dBox.clearQueued = true
                             
                default: print("lol")
                
                }
            }
            
        }
    }
    
  }
