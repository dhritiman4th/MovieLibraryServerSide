import Vapor
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // Database
    let configuration = try SQLPostgresConfiguration(
        hostname: Environment.get("DB_HOST_NAME") ?? "localhost",
        username: Environment.get("DB_USERNAME") ?? "postgres",
        password: Environment.get("DB_PASSWORD") ?? "",
        database: Environment.get("DB_NAME") ?? "moviedb",
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
    app.jwt.signers.use(.hs256(key: Environment.get("JWT_SECRET_KEY") ?? "knightRider123"))
    // register routes
    try routes(app)
}
