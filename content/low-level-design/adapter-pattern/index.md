---
title: "Adapter Pattern"
date: 2024-03-24T11:28:58-04:00
draft: false
---

Adapter design pattern is a structural design pattern which is used to connect new code with legacy code without changing the contracts created earlier.

<!--more-->

## What is Adapter Pattern?

Imagine that you've a data integration application which collects data from various systems and integrates into single database. You can also take a scenario where you have an existing application which uses data in one format but now want to integrate with another format data which is available through third party. In this case, the existing code was using an interface to operate with `User` data. However, the new system does not provide the data in the same format, then how do you integrate this data into single database?

The solution is to create an adapter which translates data in the format provided by the third party into the format that our system is expecting. We cannot change the code by third party provider so we have to always add it in our code. We could easily create a function to integrate with new format, however, that would be less maintainable because it will break the single-responsibility principle. It is better to create a new class with this functionality.

This design pattern is used when client wants to communicate with existing application interface. This is usually useful for integrating with legacy systems. This is client centric design pattern. The main parts of this pattern include below:

- **Target class** is the class that the client expects the object to implement.
- **Adaptee Class** is the existing class with incompatible interface.
- **Adapter class** is the class that implements target interface and converts the calls to the method of the adaptee class.

## How to implement Adapter Pattern?

There are two ways to implement adapter pattern. (1) using object Adapter and (2) using class adapter

### 1. Object Adapter: 
In this case, the adapter class holds and instance of the adaptee class and delegates the calls to its methods. This is more flexible as it does not depend on inheritance relationship and can be used generally. 


Below is an example of object adapter pattern.

Let's say we have existing users which we can retrieve using `ExistingUserRepository`. Below is my `User` interface to model all users in my application.

```java
public interface User {
    int getId();
    String getFirstName();
    String getLastName();
    String getEmail();
}
```

We also have `ExistingUser` which implements this `User` interface. For brevity, I have excluded all unnecessary code like setters, `hashCode()` and `equals()` methods and additional business logic methods.

```java
public class ExistingUser implements User {
    private int id;
    private String firstName;
    private String lastName;
    private String email;

    public ExistingUser(int id, String firstName, String lastName, String email) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
```

Now, let's assume we have `ExistingUserRepository` with method `getAllUsers()` which returns all existing users. For the demo, I have written them in a simple `List<User>` but in reality, this data might come from backend database.

```java
public class ExistingUserRepository {

    public final List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        User user1 = new ExistingUser(1, "John", "Doe", "john.doe@gmail.com");
        User user2 = new ExistingUser(2, "Jane", "Doe", "jane.doe@hotmail.com");
        User user3 = new ExistingUser(3, "Alice", "Smith", "andrew@yahoo.com");
        users.addAll(List.of(user1, user2, user3));
        return users;
    }
}
```

The `DataClient` can simply retrieve all users using this repository and life is good. 

```java
public class DataClient {
    private final ExistingUserRepository exitingUserRepository;
    private final NewAcquisitionUserRepository newAcquisitionUserRepository;
    private final ThirdPartyUserRepository thirdPartyUserRepository;

    public DataClient(ExistingUserRepository exitingUserRepository) {
        this.exitingUserRepository = exitingUserRepository;
    }

    public List<User> getAllUsers() {
        List<User> users = exitingUserRepository.getAllUsers();

        return users;
    }
}
```

Now, let's say we get users from another third party API, however the problem is that they provide the users we acquired in their own format. Their data model for `User` do not have the same interface as what we are using. As you can notice from below class that this model does not include `firstName` or `lastName`, but they have user's name in single `name` field. Similarly, `email` is stored in `emailAddress` field. So, it does not directly implement `User` interface.

```java
public class UserFromThirdParty {
    private int id;
    private String name;
    private String emailAddress;

    public UserFromThirdParty(int id, String name, String emailAddress) {
        this.id = id;
        this.name = name;
        this.emailAddress = emailAddress;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    @Override
    public String toString() {
        return "UserThirdParty{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", emailAddress='" + emailAddress + '\'' +
                '}';
    }
}
```

Now, for retrieving these users, we have defined `ThirdPartyUserRepository` like below. Again for brevity, I have excluded unnecessary code and represented this in very simple format.

```java
public class ThirdPartyUserRepository {
    public List<UserFromThirdParty> getAllUsers() {
        UserFromThirdParty user1 = new UserFromThirdParty(1, "Rocky Balboa" , "rocky.rocks@gmail.com");
        UserFromThirdParty user2 = new UserFromThirdParty(2, "John Rambo", "rambo@example.com");
        List<UserFromThirdParty> users = List.of(user1, user2);
        return users;
    }
}
```

Now, if we directly try to add these users to our `List<User>`, it will not compile because `User` and `UserFromThirdParty` do not have same interface. This is where we will have to define an adapter which will convert `UserFromThirdParty` into `User`.

