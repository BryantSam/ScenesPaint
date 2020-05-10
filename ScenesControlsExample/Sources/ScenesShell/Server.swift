import Igis
import Scenes

struct ServerLine {

    let line : Lines
    let color : Color
    let user : User
    
    init(line:Lines, color:Color, user:User){
        self.line = line
        self.color = color
        self.user = user
    }
}

class Server {
    static let maxInputs : Int = 200
    static var serverLines : [ServerLine] = []
    static var updateNum : Int = 0
    
    
    var toRenderIndex : Int = 0
    var localUser : User
    
    init(){
        localUser = User()
    }

    func clearServerLines() {
        Server.serverLines = []
    }

    func getWholeBoard() -> [ServerLine] {
        
        toRenderIndex = Server.serverLines.count
        
        return Server.serverLines

    }

    func getLocalLineUpdate() -> [ServerLine] {
        var allLines : [ServerLine] = []
        if Server.serverLines.count > 0 && toRenderIndex < Server.serverLines.count {
            for i in toRenderIndex ..< Server.serverLines.count {
                if Server.serverLines[i].user != localUser {
                    allLines.append(Server.serverLines[i])
                }
                
            }
           
        }
         toRenderIndex = Server.serverLines.count
        return allLines
       
    }

    static func uploadLines(lines:[ServerLine]) {
        Server.serverLines.append(contentsOf:lines)
        Server.updateNum += 1
    }

    

    
    
    
}
