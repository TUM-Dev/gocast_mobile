# The mobile client for [gocast](https://github.com/TUM-Dev/gocast)

This mobile client for [gocast](https://github.com/TUM-Dev/gocast) is currently under development by the [iPraktikum Winter 23/24](https://ase.cit.tum.de/teaching/23w/ipraktikum/) on behalf of the TUM Developers. In order not to influence the grading of the students, we would ask you to refrain from code contributions until **March 2023**. Until then, we look forward to your contributions in our other repositories. Thank you for your understanding! 


## Features

- [x] Authentication using internal account
- [x] Authentication using TUM SSO
- [x] Overview of own and publicly available Lectures
- [x] Ability to watch lectures (single, multi - view and split - view)
- [x] Pin lectures
- [x] Automatic notifications if course goes live starts and if new lecture VoD is uploaded 
- [x] Ability to search for lectures
- [x] Ability to download lectures in a data privacy conform manner (non - exportable and remotely deletable)
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

## Push notifications

For the push notifications, gocast_mobile uses the Firebase Cloudmessaging API. For more details and a detailed setup instruction, see [gocast FCM guide](https://gist.github.com/carlobortolan/845141e175c2f43135b3893670f99c59).
