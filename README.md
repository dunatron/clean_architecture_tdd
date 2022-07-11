# clean_architecture_tdd

We are building a number trivia based app.
It has all the core components we will be working with on a day to day basis.

- getting data from api/local cache
- error handling
- input validation
- state management(Bloc)

We will be seperating out our app into layers of concern.  
Clean arcitecture works with any state management pattern and we can actually trade bloc out for any state management solution

The below image shows the Clean Architecure in its abstract

![alt text](https://github.com/dunatron/clean_architecture_tdd/blob/main/docs/images/CleanArchitecture.jpg?raw=true)

We then need to adapt this clean architecture concept to flutter using
Reso Coders Flutter Clean Architecure Proposal

![alt text](https://github.com/dunatron/clean_architecture_tdd/blob/main/docs/images/reso_coder_clean_architecture.svg?raw=true)

The core thing is that the app/ every app feature will be divided into three parts

- presentation
- domain
- data

The number trivia app only has one feature as it is a simple app.

Just having features is not enough for example if you have something that can be used across muliple features.
Lets say we have a settings feature and over there we want to do input validation. Well input validation isnt really feature specific and can be shared across muliple feautres. that functionality will go into the `core` folder

Bloc/ChangeNotifier/StatefulWidget essentially dont do much by themeselves. they will delegate all of there work down to the uses cases and domain layer etc.

Blocs will have very lean logic, at most they will have some input validation and then they get delegated down to the uses cases or domain layer

Domain layer should be independent of every other layer

`usecases:` the functions to get our stuff

`domain:` layer will hold most of the business logic

## Dependency Inversion

we create an absract class repository which will define a contract for what the repository must do.  
E.g in our app we have a repo which must provide us with trivia nd concrete number trivia, which goes into the domain layer

## Data Layer

Will define how the data is gotten, some ecternal things

- datasources
- models
- repositories

Note: the repository in data will hold the implementations, where the repository in the domain layer will hold the abstract classes which are the contract that must be fulfilled

## Starting Point.

After creating our folder structure and knowing what our UI/App looks like, we should start with `entities` according to uncle bobs clean architecture
