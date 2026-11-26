# flutter-review-example

The test app of
[flutter-review-agent](https://github.com/marwaMejri/flutter-review-agent):
a small Flutter app that lists the releases of an app, and 45 open pull
requests reviewed by the agent. The expected remarks of each pull request
were written before the agent reviewed it.

- **#2 to #22:** features of the app. Each one targets one rule of the
  agent, or none.
- **#23 to #31:** challenges: several problems in one pull request, traps, a
  prompt injection in the code, a large file, a generated file, moved code,
  the project conventions, a README only.
- **#32 to #46:** cases at the edge of a rule, and a package of a pub
  workspace.

The pull requests stay open: they are reviewed again for each version of the
agent. The expected remarks and the result of each run are in
[`eval/real_pull_requests.md`](https://github.com/marwaMejri/flutter-review-agent/blob/main/eval/real_pull_requests.md)
of the agent.

The app has one folder for each feature, with the data, domain and
presentation layers, and uses `provider`, `go_router` and `material_ui`: see
[`CONVENTIONS.md`](../CONVENTIONS.md), which the agent also checks. The review
runs in [`.github/workflows/ci.yml`](workflows/ci.yml); the provider and the
model are repository variables, and the key is a secret.
