---
title: "Decision Making with Case Esac"
date: 2023-09-12T21:42:25Z
draft: false
---

In bash scripting, decision-making plays a crucial role in controlling the flow of your script. The `case esac` statement provides an efficient and concise way to perform multiple conditional checks in bash scripting. In this tutorial, we'll explore how to use the `case esac` statement for decision making, along with some practical examples.
<!--more-->

## Syntax

The `case...esac` is similar to `if..elif..else` statements with multiple conditions.

```bash
case $variable in
    pattern1)
        # code block executed if variable matches pattern1
        ;;
    pattern2)
        # code block executed if variable matches pattern2
        ;;
    patternN)
        # code block executed if variable matches patternN
        ;;
    *)
        # code block executed if none of the patterns match
        ;;
esac
```

### Grade assigner Example

In this example, like programming language, we are asked for marks and when we provide marks, we get back grades.

```bash
#!/bin/bash

echo "Enter your marks out of 100."
read marks

case $marks in
    [0-6]*)
        echo "Marks below 60%. You've got C."
        ;;
    7[0-9]*)
        echo "Marks between 70% and 79%. You've got B."
        ;;
    8[0-9]*|9[0-9]*|100)
        echo "Marks above or equal to 80%. You've got A!!!"
        ;;
    *)
        echo "Invalid input entered."
        ;;
esac
```

**Output:**

```output{ .show-prompt lineNos=false }
bash script.sh
Enter your marks out of 100.
78
Marks between 70% and 79%. You've got B
```

### Example of working with system services

In below example, we prompt the user to select a system service by entering a number. Based on the selected number, we will execute corresponding commands.

```bash
#!/bin/bash

echo "Please select a system service: "
echo "1. Apache"
echo "2. MySQL"
echo "3. Nginx"
 
read -p "Enter your choice to start: " choice
 
case $choice in
    1)
        echo "Starting Apache..."
        # code for starting Apache
        ;;
    2)
        echo "Starting MySQL..."
        # code for starting MySQL
        ;;
    3)
        echo "Starting Nginx..."
         # code for starting Nginx 
esac
```
      
This script prompts the user to select a system service by entering a number. Based on the user's input, it executes corresponding commands to start the chosen service.
