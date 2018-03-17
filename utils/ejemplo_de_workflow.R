# Se pueden consultar los grafos disponibles con esta consulta:
library(SPARQL)
endpoint <- "http://datos.gob.es/virtuoso/sparql"

q <- "select distinct ?uri where { graph ?uri { ?s a ?t } }"

res <- SPARQL(url=endpoint, q)
str(res)
res$results

# Si queremos obtener a qué grafo pertenece la información, se puede especificar
#de la siguiente manera donde la variable ?g vamos a ver en que grafo se encuentra cada ?x.

q <- "select distinct ?g ?type where { graph ?g { ?x a ?type. } } limit 100"
res <- SPARQL(url=endpoint, q)
res$results

#Podemos obtener los resultados de un solo de la siguiente manera:

q <- "select distinct ?type where {?x a ?type} LIMIT 100"
res <- SPARQL(url=endpoint, q)
res$results

#Podemos obtener los resultados de un solo de la siguiente manera:

q <- "select distinct ?type where { graph <http://datos.gob.es/catalogo> { ?x a ?type. } } limit 100"
res <- SPARQL(url=endpoint, q)
res$results

#Ahora solo veremos las ?x que se encuentren en el grafo especificado

#ejemplo:

#Primero especificamos el grafo del Catálogo:

q <- "select distinct ?tipo where
{
  graph <http://datos.gob.es/catalogo> {
    ?x a ?tipo.
  }
}"
res <- SPARQL(url=endpoint, q)
res$results

#Ahora usaremos los dos grafos a la vez gracias a VALUES

q <- "select distinct ?tipo where
{
  graph ?grafo {
    ?x a ?tipo.
  }
  VALUES ?grafo { <http://datos.gob.es/catalogo> <http://datos.gob.es/nti> }
}"
res <- SPARQL(url=endpoint, q)
head(res$results)

#Ahora que ya conocemos los tipos, vamos a pedir todos los conjuntos de datos, que se corresponden con esta URI: http://www.w3.org/ns/dcat#Dataset

q <- "select distinct ?dataset where
{
  ?dataset a <http://www.w3.org/ns/dcat#Dataset>
}"
res <- SPARQL(url=endpoint, q)
head(t(res$results))

#El resultado es una lista de URLs de todos los datasets.

#Queremos obtener más información de los conjuntos de datos, pero sólo sabemos sus URIs, vamos a preguntar por todas sus propiedades:

q <- "select distinct ?propiedad where
{
  ?dataset a <http://www.w3.org/ns/dcat#Dataset> . ?dataset ?propiedad ?valor .
}"
res <- SPARQL(url=endpoint, q)
t(res$results)

#Vamos a utilizar la propiedad http://purl.org/dc/terms/publisher para obtener todos los organismos que publican datos.

q <- "select distinct ?x where
{
  ?x a <http://www.w3.org/ns/dcat#Dataset> .
  ?x <http://purl.org/dc/terms/publisher> ?x
}"

res <- SPARQL(url=endpoint, q)
t(res$results)

#Con las URIs no sabemos el nombre de los organismos, vamos a preguntar por las propiedades de estas URIs

q <- "select distinct ?propiedad where
{
  ?x a <http://www.w3.org/ns/dcat#Dataset> .
  ?x <http://purl.org/dc/terms/publisher> ?publicador.
  ?publicador ?propiedad ?valor.
}"
res <- SPARQL(url=endpoint, q)
t(res$results)

#Vamos a pedir la URI y la propiedad http://www.w3.org/2004/02/skos/core#prefLabel

q <- "select distinct ?publicador ?label where
{
  ?x a <http://www.w3.org/ns/dcat#Dataset> .
  ?x <http://purl.org/dc/terms/publisher>
    ?publicador. ?publicador <http://www.w3.org/2004/02/skos/core#prefLabel> ?label.
}"
res <- SPARQL(url=endpoint, q)
head((res$results))

#Obtener los nombres de los diez organismos que más conjuntos de datos tienen publicados y visualizar el número de éstos

#Para realizar esta consulta vamos a tener que agrupar resultados, ordenarlos y limitar
#el total a 10.

q <- "select distinct ?label count(?x) as ?num {
  ?x a <http://www.w3.org/ns/dcat#Dataset> .
  ?x <http://purl.org/dc/terms/publisher> ?publicador.
  ?publicador <http://www.w3.org/2004/02/skos/core#prefLabel> ?label.
}
group by (?label)
order by desc(?num)
limit 10
"
res <- SPARQL(url=endpoint, q)
res$results



