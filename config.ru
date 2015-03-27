use Rack::Static,
  :urls => ["/images", "/js", "/css", "/fonts",
            "/mapreduce1.html",
            "/mapreduce2.html",
            "/mapreduce3.html",

            "/kv1.html"
            ],
  :root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}