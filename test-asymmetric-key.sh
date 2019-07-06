curl_opts='-s -o /dev/null -w %{http_code}'

echo "correct token => request ok"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9000/echo \
        -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE2MDk0MDg4MDB9.IF-ZiPygyokZdgG2Bu5S47tlDEixerZ0ebpK0Jvv9pB4jJNIoyX3f1QgxyugT-LWko1JKpsdWncdzxN4QVizJloH5bHrjEALEwv-2VFZm87lEx8QXxwr3FRJM5vHdvSACGFEsnOLEtBni-3uyUri4Vw-imxiBoqgHMaIFaAR9rWlmOrQXSfD4SJ1UmpHdT9vO45UpccwN4TabdlBt230sidrLkhTN31oe5wQ7zNWTXPVq9Z0GaCZUe1WcgcBocT23mQAvtiPzxh9IaJZlRfaqgjnciY1UP65gEkp8NwXqEz3FwHmiRLw4dy2SGGi9BuESgxxaeUaPVq3zYTXPG4q5vdaiUnlkFIZktngbNeuBRI26a11juSDMc0o5gur1t6HWQIXfmFTz7UDtTh5Atbl59p_GM-QvobZQuML-ZUILrMJq44Fy5roqwiTHL3dUdQZNMnPD5gzA_hX7QchegAcAyVxjm9KefuNsRlgyipHNoTlniIA9aKtepyw5nTM4Cg4Xh7BaRJCC0msR_xzdiOeYTP17guS_Wq24f__m-pdCsg2TdcNAA3svVmnvSFvSBkzWxEfvU7it4n9HyWLJQMR7sJAU0ByJs-PJpcNNuNU398O3FFt12Fzd2pxjdYDW2gWCuW5SlQYR2fJr12a7PgzzXTq-XJE81Za6kp56hbILhM' \
)
[[ "$status_code" == "200" ]] || echo "Unexpected response"

echo "no token => request ok"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9000/echo \
)
[[ "$status_code" == "200" ]] || echo "Unexpected response"

echo "incorrect token => 401"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9000/echo \
        -H 'Authorization: Bearer toto' \
)
[[ "$status_code" == "401" ]] || echo "Unexpected response"  

echo "statics not checked => request ok"
status_code=$(\
    curl $curl_opts -X GET http://localhost:9000 \
    -H 'Authorization: Bearer toto' \
)
[[ "$status_code" == "200" ]] || echo "Unexpected response"  