# batronic

stephan.com 2014

_In fullfilment of a coding test_

### Overview
For this scenario, we have been asked to write an application that will be used to provide information about baseball player statistics.

### Usage

Uses sqlite, so there's no need to db:create. Use DATABASE_ENV instead of RAILS_ENV

Expects Ruby 2

* git clone https://github.com/stephancom/batronic
* cd batronic
* bundle install
* rake db:migrate
* rake db:migrate DATABASE_ENV=test
* rspec
* rake seeds:all
* ruby batronic.rb

### Assumptions
All requests currently are based on data in the hitting file. Future requests of the system will require data from a pitching file as well. Consider this in the design.

**note** I am assuming that all computed values should be limited to three significant digits after the decimal point, per baseball convention.

### Requirements

When the application is run, use the provided data and calculate the following results and write them to STDOUT.

1. Most improved batting average( hits / at-bats) from 2009 to 2010. Only include players with at least 200 at-bats.
2. Slugging percentage for all players on the Oakland A's (teamID = OAK) in 2007. 
3. Who was the AL and NL triple crown winner for 2011 and 2012. If no one won the crown, output "(No winner)"

### Formulae:

> **Batting average** = hits / at-bats

> **Slugging percentage** = ((Hits – doubles – triples – home runs) + (2 * doubles) + (3 * triples) + (4 * home runs)) / at-bats

> **Triple crown winner** – The player that had the highest batting average AND the most home runs AND the most RBI in their league. It's unusual for someone to win this, but there was a winner in 2012. “Officially” the batting title (highest league batting average) is based on a minimum of 502 plate appearances. The provided dataset does not include plate appearances. It also does not include walks so plate appearances cannot be calculated. Instead, use a constraint of a minimum of 400 at-bats to determine those eligible for the league batting title.

### Data
All the necessary data is available in the two csv files attached:

* **Batting-07-12.csv**

  Contains all the batting statistics from 2007-2012. 

  *Column header key*

    * AB – at-bats
    * H – hits
    * 2B – doubles
    * 3B – triples
    * HR – home runs 
    * RBI – runs batted in

* **Master-small.csv**

  Contains the demographic data for all baseball players in history through 2012.

### References

http://exposinggotchas.blogspot.com/2011/02/activerecord-migrations-without-rails.html
http://blog.flatironschool.com/post/58164473975/connecting-ruby-active-record-without-rails