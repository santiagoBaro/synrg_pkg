# CHANGELOG

## 0.5.5

- reverted changes from 0.5.3

## 0.5.4

- Adds QueryList

## 0.5.3

- Refactor SynrgAuth class to improve profile handling

## 0.5.2

- Add multiQuery to Indexer

## 0.5.1

- Added Indexer delete method

## 0.5.0

- Changed SynrgClass implementation, removed equatable and final attributes. This enables the cascade save

## 0.4.12

- Adds parent to SynrgProfile constructor

## 0.4.11

- Changes SynrgClass save to default to parent.save() if not null

## 0.4.10

- Adds parent to SynrgClass

## 0.4.9

- Adds async await to modal actions

## 0.4.8

- Adds Equatable to Modal

## 0.4.7

- Fix profile local cache storage
- Changed BlocProvider to have buildWhen as parameter

## 0.4.6

- Fix Crashlytics for web
- Fix setUserId logic

## 0.4.5

- Adds try catch to Crashlytics

## 0.4.4

- Adds equatable to class

## 0.4.2

- Adds equatable to state

## 0.4.2

- Comments copyWith method in SynrgState

## 0.4.1

- Fixed missing export

## 0.4.0

- Changed theme structure

## 0.3.10

- Fixed auth init profile complete emit Landing State

## 0.3.9

- Fixed typos
- Improved set user id
- Adds Auth init

## 0.3.7 - 0.3.8

- Fix save() id check

## 0.3.6

- Fix SynrgAuth signin and register flow

## 0.3.5

- Fix SynrgAuth bloc

## 0.3.4

- Improved Profile

## 0.3.3

- Make id a named parameter

## 0.3.2

- Adds try catch to login

## 0.3.1

- Adds state emit in login/ register success

## 0.3.0

- Fixes exports

## 0.2.7

- Adds visual element export

## 0.2.6

- Change to Modal Provider interactivity implementation

## 0.2.5

- Fix casting bug in SynrgBlocProvider

## 0.2.4

- Adds commonly used dependencies

## 0.2.3

- Adds toMap method to Location

## 0.2.2

- Improved readme

## 0.2.1

- Code refactor

## 0.2.0

- Added wrapper for Firebase functionalities

## 0.1.3

- Added copyWith method to SynrgClass
- Wrapped auth constructor if index is null

## 0.1.2

- Fixes SynrgAuth profileIndex constructor

## 0.1.1

- Added indexer and class exports

## 0.1.0+1

- Initial release
