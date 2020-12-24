# SeamlessMD FHIR API

App gets information from https://hapi.fhir.org/resource?serverId=home_r4&pretty=false&_summary=&resource=Patient and 
display some statistics 

## Prerequisites
Rails version: 6.0.3.4

Ruby version: 2.7.0

Postgres version: 12

## Requirements

    1. Create a simple rails web application (you can use whatever boilerplate you think best e.g. rails new)
    2. Go to the sandbox site: http://hapi.fhir.org/, this is a test server from UHN to test out FHIR API calls (https://en.wikipedia.org/wiki/Fast_Healthcare_Interoperability_Resources ) – the latest interoperability standard to exchange health information. Note: we don’t own this server but regularly use it to do FHIR testing. We regularly use FHIR calls to integrate with hospital electronic health records (e.g. get patient data)
    3. In rails, build out methods to fetch a sample of patients from the FHIR server (https://hapi.fhir.org/resource?serverId=home_r4&pretty=false&_summary=&resource=Patient ). There should be documentation on how to properly construct the query. Please fetch all available patients that are born after 1950.
    4. Once you are able to fetch the patient data, examine the JSON returned to get familiar with the schema.
    5. Create views (Html) that will show basic statistics from the data you retrieved including:
        5.1. Number of patients
        5.2. Average age
        5.3. Number of pediatric patients (less than 18)
    6. Create a simple visualization to graph the age of patients as a histogram.  You can use any library you are familiar with (e.g. google charts).
    7. Create a simple table to lists out all patients in your dataset (columns can be name, birthdate, and any other relevant information you feel appropriate). Include a simple filter for this table to show only pediatric cases (patients less than age 18). Note: some considerations for you to make include what happens if the dataset is over 100,000+ patients – how do you manage load performance.

## Performance considerations
Currently, the application doesn't support a huge dataset (e.g. over 100,000+ patients). In order to 
support high data requests, background jobs should be implemented. [Sidekiq](https://github.com/mperham/sidekiq) is a great
tool to manage background jobs. Moreover, to improve performance, some variables should be [cached](https://guides.rubyonrails.org/caching_with_rails.html).
[Memcached](https://guides.rubyonrails.org/caching_with_rails.html#activesupport-cache-memcachestore), [Dalli](https://github.com/petergoldstein/dalli) 
and Redis should be integrated in order to cache patients variables and show them to the user while the background jobs 
will be gathering more patient data. With that, it is possible to update the statistics in real-time using AJAX.  

## Instructions to build/compile/run
You can access the application at https://fhirapiseamlessmd.herokuapp.com, but if you want to build and run it:
1. `git clone https://github.com/brunomrlima/fhir_api_seamlessmd.git`
2. `bundle install`
3. `rails db:create db:migrate`
4. `rails s`
5. Access http://localhost:3000 

## How to install Requirements
### MacOS
#### Homebrew
Homebrew installs the stuff you need that Apple (or your Linux system) didn’t.
Homebrew installs packages to their own directory and then symlinks their files into /usr/local.
Homebrew complements macOS (or your Linux system). Install your RubyGems with gem and their dependencies with brew.

Paste that in a macOS Terminal or Linux shell prompt.
```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

#### Rbenv

1. Install rbenv.

    ~~~ sh
    $ brew install rbenv
    ~~~

   Note that this also installs `ruby-build`, so you'll be ready to
   install other Ruby versions out of the box.

2. Set up rbenv in your shell.

    ~~~ sh
    $ rbenv init
    ~~~

   Follow the printed instructions to [set up rbenv shell integration](#how-rbenv-hooks-into-your-shell).

3. Close your Terminal window and open a new one so your changes take
   effect.

4. Verify that rbenv is properly set up using this
   [rbenv-doctor](https://github.com/rbenv/rbenv-installer/blob/master/bin/rbenv-doctor) script:

    ~~~ sh
    $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
    Checking for `rbenv' in PATH: /usr/local/bin/rbenv
    Checking for rbenv shims in PATH: OK
    Checking `rbenv install' support: /usr/local/bin/rbenv-install (ruby-build 20170523)
    Counting installed Ruby versions: none
      There aren't any Ruby versions installed under `~/.rbenv/versions'.
      You can install Ruby versions like so: rbenv install 2.2.4
    Checking RubyGems settings: OK
    Auditing installed plugins: OK
    ~~~

5. That's it! Installing rbenv includes ruby-build, so now you're ready to
   [install some other Ruby versions](#installing-ruby-versions) using
   `rbenv install`.
   
6. ##### Installing and configuring Ruby 2.7.0
   ```bash
   $ rbenv install 2.7.0
   ```
   Make Ruby 2.7.0 the default in your system:
   ```bash
   $ rbenv global 2.7.0
   ```
   Check all versions installed and confirm that Ruby 2.7.0 is the one selected.
   ```bash
   $ rbenv versions
   ``` 
   

   
* ##### Upgrading with Homebrew (Not required)
   
   To upgrade to the latest rbenv and update ruby-build with newly released
   Ruby versions, upgrade the Homebrew packages:
   
   ~~~ sh
   $ brew upgrade rbenv ruby-build
   ~~~


#### Install PostgreSQL app

Access the website [PostgreSQL app](https://postgresapp.com/) and download PostgreSQL app that is compatible with PostgreSQL 12.

To setup the database:

```bash
$ rails db:setup
```

This will generate two local databases (one for development and another one for testing).
PS: This action runs Runs db:create, db:schema:load and db:seed.
