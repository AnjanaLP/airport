# Airport Control

This is a program to control the flow of planes at an airport. The planes can land and take off provided that the weather is sunny. Occasionally it may be stormy, in which case no planes can land or take off.

A test driven approach has been taken in the creation of a set of classes to satisfy all the below user stories. A random number generator has been used to set the weather (it is normally sunny but on occasion it may be stormy), which has been implemented in the Weather class and injected into the Airport class as a dependency, thereby ensuring each class maintains a single responsibility. Additionally, should sometime in the future one wants to, for example, use a weather forecasting API instead, it would be simple to do so whilst adhering to the open/closed principle. The tests have used a stub to override random weather to ensure consistent test behaviour. Unit tests include test doubles to effectively isolate the single class being tested and feature tests check correct integration behaviour between the classes.

The code defends against edge cases such as inconsistent states of the system ensuring that planes can only take off from airports they are in; planes that are already flying cannot takes off and/or be in an airport; planes that are landed cannot land again and must be in an airport, etc.

## User Stories

As an air traffic controller, so planes can land safely at my airport, I would like to instruct a plane to land.

As an air traffic controller, so planes can take off safely from my airport, I would like to instruct a plane to take off.

As an air traffic controller, so that I can avoid collisions, I want to prevent airplanes landing when my airport is full.

As an air traffic controller, so that I can avoid accidents, I want to prevent airplanes landing or taking off when the weather is stormy.

As an air traffic controller, so that I can ensure safe take off procedures, I want planes only to take off from the airport they are at.

As the system designer, so that the software can be used for many different airports, I would like a default airport capacity that can be overridden as appropriate.

As an air traffic controller, so the system is consistent and correctly reports plane status and location, I want to ensure a flying plane cannot take off and cannot be in an airport.

As an air traffic controller, so the system is consistent and correctly reports plane status and location, I want to ensure a plane that is not flying cannot land and must be in an airport.

As an air traffic controller, so the system is consistent and correctly reports plane status and location, I want to ensure a plane that has taken off from an airport is no longer in that airport.

## How to setup

Clone the repo to your local machine, change into the directory and install the needed gems:
```
$ bundle install
```

To run the test suite:
```
$ rspec
```
