use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use clap::{App as ClappAPp, Arg};

async fn echo(req_body: String) -> impl Responder {
    println!("got a request with a message: {req_body}");
    HttpResponse::Ok().body(req_body)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let matches = ClappAPp::new("Example Echo Service for Hydra")
        .arg(
            Arg::with_name("host")
                .short("h")
                .long("host")
                .value_name("HOST")
                .default_value("0.0.0.0")
                .help("Sets the host address"),
        )
        .arg(
            Arg::with_name("port")
                .short("p")
                .long("port")
                .value_name("PORT")
                .default_value("8080")
                .help("Sets the port"),
        )
        .get_matches();

    let host = matches.value_of("host").unwrap();
    let port = matches.value_of("port").unwrap();

    println!("starting service at: {}:{}", host, port);
    println!("==HYDRA Notification== Server is ready for handling requests.");

    HttpServer::new(|| App::new().route("/echo", web::post().to(echo)))
        .bind(format!(
            "{}:{}",
            host,
            port
        ))?
        .run()
        .await
}
