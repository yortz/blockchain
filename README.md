# Blockchain

A ruby web app based on the [Roda](https://github.com/jeremyevans/roda/tree/master/spec) framework which has two routes that save data in a Sqlite database using the [Sequel](https://github.com/jeremyevans/sequel) gem.

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

An example call is [https://etherchain.org/api/account/0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad](https://etherchain.org/api/account/0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad) which returns an address with balance 2000000000000000000.

example:

```
curl https://etherchain.org/api/account/0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad
```

Other accounts/ethereum-addresses you can add to the database are:

```
0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c
0xe0498570303d14456c71eb7f6f057ea149a425c6
0x8eeec35015baba2890e714e052dfbe73f4b752f9
0xfb663039763f61506f66158720f72794eddb1cc0
```

and you can pick more from here if you want/need: [https://etherscan.io/accounts/47?sort=txcount&order=asc](https://etherscan.io/accounts/47?sort=txcount&order=asc)
