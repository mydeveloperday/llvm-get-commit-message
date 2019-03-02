
# method using arc
# echo '{ "revision_id": '${1:1}' }' | arc call-conduit --conduit-uri https://reviews.llvm.org/ --conduit-token <replace_with_api_token> differential.getcommitmessage | jq -r ".response" -

# method using curl
curl -s -S https://reviews.llvm.org/api/differential.getcommitmessage -d api.token=<replace_with_api_token> -d revision_id=${1:1} | jq -r ".result" -
