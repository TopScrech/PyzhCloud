import Vapor
import PerfectSysInfo
import Glibc

func getMemoryInfo() -> String {
    var info = [Int32]()
    var size = MemoryLayout<Int32>.size
    
    sysinfo(&info)
    
    let totalRAM = info[0]
    let freeRAM = info[1]
    let usedRAM = totalRAM - freeRAM
    
    return "Total RAM: \(totalRAM) MB, Free RAM: \(freeRAM) MB, Used RAM: \(usedRAM) MB"
}

func getCPUInfo() -> String {
    var info = [Int32]()
    var size = MemoryLayout<Int32>.size
    
    sysinfo(&info)
    
    let totalCPU = info[2]
    let freeCPU = info[3]
    let usedCPU = totalCPU - freeCPU
    
    return "Total CPU: \(totalCPU), Free CPU: \(freeCPU), Used CPU: \(usedCPU)"
}

func getDiskInfo() -> String {
    var stat = statvfs()
    statvfs("/", &stat)
    
    let diskSize = stat.f_blocks * stat.f_frsize
    let freeSpace = stat.f_bfree * stat.f_frsize
    let usedSpace = diskSize - freeSpace
    
    return "Total Disk Space: \(diskSize) bytes, Free Disk Space: \(freeSpace) bytes, Used Disk Space: \(usedSpace) bytes"
}

func routes(_ app: Application) throws {
    // http://195.201.235.59:8080
    app.get { req async -> String in
//        print(SysInfo.Memory)
        print(getMemoryInfo())
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
