curl_opts='-s -o /dev/null -w %{http_code}'

echo "correct token => request ok"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9001/echo \
        -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE2MDk0MDg4MDB9.Ht_Z4bSED1uTEPEmlPg3BcfRPNOVHYP8Fg3UP-TJyGU' \
)
[[ "$status_code" == "200" ]] || echo "Unexpected response"

echo "no token => request ok"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9001/echo \
)
[[ "$status_code" == "200" ]] || echo "Unexpected response"

echo "incorrect token => 401"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9001/echo \
        -H 'Authorization: Bearer toto' \
)
[[ "$status_code" == "401" ]] || echo "Unexpected response"  

echo "statics not checked => request ok"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9001 \
    -H 'Authorization: Bearer toto' \
)
[[ "$status_code" == "200" ]] || echo "Unexpected response"  