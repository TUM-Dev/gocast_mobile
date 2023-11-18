# The mobile client for [gocast](https://github.com/TUM-Dev/gocast)

This mobile client for [gocast](https://github.com/TUM-Dev/gocast) is currently under development by the [iPraktikum Winter 23/24](https://ase.cit.tum.de/teaching/23w/ipraktikum/) on behalf of the TUM Developers. In order not to influence the grading of the students, we would ask you to refrain from code contributions until **March 2023**. Until then, we look forward to your contributions in our other repositories. Thank you for your understanding! 


## Features

- [x] Authentication using internal account
- [x] Authentication using TUM SSO
- [ ] Overview of own and publicly available Lectures
- [ ] Ability to watch lectures (single, multi - view and split - view)
- [ ] Bookmark lectures
- [ ] Automatic notifications if lecture starts
- [ ] Ability to search for lectures
- [ ] Ability to download lectures in a data privacy conform manner (non - exportable and remotely deletable)
- [ ] Ability to answer quizzes and feedback requests

## Config

1. Make sure to have a local [`gocast`](https://github.com/tum-dev/gocast) instance listening on port `8081`. 

2. Run `$ flutter run` to start the app. 

3. Run `dart fix --apply && dart format ./lib` before commiting new changes.

## Development

| Dependency                               | Usage                                    | Where to download it                         |
|------------------------------------------|------------------------------------------|----------------------------------------------|
| `Flutter` (includes the `Dart` compiler) | SDK to develop this app                  | https://docs.flutter.dev/get-started/install |
| A local instance of [`gocast`](https://github.com/tum-dev/gocast) | API to fetch user data & streams                  | https://github.com/TUM-Dev/gocast#readme |