```java
public class ThirdPartyUserAdapter implements User {
    private final UserFromThirdParty userFromThirdParty;

    public ThirdPartyUserAdapter(UserFromThirdParty userFromThirdParty) {
        this.userFromThirdParty = userFromThirdParty;
    }

    @Override
    public int getId() {
        return userFromThirdParty.getId();
    }

    @Override
    public String getFirstName() {
        return userFromThirdParty.getName().split(" ")[0];
    }

    @Override
    public String getLastName() {
        return userFromThirdParty.getName().split(" ")[1];
    }

    @Override
    public String getEmail() {
        return userFromThirdParty.getEmailAddress();
    }

    @Override
    public String toString() {
        return "ThirdPartyUserAdapter{" +
                "userFromThirdParty=" + userFromThirdParty +
                '}';
    }
}
```

With this adapter in place, we can simply convert the `UserFromThirdParty` into `User` and our `DataClient` can easily combine these new users with the existing users.

```java
public class DataClient {
    private final ExistingUserRepository exitingUserRepository;
    private final ThirdPartyUserRepository thirdPartyUserRepository;

    public DataClient(ExistingUserRepository exitingUserRepository, ThirdPartyUserRepository thirdPartyUserRepository) {
        this.exitingUserRepository = exitingUserRepository;
        this.thirdPartyUserRepository = thirdPartyUserRepository;
    }

    public List<User> getAllUsers() {
        List<User> users = exitingUserRepository.getAllUsers();

        // to get users from third party, we need ThirdParty to ExistingUser adapter
        List<UserFromThirdParty> thirdPartyUsers = thirdPartyUserRepository.getAllUsers();
//        users.add(thirdPartyUsers.get(0)); // This does not work, we need to convert UserFromThirdParty to User
        List<User> usersFromThirdParty = thirdPartyUsers.stream()
                .map(ThirdPartyUserAdapter::new)
                .collect(Collectors.toList());
        users.addAll(usersFromThirdParty);

        return users;
    }
}
```

If we want to add any other kind of users, we will simply have to define Adapter class for the new source system and convert them into `User` model. We will not need to modify the client code. When using adapter with target class, the client calls adapter class methods.

### 2. Class Adapter: 
In this the adapter class inherits from the adaptee class and implements the target interface. This is useful when there is inheritance relationship between two objects.

For example, let's assume we have an existing music system which can play all modern file formats like mp4. It has method which can handle playing audio from those file formats. We have an interface `MusicPlayer` which defines the contract.

```java
public interface MusicPlayer {
    void playMusic(String musicType, String fileName);
}
```

We have concrete implementation of this interface which defines this method.

```java
public class Mp4MusicPlayer implements MusicPlayer {
    @Override
    public void playMusic(String musicType, String fileName) {
        if (musicType.equalsIgnoreCase("mp4")) {
            System.out.println("Playing mp4 file. Name: " + fileName);
        } else {
            throw new UnsupportedOperationException("Unsupported music type: " + musicType);
        }
    }
}
```

Our music system gets popular and we want to now support legacy music as well. We had a vendor providing a legacy music capability with their own interface. They have a class `LegacyMusicPlayer` which can handle this operation for us.

```java
public class LegacyPlayer {
    public void playVlcMusic(String fileName) {
        System.out.println("Playing vlc file. Name: " + fileName);
    }
}
```

In this case, we know `LegacyPlayer` is a kind of `MusicPlayer` even though it has a different interface than our modern music player. In this case, we have to write adapter but because we are naturally in this inheritance relationship, we can define adapter which returns `MusicPlayer` but extends `LegacyPlayer` which means we can use existing capability of the `LegacyPlayer` to play VLC music. Here, we can use class adapter.

```java
public class LegacyMusicAdapter extends LegacyPlayer implements MusicPlayer {

    @Override
    public void playMusic(String musicType, String fileName) {
        if (musicType.equalsIgnoreCase("vlc")) {
            playVlcMusic(fileName);
        } else {
            throw new UnsupportedOperationException("Unsupported music type: " + musicType);
        }
    }
}
```

With this in place, our `AudioClient` can play both types of music.

```java
public class AudioClient {
    private MusicPlayer musicPlayer;

    public AudioClient(MusicPlayer musicPlayer) {
        this.musicPlayer = musicPlayer;
    }

    public void playMusic(String musicType, String fileName) {
        musicPlayer.playMusic(musicType, fileName);
    }

    public void play() {
        MusicPlayer mp4MusicPlayer = new Mp4MusicPlayer();
        MusicPlayer legacyMusicAdapter = new LegacyMusicAdapter();

        AudioClient audioClient = new AudioClient(mp4MusicPlayer);
        audioClient.playMusic("mp4", "file1.mp4");

        audioClient = new AudioClient(legacyMusicAdapter);
        audioClient.playMusic("vlc", "file2.vlc");
    }
}
```

### Advantages:

- It increases usability by allowing you to use existing clases which may be incompatible.
- Provides a way to integrate two systems which have different interfaces. This promotes code reusability.
- It makes code more readable by keeping adaption code in separate classes keeping code clean and maintainable.

### Disadvantages:
- This requires a brand new adapter class for each system we want to integrate with resulting in more number of classes.
- Having this extra layer of abstraction for adapter can introduce little overhead as we need new instance of adapter for every class we want to integrate.

## Summary

- Adapter pattern provides a simple solution to common problem.
- This is easy to implement, we simply have to add a new Adapter class which handles the conversion from one interface to another.