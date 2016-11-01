# secret_santa
Match and notify recipients for a gift exchange.

## Installation
1. Clone this repository
2. Install dependencies by running `bundle install`.

## Usage

Create a config file using config_example.yml as an example. If you want to test your email settings, run `bin/test_email`.

Then run:

```
bin/secret_santa smith_family_2016.yml
```

This will output assignments into a file and prompt you to send emails to each participant. This is the equivalent of running `bin/assign` followed by `bin/notify`.

## Template Variables
In your config file you write the [Mustache](https://mustache.github.io/) template used to send messages to participants. These are the available template variables:

- `giver`: Person who is giving a gift.
- `recipient`: Person who is receiving the gift.

A person has the following properties:

- `email`
- `full_name`
- `first_name`
- `last_name`
