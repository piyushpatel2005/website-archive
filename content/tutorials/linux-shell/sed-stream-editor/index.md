---
title: "Sed Stream Editor"
date: 2023-09-12T21:49:44Z
draft: false
---

The 'sed' stream editor is a powerful tool for manipulating textual data. Short for "stream editor", sed, allows you to perform search and replace operations, text transformations, and other modifications on files and streams. In this lesson, we will explore various usages of 'sed' with practical examples.

<!--more-->
## Basics of `sed`

The basic syntax for using 'sed' is as below.

```bash
sed options <expression> file
```

- The `options` provides various options for modifying sed's behavior.
- The `<expression>` specifies the action or command to be executed by sed.
- The `file` parameter represents the file on which sed will operate. If not specified, sed takes input from standard input (stdin).

## Examples:

### Search and Replace
    - Replace a single occurrence on each line

    ```bash{ lineNos=false }
    sed 's/string_to_replace/replacement_string/' filename.txt
    ```
     
    - Replace all occurrences on each line. Here, we use `g` option at the end.

    ```bash{ lineNos=false }
    sed 's/string_to_replace/replacement_string/g' filename.txt
    ```

    - Perform multiple text substitution in single `sed` command. In below code, both text 'first' and 'second' will be replaced with their uppercase versions. Two substitutions are separated by semi-colon (`;`).

    ```bash{ lineNos=false }
    sed -e 's/first/FIRST/;s/second/SECOND/' filename.txt
    ```

### Deleting Lines
    - Delete lines containing a specific pattern.

    ```bash{ lineNos=false }
    sed '/pattern/d' filename.txt
    ```
     
    - Delete empty lines from file `filename.txt`.
   
    ```bash{ lineNos=false }
    sed '/^$/d' filename.txt
    ```

    - Delete given line number from the file.

    ```bash{ lineNos=false }
    sed '3d' filename.txt # Delete third line from file
    sed '3,5d' filename.txt # Delete 3-5 lines from file
    ```

### Inserting and Appending Text
    - Add a new line with given content before matching pattern.

    ```bash{ lineNos=false }
    sed '/pattern/i\Text To Add' filename.txt
    ```

    - Append text after matching pattern.

    ```bash{ lineNos=false }
    sed '/pattern/a\New Line Text' filename.txt
    ```

    - Insert line on given line number.

    ```bash{ lineNos=false }
    sed '2i\inserted text' filename.txt # Insert new line with given content on 2nd line
    ```

    - Append line on given line number. In this case, this is appended to 2nd line, hence new line becomes the third line.

    ```bash{ lineNos=false }
    sed '2a\inserted text' filename.txt # Insert new line with given content on 2nd line
    ```

### Reordering Lines
    - Reverse the order of lines in a file.

    ```bash{ lineNos=false }
    sed '1!G;h;$!d' filename.txt
    ```

### Interactive Usage

    - Edit a file interactively with 'sed'. With this `-i` flag, the file is edited in place.

    ```bash{ lineNos=false }
    sed -i 's/string_to_replace/replacement_string/g' filename.txt
    ```
     
## Conclusion
The 'sed' stream editor is an incredibly versatile tool for manipulating text in Linux bash. It offers various features and options to perform search and replace, text transformations, deletions, insertions, and reordering of lines within files. Understanding these different usages empowers you to efficiently automate tasks involving text manipulation on the command line.