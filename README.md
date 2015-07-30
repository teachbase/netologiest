# Netologiest
Netology Ruby API client

API for Netology (http://netology.ru/) e-learning intergration.

## Configuration

Netology contains two configuration attributes.
The first is `api_key`.
The second is `api_url`.
For example:

```ruby
  api_key: "your_api_key_here"
  api_url: "http://dev.netology.ru/content_api"

```

Configuration parameters should be placed to `secrets.yml` file

```ruby
....
  netologiest:
    api_key: "your_api_key_here"
    api_url: "http://dev.netology.ru/content_api"
....
``` 

## Usage

Netologiest having only one resource at moment. It is a course.
And you can get list of courses

```ruby
  Netologiest::Course.list
```

It returns array of hashes. E.g.

```ruby
  [
    {
      "id" => "1",
      "name" => "Direct marketing. Basics.",
      "last_updated_at" => "1387176082"
    },
    {
      "id" => "2",
      "name" => "Test course #1",
      "last_updated_at" => "1386236837"
    },
    {
      "id" => "3",
      "name" => "How to make course.",
      "last_updated_at" => "1387176130"
    }
  ]
```

Also you can get detailed information about any course:

```ruby
  # argument is Course ID 
  Netologiest::Course.detail(1)
```

It also returns a hash.

```ruby
  {
    "id" => 931,
    "name" => "Name of course",
    "description" => "Description of course",
    "progress" => 0,
    "duration" => 47,
    "level" => { ... },
    "tags" => [{..}, {..}, {..}]
    ....
    "blocks" => [
      ...
      {
        "lessons" => []
      }
      ...
    ]
  }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/netologiest/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request