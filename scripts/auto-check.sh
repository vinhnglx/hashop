#!/bin/bash
set -v
if [ -n "${TRAVIS_PULL_REQUEST}" ] && [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then

  echo gem install
  gem install --no-document rubocop-select rubocop rubocop-checkstyle_formatter \
              checkstyle_filter-git saddler saddler-reporter-github \
              github_status_notifier

  github-status-notifier notify --state pending --context saddler/rubocop

  echo git diff
  git diff -z --name-only origin/develop

  echo rubocop-select
  git diff -z --name-only origin/develop \
   | xargs -0 rubocop-select

  echo rubocop
  git diff -z --name-only origin/develop \
   | xargs -0 rubocop-select \
   | xargs rubocop \
       --require rubocop/formatter/checkstyle_formatter \
       --format RuboCop::Formatter::CheckstyleFormatter

  echo checkstyle_filter-git
  git diff -z --name-only origin/develop \
   | xargs -0 rubocop-select \
   | xargs rubocop \
       --require rubocop/formatter/checkstyle_formatter \
       --format RuboCop::Formatter::CheckstyleFormatter \
   | checkstyle_filter-git diff origin/develop

  echo Rails Best Practices
  brakeman -o brakeman.json
  cat brakeman.json \
    | brakeman_translate_checkstyle_format translate \
    | checkstyle_filter-git diff origin/develop \
    | saddler report \
      --require saddler/reporter/github \
      --reporter Saddler::Reporter::Github::PullRequestComment

  echo saddler
  git diff -z --name-only origin/develop \
   | xargs -0 rubocop-select \
   | xargs rubocop \
       --require rubocop/formatter/checkstyle_formatter \
       --format RuboCop::Formatter::CheckstyleFormatter \
   | checkstyle_filter-git diff origin/develop \
   | saddler report \
      --require saddler/reporter/github \
      --reporter Saddler::Reporter::Github::PullRequestComment

  github-status-notifier notify --exit-status $? --context saddler/rubocop
fi

exit 0
