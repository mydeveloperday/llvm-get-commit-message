echo '{ "revision_id": '${1:1}' }' | arc call-conduit --conduit-uri https://reviews.llvm.org/ --conduit-token <replace_with_api_token> differential.getcommitmessage | jq -rnf ".response"
