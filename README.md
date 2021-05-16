
  ThemoviedbTest
  Flutter Bloc
  ---------------------------------------

  A small application where the architecture based on components is implemented as recommended  [verygood.ventures  page][developer].

  [developer]: https://verygood.ventures/


  This application shows a list of trendings movies.


  ![screenshot1](https://github.com/Santi92/Flutter_TheMovie/blob/main/images/app_movies.png)



  We also have the detail of the movies where we can see their title, release date and movie imagen.




  ### Architecture
  This architecture has 4 layers, State management is in charge of cleaning and managing the data that will be shown to the UI, The UI layer is considered a raw layer since it should not contain logic, it should only be based on visual components, the layer Lower is the data layer, it is advisable to use the repository pattern, this pattern complies with it as a source of truth since it always has different data providers such as local DataSource and the other can be by the ApiService as in this case, finally implement the middle layer, interactor layer that is responsible for the business logic, the idea that this layer only contains pure dart.

  ![Archtiture](https://github.com/Santi92/Flutter_TheMovie/blob/main/images/archtiture.png)


  ### Coverage
  ![screenshot1](https://github.com/Santi92/Flutter_TheMovie/blob/main/images/coverage.png)

Currently the project has a coverage of 80%, to carry this out, abstractions and implementations were developed to be able to mock all the dependencies and to be able to simulate the different behaviors in the app.




    

