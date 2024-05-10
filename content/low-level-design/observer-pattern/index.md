---
title: "Observer Pattern"
date: 2024-04-28T19:12:02-04:00
draft: false
---

Observer is a behavioral pattern allows to implement subscription style mechanism to notify the objects which are subscribed to receive notification for events on the object. This tutorial explains observer pattern with Java examples.

<!--more-->

## What is Observer Pattern?

Imagine you're planning to visit Wonderland. However, during winter season, it closes and you're waiting for it to reopen. Instead of calling them every week to know if they are open today or this week, you can provide them your email address and ask them to notify you when they're open for the season. In this analogy, the wonderland is called the subject or publisher and you are like an observer or subscriber looking to receive notification.

When some important event occurs in the *subject* (for example, wonderland), it automatically lets all the interested users (*observers*) know about the event without them having to check about it periodically. This way everyone who were interested to know about these events will be informed promptly. They react to the event if it's of interest to them. The object whose state is being observed also sends out notifications, so it's also called *publisher*. The interested objects are which wants to track publisher's state are also called *subscribers* because they are subscribed to receive state change notifications.

In practice, this pattern is relatively simple. It simply has a collection of subscriber objects with several methods to subscribe and unsubscribe from observing the subject. Whenever the state or important event happens in subject, it simply goes over its subscribers and calls the notify method on those objects. Each of these subscribers implement same interface and publisher communicates with them using this interface. This interface must have a method to notify subscribers. This way publisher is not directly coupled with subscriber classes. This pattern is used in MVC architecture where the view is driven by events. In standard Java library, we have `java.util.EventListener` as well as `java.util.Observer` interface which is deprecated since Java 9.

## How to implement Observer Pattern?

The observer pattern consists of following actors.
- Publisher or Subject: This is responsible for sending events of interest to other objects. The publisher or subject contains methods that allows new subscribers to join and current subscribers to leave the group. It sends events when the publisher state changes or some particular event occurs.
- Subscriber or Observer: This declares a notification method like `notify()` or `update()`. This method may take several parameter depending on the context of the event we want to send along with the update. Each subscriber implements this interface in order to perform some action based on the event. This allows publisher to decouple from actual concrete subscriber classes.
- Client: The client creates subject and observer objects in their code and registers the observer to observe subject changes.

1. In your code, you first identify the dependency where we are looking for an event from the subject. They are usually independent from each other. So, we can separate this into observer and observable interfaces. The `Observable` or `Subject` interface should have method to add new subscriber objects and to remove existing subscribers. In this case, you're writing a `PublishingAgency`. So, we can extract the `Publisher` interface as below.

```java
public interface MagazinePublisher {
    void subscribe(Subscriber subscriber);
    void unsubscribe(Subscriber subscriber);
    void publishMagazine(String article);
}
```

You have concrete implementation for this `MagazinePublisher` as shown below. Notice that, this implements these methods and includes reference to all subscribers in the concrete `MagazinePublisher` objects.

```java
public class PublishingAgency implements MagazinePublisher {
    private List<Subscriber> subscribers;
    private String latestArticle;

    public PublishingAgency() {
        this.subscribers = new ArrayList<>();
    }

    @Override
    public void subscribe(Subscriber subscriber) {
        subscribers.add(subscriber);
    }

    @Override
    public void unsubscribe(Subscriber subscriber) {
        subscribers.remove(subscriber);
    }

    @Override
    public void publishMagazine(String article) {
        this.latestArticle = article;
        notifySubscribers();
    }

    private void notifySubscribers() {
        subscribers.forEach(subscriber -> subscriber.update(latestArticle));
    }
}
```

2. Declare a `Observer` interface. At least, it should have `notify` or `update` method to update observers about changes in the subject.

```java
public interface Subscriber {
    void update(String article);
}
```

3. Implement all required types of subscribers. A publisher can have more than one subscribers. In this case, we have `EmailSubscriber` who prefers to receive email notification whenever a new article is published by the agency.

```java
public class EmailSubscriber implements Subscriber {
    private String email;

    public EmailSubscriber(String email) {
        this.email = email;
    }

    @Override
    public void update(String article) {
        System.out.println("Sending email about new article " + article + " to " + email);
    }
}
```

You also have `WhatsAppSubscriber` who prefers to get notification on WhatsApp application on their cell phones.

```java
public class WhatsAppSubscriber implements Subscriber {
    private String phoneNumber;

    public WhatsAppSubscriber(String phone) {
        this.phoneNumber = phone;
    }

    @Override
    public void update(String article) {
        System.out.println("New Article alert: \n\n" + article);
    }
}
```

4. The `Client` creates instances of publisher and subscribers and attaches subscribers to the publisher instance. In this case, we have two subscribers initially so they both get notification of new article. After a while `WhatsAppSubscriber` unsubscribes from future notification and thus it does not receive the next notification for new article.

```java
public class ClientMain {
    public static void main(String[] args) {
        PublishingAgency agency = new PublishingAgency();

        EmailSubscriber email = new EmailSubscriber("abc@example.com");
        WhatsAppSubscriber whatsApp = new WhatsAppSubscriber("+1(416)-444-5555");

        agency.subscribe(email);
        agency.subscribe(whatsApp);

        agency.publishMagazine("Mission Jupiter");

        System.out.println("=====================================");
        System.out.println("Unsubscribing Whats App");
        agency.unsubscribe(whatsApp);

        agency.publishMagazine("Tesla on Titanic");
    }
}
```

### Advantages:
- It decouples publisher and subscriber objects from tightly coupling to concrete classes.
- It uses resources efficiently as subscribers do not need constantly poll for updates. They get notified if they are subscribed to updates from publisher.
- You can easily add new subscriber without modifying other code. They can be easily attached or detached from future updates. This allows for flexible configuration.
- You can easily add new types of Subscribers without modifying Publisher code. It follows Open/Closed principle.

### Disadvantages:
- This can add complexity if there are lots of publishers and subscribers.
- If there are too many observers, notifying all of them may introduce performance overheads.
- The order in which observers get notified is usually not guaranteed. It may need additional design changes to have ordering guarantee.
- If subscribers are not properly de-registered, they can cause memory leaks. So, it needs careful handling.

## Summary
- Observer pattern is very powerful for decoupling communication between two objects. Both publisher and subscribers do not need to know about each other as long as they follow defined interface.
- Observer could be used with Mediator pattern.