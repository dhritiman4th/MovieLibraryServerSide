import Vapor
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    guard let hostName = Environment.get("DB_HOST_NAME"),
          let username = Environment.get("DB_USERNAME"),
          let pass = Environment.get("DB_PASSWORD"),
          let databaseName = Environment.get("DB_NAME"),
          let jwtSecretKey = Environment.get("JWT_SECRET_KEY") else {
        throw Abort(.expectationFailed, reason: "Server configuration failed.")
    }
    
    // Database
    let configuration = try SQLPostgresConfiguration(
        hostname: hostName,
        username: username,
        password: pass,
        database: databaseName,
        tls: .prefer(NIOSSLContext(configuration: .clientDefault)))
    app.databases.use(.postgres(configuration: configuration), as: .psql)
    
    // Migrations
    app.migrations.add(CreateUserTableMigration())
    app.migrations.add(CreateLanguageTableMigration())
    app.migrations.add(CreateMovieTableMigration())
    
    // Register controllers
    try app.register(collection: UserController())
    try app.register(collection: LanguageController())
    try app.register(collection: MovieController())
    
    // JWT
    app.jwt.signers.use(.hs256(key: jwtSecretKey))
    // register routes
    try routes(app)
}
