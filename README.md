<p align="center">
  <a href="https://eliraybon.github.io/ElectronAligner/">
    <img height="200px" src="https://github.com/eliraybon/mortgagehippo_code_challenge/blob/master/app/assets/coins-duotone.svg">
  </a>
</p>

# <h1 align="center">Coin Machine API</h1>

API URL: https://coin-machine-api.herokuapp.com/


## Authentication 

Authentication is achieved by sending an API key in each HTTP request header. Feel free to use this demo key when making requests: ```Fx69nbJ8M0N5oQnyeek5rQtt```

Just add a key of either ```token``` or ```key``` to the request header with a value set to your API key. 
Below is an example request using Postman:

<p align="center">
  <a href="https://eliraybon.github.io/ElectronAligner/">
    <img height="200px" src="https://github.com/eliraybon/mortgagehippo_code_challenge/blob/master/app/assets/authentication.png">
  </a>
</p>

## Database Schema

## ```coins```

| column name           | data type | details                             |
|-----------------------|-----------|-------------------------------------|
| ```id```              | integer   | not null, primary key               |
| ```name```            | string    | not null, unique                    |
| ```value```           | string    | not null, represents value in cents |
| ```quantity```        | integer   | not null, default: 0                |

## ```transactions```

| column name           | data type | details                                        |
|-----------------------|-----------|------------------------------------------------|
| ```id```              | integer   | not null, primary key                          |
| ```user_id```         | integer   | not null, indexed, foreign key                 |
| ```coin_id```         | integer   | not null, foreign key                          |
| ```type```            | string    | not null, used for single table inheritance    |

## ```users```

| column name           | data type | details                                        |
|-----------------------|-----------|------------------------------------------------|
| ```id```              | integer   | not null, primary key                          |
| ```email```           | string    | not null, unique                               |
| ```api_key```         | string    | not null, unique                               |
| ```type```            | string    | not null, used for single table inheritance    |

* All tables also include timestamps


## API Endpoints

### ```coins```
- ```GET /api/coins``` returns all coins
- ```GET /api/coin/:id``` returns single coin
- ```POST /api/coins``` creates a coin
- ```PATCH /api/coins/:id``` updates a coin
- ```DELETE /api/coins/:id``` removes a coin
- ```GET /api/total``` returns total value of all coins in the system (in dollars)

### ```transactions``` 
- ```GET /api/transactions``` returns all transactions 
- ```POST /api/transactions/deposit``` deposit a coin
- ```POST /api/transactions/withdrawal``` withdraw a coin

### ```users```
- ```GET /api/users/:id/transactions``` returns all transactions scoped to a specific user 
- ```POST /api/users``` creates a new user / generates API key
- ```POST /api/users/admin``` creates an admin for testing warning emails

When making POST requests to create new ```coins```, ```transactions```, or ```users```, make sure to nest your params in the request body. For example, creating a coin would look like this: 

<p align="center">
  <a href="https://eliraybon.github.io/ElectronAligner/">
    <img height="200px" src="https://github.com/eliraybon/mortgagehippo_code_challenge/blob/master/app/assets/creating_coin.png">
  </a>
</p>


This works the same way for ```transactions``` and ```users``` even though you're only sending up one param - transactions[coin_id] or user[email]. 

One thing worth noting is that I'm using single-table inheritance for transactions, deposits, and withdrawals. ```Deposit``` and ```Withrawal``` are both subclasses of ```Transaction```, but all the data is being kept in the ```transactions``` table. This felt like a perfect use case. I'm using a similar pattern for users and admins. 

The admin emails are currently being sent synchronously, but there seems to be a great async solution using ```Redis``` + ```sidekiq``` that I'm going to implement if I have more time. 
