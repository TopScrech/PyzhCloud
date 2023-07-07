import Vapor
import PerfectSysInfo

func routes(_ app: Application) throws {
    // http://195.201.235.59:8080
    app.get { req async -> String in
        print(SysInfo.CPU)
        return "PyzhCloud is working"
//        do {
//            let test = "\(SysInfo.CPU)"
//            return "PyzhCloud is working!\(test)"
//        } catch {
//            return "PyzhCloud is almost working!"
//        }
    }
    
    // http://195.201.235.59:8080/hello
    app.get("hello") { req async -> String in
        print("hello")
        return "Hello, world!"
    }
    
    // http://195.201.235.59:8080/param/[param]
    app.get("param", ":id") { req -> String in
        guard let id = req.parameters.get("id") else {
            throw Abort(.notFound)
        }
        
        return "User ID: \(id)"
    }
    
//    // http://195.201.235.59:8080/status
//    app.get("status") { req async -> String in
//        do {
//            let serverResponse = try await getServerListAPI(req.client)
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let currentTime = dateFormatter.string(from: Date())
//            let serverStatus = serverResponse.servers.map {
//                $0.status
//            }.joined(separator: ", ")
//            let serverStatus = serverResponse.servers.map { $0.status }.joined(separator: ", ")
//            
//            return "Server status: \(serverStatus)\nLast update: \(currentTime)"
//        } catch {
//            return "Error: \(error)"
//        }
//    }
}
