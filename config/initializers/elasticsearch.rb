require 'faraday_middleware/aws_sigv4'

Elasticsearch::Model.client = Elasticsearch::Client.new(url: 'http://elasticsearch:9200', log: true)
  