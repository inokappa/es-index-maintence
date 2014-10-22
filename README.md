es-index-maintence
==================

## About

Index maintenance for Elasticsearch.

***

## How to Use

### modify config

~~~
def config 
  { 
    :host => "#{elasticsearch host}", 
    :port => #{elasticsearch port}, 
    :date => #{retention date}, 
    :prefix => "#{index prefix}" 
  } 
end
~~~

***

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chef-handler-jenkins_notifier/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
