#!/bin/bash -e

if [[ -e $1.repack.git ]]; then
        rm -rf $1.repack.git
fi

cp -r $1.git $1.repack.git


cd $1.repack.git
git checkout master


# Create tag
git for-each-ref --format="%(refname)" refs/remotes/tags/ |
while read tag; do
    if [[ ! $tag == *@* ]]; then
      GIT_COMMITTER_DATE="$(git log -1 --pretty=format:"%ad" "$tag")" \
      GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:"%ce" "$tag")" \
      GIT_COMMITTER_NAME="$(git log -1 --pretty=format:"%cn" "$tag")" \
      git tag -m "$(git for-each-ref --format="%(contents)" "$tag")" \
          ${tag#refs/remotes/tags/} "$tag"
    fi
done

# Create branch
git for-each-ref --format="%(refname)" | grep -v tags | grep -v trunk | grep -v master |
while read branch; do
    if [[ ! $branch == *@* ]]; then
      GIT_COMMITTER_DATE="$(git log -1 --pretty=format:"%ad" "$branch")" \
      GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:"%ce" "$branch")" \
      GIT_COMMITTER_NAME="$(git log -1 --pretty=format:"%cn" "$branch")" \
      git branch ${branch#refs/remotes/} "$branch"
    fi
done


# Supprime les commits inutils
# renomme les commit maven
git filter-branch --prune-empty --msg-filter "sed -e \"s/\\[maven-release-plugin\\] prepare release/\\[maven-release-plugin\\] tag/\"" --tag-name-filter cat -- --all


rm -rf .git/refs/original/

for commit in $(git rev-list --all); do
    if git log $commit -1 | grep "\\[maven-release-plugin\\] tag"; then
        git tag -f $(git log $commit -1 --format="%s"|sed -e "s/\\[maven-release-plugin\\] tag //") $commit
    fi
done



# Purge
rm -rf .git/svn
rm -rf .git/refs/remotes/
rm -rf .git/logs/refs/remotes/
rm -rf .git/refs/original/
cat  <<EOF > .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
EOF

