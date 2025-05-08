---
title: "Proxy Pattern"
date: 2024-04-05T23:23:11-04:00
draft: false
---

Proxy design pattern is a structural design pattern which has a middle class also known as proxy. This class can be used to control access to an object or provide additional functionality, security, or other benefits before or after delegating calls to the real object. This tutorial explains Proxy pattern with Java examples.

<!--more-->

## What is Proxy Pattern?

When we have a third party system performing some important task and we want to perform additional activity before or after using that class, we can add a proxy class which will have an instance of the third party object. This proxy will also have the same interface as the original class so that we can use this instead of using the original object. We can perform additional tasks such as logging, authentication, caching, etc. using this proxy instance. Proxy object simply takes the client request, performs additional task and delegates the request to the service class which will actually perform the task.


## How to implement Proxy Design?

The components of the proxy pattern include following.
- Service: This is the service object which actually performs some task.
- Proxy: This is an object with same interface as the service object and can replace service object.

1. Create a service interface. If there is no service interface, create one so that our proxy can replace the service object. If the service object is third party library, we cannot extract an interface from this class. We can use inheritance and make proxy a subclass of the third party service object.
2. Create a proxy class. This class should have an instance of the service object. 
3. Implement the proxy methods for the specific purpose of the proxy.

## Practical Code Examples

### Security proxy Example

1. Create a common interface for service and proxy object. Here, `File` defines the common interface for both objects.

```java
public interface File {
    void download(String user);
    void modify(String user, String content);
}
```

2. Create service class which implements the service interface. This is the actual object performing the task.

```java
public class OriginalFile implements File {
    private String fileName;

    public OriginalFile(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void download(String user) {
        System.out.println("Downloading file for user " + user);
    }

    @Override
    public void modify(String user, String content) {
        System.out.println("Modifying file for user " + user);
    }
}
```

3. Create a proxy object. This will have the same interface as the original service class above. This also includes an instance of service object using composition relationship. Here, `SecurityProxy` class includes an instance of the `OriginalFile` object.

```java
public class SecurityProxy implements File {
    private File file;

    public SecurityProxy(String fileName) {
        this.file = new OriginalFile(fileName);
    }

    @Override
    public void download(String user) {
        if (AuthenticationService.authenticateDownload(user)) {
            file.download(user);
        } else {
            System.out.println("You are not authorized to download this file");
        }
    }

    @Override
    public void modify(String user, String content) {
        if (AuthenticationService.authenticateModify(user)) {
            file.modify(user, content);
        } else {
            System.out.println("You are not authorized to modify this file");
        }
    }
}
```

From client side, we can easily replace the `OriginalFile` instance with a `SecurityProxy` which delegates the actual task of modification or download of a file to `OriginalFile` instance. However, it adds authentication of the users. Here, `SecurityProxy` acts as a security proxy controlling download and modification of the file by first authenticating the users.

```java
public class Client {
    public static void main(String[] args) {
        SecurityProxy securityProxy = new SecurityProxy("file1.txt");

        securityProxy.download("someuser");
        securityProxy.modify("admin", "some new conent");
        securityProxy.modify("anotheruser", "the latest content");
    }
}
```

### Caching Proxy

```java
public interface DataSource {
    String get(String key);
}
```

In this case, the `DataSource` defines the common interface which is used to retrieve data from the backend service.


```java
public class DataService implements DataSource{
    private String url;

    public DataService(String url) {
        this.url = url;
    }

    @Override
    public String get(String key) {
        System.out.println("Fetching data from the data service for key " + key);
        return "Value " + key;
    }
}
```

`DataService` is a third party service which implements the `DataSource` interface. With this, we can fetch data for a specific key. This service has rate limiting and that's why we do not want to hit this service everytime we need data and want a mechanism to store the data locally. If the data is not available locally, then only make remote call to the `DataService`.

```java
public class CachingDataService implements DataSource{
    private DataSource dataSource;
    private Map<String, String> cache;

    public CachingDataService(String url) {
        this.dataSource = new DataService(url);
        this.cache = new HashMap<>();
    }

    @Override
    public String get(String key) {
        if (cache.containsKey(key)) {
            System.out.println("Fetching data from the cache for key " + key);
            return cache.get(key);
        } else {
            String value = dataSource.get(key);
            cache.put(key, value);
            return value;
        }
    }
}
```

Here, `CachingDataService` implements the same interface as `DataService` but it also has a way to check data in cache. In this case, it implements cache using simple `HashMap`, bur it can be complicated system in itself. It also includes an instance of `DataService` which is used to retrieve data for a key if the data for that key does not exist in the cache.

```java
public class Main {
    public static void main(String[] args) {
        DataSource cachedDataSource = new CachingDataService("http://someurl.com");
        System.out.println(cachedDataSource.get("key1"));
        System.out.println(cachedDataSource.get("key2"));
        System.out.println(cachedDataSource.get("key1"));
    }
}
```

Client can seamlessly use `CachingDataService` to replace `DataService`. Here, `key1` didn't exist so first time we ask for that key, it will fetch data from the data service but next time, it will fetch the same data from cache.

### Advantages:
- It provides great flexibility because it implements the same interface as service object. We can easily swap the implementation. Thus making code loosely coupled.
- It follows open closed principle. You can add new proxy without modifying service object.
- Proxy can add additional layer of security to the underlying service object.
- Proxy can also be used for lazy loading and thus avoiding creation of unnecessary objects.

## Disadvantages:
- The code becomes little bit more complicated because of additional proxies which adds additional layer of abstraction.
- It may add additional delay because of additional intermediate layer.

## Summary
- Proxy pattern adds intermediate object that intercepts client requests.
- This can be used to add protection of the real service object or to add additional functionalities to existing third party service objects.
- Proxy pattern is largely used by dependency injection frameworks such as Spring and Hibernate.