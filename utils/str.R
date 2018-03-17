#workflow to create a package to access datos.gob.es

#create package structure

library(usethis)
create_package(path = getwd())

use_code_of_conduct()
#added a MIT licence manually.

#add travis et al.
#use_travis() #not done yet.
#use_coverage()

#add tests
#use_testthat() #not done yet

