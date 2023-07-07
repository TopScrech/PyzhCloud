import Foundation
import Vapor

public struct ServerResponse: Codable {
    let servers: [Server]
}

public struct Server: Codable {
    let name, status: String
}

func getServerListAPI(_ client: Client) async throws -> ServerResponse {
    let url = URI("https://api.hetzner.cloud/v1/servers")
    let headers = HTTPHeaders([
        ("Content-Type", "application/json"),
        ("Authorization", "Bearer XnSwA5cLNARl4D93H8Vc8CSQUwfedZGZpbV4D5BhzBcOiC35zDqePCTaRCQf93Fv")
    ])

    let response = try await client.get(url, headers: headers)
    let json = try response.content.decode(ServerResponse.self)

    return json
}
