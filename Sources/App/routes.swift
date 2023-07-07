import Vapor
import PerfectSysInfo

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

func getCPUUsage() -> (user: Int, system: Int) {
    do {
        var rusage = rusage()
        if getrusage(RUSAGE_SELF, &rusage) == 0 {
            let userTime = Int(rusage.ru_utime.tv_sec) * 1000000 + Int(rusage.ru_utime.tv_usec)
            let systemTime = Int(rusage.ru_stime.tv_sec) * 1000000 + Int(rusage.ru_stime.tv_usec)
            return (userTime, systemTime)
        } else {
            return (0, 0)
        }
    } catch {
        return (0, 0)
    }
}

//let cpuUsage = getCPUUsage()
//print("CPU usage: \(cpuUsage.user) user, \(cpuUsage.system) system")


func routes(_ app: Application) throws {
    // http://195.201.235.59:8080
    app.get { req async -> String in
//        print(SysInfo.Memory)
        print(getCPUUsage())
        return "PyzhCloud is working"
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
