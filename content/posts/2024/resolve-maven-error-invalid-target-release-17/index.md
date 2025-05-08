---
title: "Resolve Maven Error Invalid Target Release 17"
date: 2024-05-09T10:07:09-04:00
draft: false
categories: ["Java Programming"]
tags: ["Leetcode", "Medium"]
languages: ["Java"]
---

## Introduction

Recently, I was upgrading my Java version in one of the repositories and I came across this issue. I was using maven for building this project. In my `pom.xml` file, I simply declared target as Java version `17` and I came across this error.

This is what it looks like in my `pom.xml` file.

```xml
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
</properties>
```

## Problem

After changing this to 17, when I run my test cases using `mvn clean test`, I get below error.

```{lineNos=false}
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.11.0:compile
 (default-compile) on project hello-java: 
 Fatal error compiling: invalid target release: 17 -> [Help 1]
```

It says `invalid target release: 17` for some reason. When I look at my Java version, I see that I have Java 17.

```bash{.show-prompt lineNos=false}
java -version
openjdk version "17.0.10" 2024-01-16
OpenJDK Runtime Environment Temurin-17.0.10+7 (build 17.0.10+7)
OpenJDK 64-Bit Server VM Temurin-17.0.10+7 (build 17.0.10+7, mixed mode)
```

When I look at `mvn -version`, it's using Java 11. So, when you execute `mvn` commands, it's using Java version 11 to compile the code.

```bash{.show-prompt lineNos=false}
mvn -version
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/homebrew/Cellar/maven/3.9.6/libexec
Java version: 11.0.14, vendor: Eclipse Adoptium, runtime: /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home
Default locale: en_US, platform encoding: UTF-8
OS name: "mac os x", version: "14.4.1", arch: "x86_64", family: "mac"
```

This is because I had `JAVA_HOME` variable pointing to Java version 11.

```bash{.show-prompt lineNos=false }
echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home
```

## Solution

Now, in my case, I use multiple java versions for different projects. If you're just using single Java version, you can change the `JAVA_HOME` environment variable in your `~/.bashrc` or `~/.zshrc` file depending on which shell you're using. Just add a line like this pointing to Java home directory.

```bash
export JAVA_HOME="/Library/Java/JavaVirtualMachinestemurin-17.0.10/Contents/Home"
```

Restart your shell session or just run, `source ~/.bashrc` or `source ~/.zshrc` to apply new changes to take effect.

### Setup using libexec

You could use something like this your rc file and it will set up correct Java home location depending on the version if it's able to find that version in your system.

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

### Set up using alias

In my case, I have set up Java using alias, because even for same version, I may have different Java providers. so, I prefer to keep the exact location where my java home is located. In my `~/.bashrc` file, it looks like this.

```bash
alias j8="export JAVA_HOME=\"/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home\""
alias j11="export JAVA_HOME=\"/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home\""
alias j17="export JAVA_HOME=\"/Library/Java/JavaVirtualMachines/temurin-17.0.10/Contents/Home\""
```

This allows me to change java version using commands like `j17` or `j11` etc.

After setting up correct java version to `17`, you can verify your java version and what specific Java version maven is using.

```bash{.show-prompt lineNos=false}
echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/temurin-17.0.10/Contents/Home
```

```bash{ .show-prompt lineNos=false}
mvn -version
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/homebrew/Cellar/maven/3.9.6/libexec
Java version: 17.0.10, vendor: Eclipse Adoptium, runtime: /Library/Java/JavaVirtualMachines/temurin-17.0.10/Contents/Home
Default locale: en_US, platform encoding: UTF-8
OS name: "mac os x", version: "14.4.1", arch: "aarch64", family: "mac"
```