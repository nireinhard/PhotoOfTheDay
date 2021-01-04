# PhotoOfTheDay

Small example project to better get to know SwiftUI with Combine. 
Every day NASA publishes their picture of the day ([Pictore of the day](https://apod.nasa.gov/apod/astropix.html)), which is accessible by a REST API. This little app fetches this information and displays it to the user.

# Learnings

  - Combine basics
  - Using combine to query REST API's
  - SwiftUI (+Combine) Data Flow (@Published, @Binding, @ObservedObject)
  - Building UI/UX with SwiftUI

### Installation

In order for the app to run you first have to get [NASA API Keys](https://api.nasa.gov/).
Create an Keys.plist file under the ${Project Root}/NASA/ folder.
Add a new key value pair for your secret.

api_secret: XXX-XXX-XXX-XXX



License
----

MIT
