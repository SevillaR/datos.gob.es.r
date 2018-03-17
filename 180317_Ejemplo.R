# SPARK -------------------------------------------------------------------

library(SPARQL)

endpoint <- "http://datos.gob.es/virtuoso/sparql"

# create query statement
q <- "select distinct ?type where {?x a ?type} LIMIT 100"
q <- "select distinct ?tipo where
{
graph <http://datos.gob.es/catalogo> {
?x a ?tipo.
}
}"

res <- SPARQL(url=endpoint, q)

# EJEMPLO -----------------------------------------------------------------

# Step 1 - Set up preliminaries and define query
# Define the data.gov endpoint
endpoint <- "http://services.data.gov/sparql"

# create query statement
query <-
  "PREFIX  dgp1187: <http: data-gov.tw.rpi.edu='' vocab='' p='' 1187=''>
SELECT ?ye ?fi ?ac
WHERE {
?s dgp1187:year ?ye .
?s dgp1187:fires ?fi .
?s dgp1187:acres ?ac .
}"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results
