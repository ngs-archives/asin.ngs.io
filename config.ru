tag = 'ngsio-22'

run lambda {|env|
  asin = (env['PATH_INFO'] || '').sub %r{^/}, ''
  loc = "http://www.amazon.co.jp/gp/product/#{asin}/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=#{asin}&linkCode=as2&tag=#{tag}"
  asin.match(/^[A-Z0-9]{10}$/) ? [
    301,
    {
      'Content-Type' => 'text/plain',
      'Location' => loc
    },
    StringIO.new(%Q{<html><head><title>Redirecting</title><body>Redirecting to <a href="#{loc}">#{loc}</a></body></html>\n})
  ] : [
    400,
    {
      'Content-Type' => 'text/plain'
    },
    StringIO.new("Bad Access\n")
  ]
}
