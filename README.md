# Airport Challenge

This is a program to control the flow of planes at an airport. The planes can
land and take off provided that the weather is sunny. Occasionally it may be
stormy, in which case no planes can land or take off. A test driven approach
has been taken in the creation of a set of classes to satisfy all the below
user stories - test coverage is 100%.

A random generator has been used to set the weather (it is normally sunny but
on occasion it may be stormy), which has been implemented in the Weather class and
injected into the Airport class as a dependency, thereby ensuring each class
maintains a single responsibility. Additionally, should sometime in the future
one wants to, for example, use a weather forecasting API instead, it would be
simple to do so whilst adhering to the open/closed principle.

The tests have used a stub to override random weather to ensure consistent test
behaviour. Unit tests include test doubles to effectively isolate the single class
being tested and feature tests check correct integration behaviour between the
classes.

The code defends against edge cases such as inconsistent states of the system
ensuring that planes can only take off from airports they are in; planes that are
already flying cannot takes off and/or be in an airport; planes that are landed
cannot land again and must be in an airport, etc.

## User stores
```
As an air traffic controller
So I can get passengers to a destination
I want to instruct a plane to land at an airport

As an air traffic controller
So I can get passengers on the way to their destination
I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport

As an air traffic controller
To ensure safety
I want to prevent landing when the airport is full

As the system designer
So that the software can be used for many different airports
I would like a default airport capacity that can be overridden as appropriate

As an air traffic controller
To ensure safety
I want to prevent takeoff when weather is stormy

As an air traffic controller
To ensure safety
I want to prevent landing when weather is stormy
```

## How to setup

Clone the repo to your local machine, change into the directory and install the needed gems:
```
$ bundle install
```

To run the test suite:
```
$ rspec
```

## Technologies used
- Ruby
- Rspec
- SimpleCov


## Code example
```
$ irb
3.1.0 :001 > require './lib/airport'
 => true
3.1.0 :002 > airport = Airport.new(Weather.new)
 => #<Airport:0x000000010675df58 @capacity=20, @hangar=[], @weather=#<Weather:0x000000010675dfd0>>
3.1.0 :003 > plane = Plane.new
 => #<Plane:0x00000001066777b0>
3.1.0 :004 > airport.land(plane)
<span style="color: red;">Cannot land plane: weather is stormy (RuntimeError)</span>
3.1.0 :005 > airport.land(plane)
 => [#<Plane:0x00000001066777b0 @airport=#<Airport:0x000000010675df58 @capacity=20, @hangar=[...], @weather=#<Weather:0x000000010675dfd0>>>]
3.1.0 :006 > airport.land(plane)
<span style="color: red;">Cannot land plane: plane has already landed (RuntimeError)</span>
3.1.0 :007 > airport.take_off(plane)
 => #<Plane:0x00000001066777b0 @airport=nil>
3.1.0 :008 > airport.take_off(plane)
<span style="color: red;">Plane cannot take off: plane is already flying (RuntimeError)</span>
3.1.0 :009 > small_airport = Airport.new(Weather.new, 1)
 => #<Airport:0x000000010680d8e0 @capacity=1, @hangar=[], @weather=#<Weather:0x000000010680d958>>
3.1.0 :010 > small_airport.land(plane)
 => [#<Plane:0x00000001066777b0 @airport=#<Airport:0x000000010680d8e0 @capacity=1, @hangar=[...], @weather=#<Weather:0x000000010680d958>>>]
3.1.0 :011 > another_plane = Plane.new
 => #<Plane:0x00000001066dd380>
3.1.0 :012 > small_airport.land(another_plane)
<span style="color: red;">Cannot land plane: airport is full (RuntimeError)</span>
3.1.0 :013 > airport.take_off(plane)
<span style="color: red;">Cannot take off plane: plane is at another airport (RuntimeError)</span>                                                  
3.1.0 :014 > plane.airport
 =>#<Airport:0x000000010680d8e0 @capacity=1, @hangar=[#<Plane:0x00000001066777b0 @airport=#<Airport:0x000000010680d8e0 ...>>], @weather=#<Weather:0x000000010680d958>>           
3.1.0 :017 > another_plane.airport
 => nil
3.1.0 :018 > airport.land(another_plane)
 => [#<Plane:0x00000001066dd380 @airport=#<Airport:0x000000010675df58 @capacity=20, @hangar=[...], @weather=#<Weather:0x000000010675dfd0>>>]
3.1.0 :019 > another_plane.airport
 =>
#<Airport:0x000000010675df58 @capacity=20,@hangar=[#<Plane:0x00000001066dd380 @airport=#<Airport:0x000000010675df58 ...>>], @weather=#<Weather:0x000000010675dfd0>>                   
```
