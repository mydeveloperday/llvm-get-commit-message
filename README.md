
* get_comment_message.sh

I'm not sure if this is well known, but it helped me so I thought I'd share it with you.

When committing to gitmonorepo, (with git llvm push) you need to have committed to your local repo first and so you need to have crafted your commit message from your the Phabricator revision. (e.g. D12345)

Phabricator has the ability to give you the commit message it would have used, even if you do not use arc to perform the commit/land

This small script (attached) uses arc, jq and (but it can be relatively easily changed to use curl instead of arc)

You need to provide your own conduit api token in place of <replace_with_phabricator_api_token> 

You can get one of these from you Profile->Setting->Conduit API Tokens in the top right hand corner of Phabricator https://reviews.llvm.org

----------------------------  
get_commit_message.sh
----------------------------
echo '{ "revision_id": '${1:1}' }' | arc call-conduit --conduit-uri https://reviews.llvm.org/ --conduit-token <replace_with_phabricator_api_token> differential.getcommitmessage | jq -rnf ".response"
/g' -
---------------------------- 

This simply pulls the commit message as json and then replaces \n with newlines (there are probably better ways of doing this, I'm not a jq expert!) 

Given an example review https://reviews.llvm.org/D58250

simply run

get_commit_message.sh D58250 

And you get all the relevant information (see below) about the message,revision,reviewers, subsribers etc.. returned  (as if arc was going to commit it)

(names changed to protect the innocent)
---------------------------------------------------------------------------------
[AIX][CMake] Changes for building on AIX with XL and GCC

Summary: In support of IBM's efforts to produce a viable C and C++ LLVM compiler for AIX (ref: RFC at http://lists.llvm.org/pipermail/llvm-dev/2019-February/130175.html), this patch adds customizations to the CMake files in order to properly invoke the host toolchain for the build on AIX. Additional changes to enable a successful build will follow.

Reviewers: john doe

Reviewed By: jane doe,walter smith

Subscribers: jane doe, llvm-commits

Tags: #llvm

Differential Revision: https://reviews.llvm.org/D58250
---------------------------------------------------------------------------------  

You can then copy and paste this into your commit message.


