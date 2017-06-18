# Blockchain

A ruby web app based on the Roda framework which has two routes that save data in a Sqlite database using the Sequel gem.

## Usage:

```
 $ cd blockchain
 $ gem install bundler
 $ bundle
```

Bootstrap DB:

```
 $ bundle exec rake db:boostrap
```

## Test

```
  $ rspec
```

## Endpoints

Assuming that you are running your app with pow mounted under blockchain.dev you
can issue the following:

### GET request
Responds with a JSON list of all the accounts and balances retrieved from the database plus the converted wei value for that address.

```
$ curl --request GET 'http://blockchain.dev/api/v1/accounts' --include
```

### POST request
Accepts a parameter, address. Fetches the ethereum account/address balance from the external API and saves it to the database.
Responds with status according to the fact that the save was successfull or not
(e.g. calling with no params or trying to fetch a balance for an undefined
address).

```
$ curl --request POST "http://blockchain.dev/api/v1/accounts" --data "address=0x8eeec35015baba2890e714e052dfbe73f4b752f9"
```
