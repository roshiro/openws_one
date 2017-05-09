# OpenWS - Public JSON storage service

[![Build Status](https://travis-ci.org/roshiro/openws_one.svg?branch=master)](https://travis-ci.org/roshiro/openws_one)
[![Code Climate](https://codeclimate.com/github/roshiro/openws_one/badges/gpa.svg)](https://codeclimate.com/github/roshiro/openws_one)

<img src="./public/static-images/logo.png" width="50">

OpenWS is a RESTFul service that allows you to easily save, retrieve, search, update and delete any JSON data in any collection name you want, without any authentication needed.

It is built in Ruby on Rails and MongoDB as storage.

## How to use OpenWS

### jQuery

OpenWS is a RESTFul service, so you can issue HTTP requests from browser via plain javascript, jQuery or any other JS framework of your choice.

Below is an example using `products` collection.

```javascript
// Create
var my_product = { name: "pizza" };
$.post("https://openws.org/api/collections/products", JSON.stringify(my_product))
  .done(function(data) {
    generated_id = data.id;
    console.log("ID: " + data.id);
    console.log("Name: " + data.name);
  });

// Get all items
$.get("https://openws.org/api/collections/products")
  .done(function(data) {
    var items = data["items"];
    for(idx in items) {
      console.log(items[idx].id + " - " + items[idx].name);
    }
  });

// Get one item
// Replace MY_PRODUCT_ID with the ID you want to get
$.get("https://openws.org/api/collections/products/MY_PRODUCT_ID")
  .done(function(data) {
    console.log(data.id + " - " + data.name);
  });

// Update
var updated_product = { name: "pepperoni pizza" }
$.ajax({
  url: "https://openws.org/api/collections/products/MY_PRODUCT_ID",
  data: JSON.stringify(updated_product),
  method: 'PUT',
  success: function(data) {
    console.log("ID: " + data.id);
    console.log("Name: " + data.name);
  }
});

// Delete
$.ajax({
  url: https://openws.org/api/collections/products/MY_PRODUCT_ID",
  method: 'DELETE',
  success: function(data) {
    console.log("Product deleted");
  }
});
```

### Terminal (Unix-based systems)
Below are some examples on how to make HTTP requests to OpenWS through terminal.
```
Creating
$ curl -X POST -H "Content-Type: application/json" -d '{"name":"coffee"}' https://openws.org/api/collections/products

Retrieving one item
$ curl -i -H "Accept: application/json" https://openws.org/api/collections/products/MY_PRODUCT_ID

Updating
$ curl X PUT -i -H "Accept: application/json" -d 'name'='coffee beans' https://openws.org/api/collections/products/MY_PRODUCT_ID

Deleting
$ curl -X DELETE -i -H "Accept: application/json" https://openws.org/api/collections/products/MY_PRODUCT_ID
```

## Running OpenWS locally

1. Install MongoDB
```
$> brew install mongodb
```
2. Start MongoDB service
```
$> mongod
```
3. Clone this repo
```
// in another terminal session
$> git clone git@github.com:roshiro/openws_one.git
```
4. Install gems
```
$> cd openws_one
$> bundle install
```
5. Start OpenWS
```
$> bundle exec rails s
```
Now OpenWS should be running in port 3000.


## Copyright & License

Copyright (c) 2016 Rafael Oshiro - Released under the [MIT license](https://github.com/roshiro/openws_one/blob/master/LICENSE).
