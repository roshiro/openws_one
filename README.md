# OpenWS - Public JSON storage service

[![Build Status](https://travis-ci.org/roshiro/openws_one.svg?branch=master)](https://travis-ci.org/roshiro/openws_one)
[![Code Climate](https://codeclimate.com/github/roshiro/openws_one/badges/gpa.svg)](https://codeclimate.com/github/roshiro/openws_one)

<img src="./public/static-images/logo.png" width="50">

OpenWS is a RESTFul service that allows you to easily save, retrieve, search, update and delete any JSON data in any collection name you want, without any authentication needed.

It is built in Ruby on Rails and MongoDB as storage.

## How to use OpenWS

### jQuery

OpenWS is a RESTFul service, so you can issue HTTP requests from browser via plain javascript, jQuery or any other JS framework of your choice.

```javascript
// Saving in a collection called "products"
var my_product = { name: "milk" };
$.post("https://openws.org/api/collections/products", my_product)
  .done(function(data) {
    console.log("ID: " + data[0].id); // ID: 547ba6d00b07515f0d4b6c62
  });
```

### Terminal (Unix-based systems)
You can make HTTP requests from


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


## Contribute
