# ComposeHTTP
ComposeHTTP is a thin and light wrapper around Foundation.URLSession and its functionality. ComposeHTTP is meant to provide a cleaner way to make URLRequests and work with the information recieved back from them.

> [!WARNING]
> ComposeHTTP is officially deprecated, and has been replaced with [Cobweb](https://github.com/Lukas-Simonson/Swift-Cobweb/tree/d36002d681e06de178bd97fcf678893b21abc063). Cobweb is a near drop-in replacement for ComposeHTTP with some lovely new features, and more to come!

## Quickstart Guide

### Making URLs

ComposeHTTP is meant to make the entire process of making network requests easy and fun! This includes the process of creating URLs. By leveraging a functional programming style, ComposeHTTP allows you to create URLs in a declarative manner.

Here is an example of how you can create a URL for `https://www.google.com/`

```swift
Network.URL.host("google.com")
```
ComposeHTTP uses https as its default schema, but you can also choose to set your schema by chaining another function, or even starting with that function.

For example if you wanted to go to `http://www.google.com`.

```swift
Network.URL.scheme(.http).host("google.com")
```
You can continue to modify the URL by chaining more functions. For example, if we want to change what path we are going to, we can chain the `.path` function.

```swift
Network.URL.host("example.com")
    .path("/sub/page")
```
I could then set the query of my URL by chaining the `.query` function.

```swift
Network.URL.host("example.com")
    .path("/sub/page")
    .query("param1=400,param2=hello")
```
#### Creating a `Network.Request` from a `Network.URL`

Once you have created your `Network.URL` you can easily convert it into a `Network.Request` by using the `.request` function. This function takes a parameter for what HTTP Method you want to use for your request. There are also some short hand functions such as `.get` that create the request for the most common HTTP Methods.

This function can throw if you haven't provided enough information to create a URL from.

```swift
try Network.URL.host("example.com")
    .path("/sub/page")
    .query("param1=400,param2=hello")
    .request(method: .get)

// OR

try Network.URL.host("example.com")
    .path("/sub/page")
    .query("param1=400,param2=hello")
    .get()
```

### Working With `Network.Request`

#### Creating a `Network.Request`
If you don't want / need to work with `Network.URL` you can still create a `Network.Request` using either a Foundation `URL` or just a `String`. There are several static functions built in to help you create requests.

Similar to how there is a `.request` function for `Network.URL` there is also a static version for `Network.Request` that lets you specify a HTTP Method and a URL to use for the request. There are also the same convenience functions for the most common HTTP methods such as `.get`.

Here is how you could create the same request we made in the last `Network.URL` example just using a `String`.

```swift
try Network.Request
    .get("https://www.example.com/sub/page?param1=400,param2=hello")
```

#### Setting Request Headers
In order to set the request headers of a `Network.Request` there are a couple of different functions you can use. Each of these different functions rely on being passed a `Network.HTTP.Header` value.

`Network.HTTP.Header` is a type used to represent an individual header in a `Network.Request`. You can create one of these headers using the `.custom` static function, or by using one of the many provided static functions for commonly used headers, such as `.authorization`.

For this example, lets set a few different headers onto the request we made in the Creating a `Network.Request` section.

```swift
try Network.Request
    .get("https://www.example.com/sub/page?param1=400,param2=hello")
    .setHeaders(.contentType(value: "application/json"), .custom("X-API-KEY", value: "myapikeyhere"))
```
#### Setting The Request Body
Setting the body of a request is as easy as all of the other things. You use the `.setBody` function of the `Network.Request`. There are 3 different versions of this function.

1. `setBody(_ jsonEncodable: Encodable, encoder: JSONEncoder = JSONEncoder())`
2. `setBody(_ str: String)`
3. `setBody(_ data: Data)`

Each of these options does the same thing, just using a different type of data.

As an example, here is a continuation of the last example, while adding a String as the body of the request.

```swift
try Network.Request
    // Changed to post as you cannot have a body on a get request.
    .post("https://www.example.com/sub/page?param1=400,param2=hello")
    .setHeaders(.contentType(value: "application/json"), .custom("X-API-KEY", value: "myapikeyhere"))
    .setBody("This is my Response Body")
```
#### Getting Data From The Request

To make send a `Network.Request` you use the `async` `.response` function. This will cause the set `URLSession` to make the actual request and it will return the information you get back in the form of a `Network.Response`

Here is how you could get the data back from the previous example.

```swift
// Added await as the call to `.response` is async
try await Network.Request
    .post("https://www.example.com/sub/page?param1=400,param2=hello")
    .setHeaders(.contentType(value: "application/json"), .custom("X-API-KEY", value: "myapikeyhere"))
    .setBody("This is my Response Body")
    .response()
```
If you only care about the body of your request, you can choose to skip the response in favor of just getting the body data back. You can do this by using one of the various `.responseBody` functions.

```swift
// Added await as the call to `.response` is async
try await Network.Request
    .post("https://www.example.com/sub/page?param1=400,param2=hello")
    .setHeaders(.contentType(value: "application/json"), .custom("X-API-KEY", value: "myapikeyhere"))
    .setBody("This is my Response Body")
    .responseBody(as: ExampleDecodable.self)
```
### Working With `Network.Response`
The only way to get an instance of a `Network.Response` is by using the `.response` function from a `Network.Request`. After this is done, there are several functions that help you handle the response you recieve.

#### Reading the Response Body
You can get the data from the responses body via the `.body` and `.bodyData` functions. These functions either convert `Decodable` types using a `JSONDecoder` or give back the `Data` object respectively.

```swift
try await Network.Request
    .post("https://www.example.com/sub/page?param1=400,param2=hello")
    .setHeaders(.contentType(value: "application/json"), .custom("X-API-KEY", value: "myapikeyhere"))
    .setBody("This is my Response Body")
    .response()
    .bodyData() // Get the Data object from the `Network.Response`
```

#### Responding to Response Status Codes
Often you need to verify the status codes of the response you get back from the network request. You can use the `.verifyStatusCode` function to throw errors based on the status code.

```swift
try await Network.Request
    .post("https://www.example.com/sub/page?param1=400,param2=hello")
    .setHeaders(.contentType(value: "application/json"), .custom("X-API-KEY", value: "myapikeyhere"))
    .setBody("This is my Response Body")
    .response()
    .verifyStatusCode(is: 200, orThrow: NetworkError.invalidResponse)
    .bodyData() // Get the Data object from the `Network.Response`
```
## See The Difference

### With Normal URLSession
```swift
func postUser(user: User, bearerToken token: String) async throws -> User {
    guard let url = URL(string: "https://example.com/user")
    else { throw ServiceError.invalidURL }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONEncoder().encode(user)
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    switch (response as? HTTPURLResponse)?.statusCode {
        case 200: break
        case 400: throw ServiceError.badRequest
        case 500: throw ServiceError.serverError
        default: throw ServiceError.unknownError
    }
    
    return try JSONDecoder().decode(User.self, from: data)
}
```
### With ComposeHTTP
```swift
func postUser(user: User, bearerToken token: String) async throws -> User {
    try await Network.Request
        .post("https://example.com/user")
        .setHeaders(.contentType(value: "application/json"), .authorization(value: "Bearer \(token)"))
        .setBody(user)
        .response()
        .verifyStatusCode(isNot: 400, orThrow: ServiceError.badRequest)
        .verifyStatusCode(isNot: 500, orThrow: ServiceError.serverError)
        .verifyStatusCode(is: 200, orThrow: ServiceError.unknownError)
        .body()
}
```

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

To add [ComposeHTTP](https://github.com/Lukas-Simonson/swift-composehttp) to your project do the following.
- Open Xcode
- Click on `File -> Add Packages`
- Use this repositories URL (https://github.com/Lukas-Simonson/Swift-ComposeHTTP.git) in the top right of the window to download the package.
- When prompted for a Version or a Branch, we suggest you use the branch: main
