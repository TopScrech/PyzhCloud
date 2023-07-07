import Vapor
import App

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)

app.http.server.configuration.hostname = "127.0.0.1"
app.http.server.configuration.port = 8080

try app.run()
