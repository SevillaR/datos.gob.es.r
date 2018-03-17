library(httr)
library(jsonlite)
url <- "http://datos.gob.es/apidata/catalog/dataset"

# Make the GET request:
request_result_a <- GET(url, user_agent("vsslledo@gmail.com This is a test"))


if(http_error(request_result_a)){
  warning("The request failed")
} else {
  message(http_type(request_result_a))
  request_result <- content(request_result_a, as = "parsed")
  # return(request_result)
}

df <- fromJSON(content(request_result_a, as = "text"))
df$keyword

df <- df$result

df <- df$items
