#!/bin/bash
echo gem install
gem install --no-document rubocop-select rubocop rubocop-checkstyle_formatter \
            checkstyle_filter-git saddler saddler-reporter-github \
            github_status_notifier

github-status-notifier notify --state pending --context saddler/rubocop

echo git diff
git diff -z --name-only origin/master

echo rubocop-select
git diff -z --name-only origin/master \
 | xargs -0 rubocop-select

echo rubocop
git diff -z --name-only origin/master \
 | xargs -0 rubocop-select \
 | xargs rubocop \
     --require rubocop/formatter/checkstyle_formatter \
     --format RuboCop::Formatter::CheckstyleFormatter

echo checkstyle_filter-git
git diff -z --name-only origin/master \
 | xargs -0 rubocop-select \
 | xargs rubocop \
     --require rubocop/formatter/checkstyle_formatter \
     --format RuboCop::Formatter::CheckstyleFormatter \
 | checkstyle_filter-git diff origin/master

echo saddler
git diff -z --name-only origin/master \
 | xargs -0 rubocop-select \
 | xargs rubocop \
     --require rubocop/formatter/checkstyle_formatter \
     --format RuboCop::Formatter::CheckstyleFormatter \
 | checkstyle_filter-git diff origin/master \
 | saddler report \
    --require saddler/reporter/github \
    --reporter Saddler::Reporter::Github::PullRequestComment

github-status-notifier notify --exit-status $? --context saddler/rubocop

exit 0
