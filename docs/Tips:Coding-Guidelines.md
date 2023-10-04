<toc>

# Table of Contents
[*Last generated: Wed  4 Oct 2023 14:07:37 EDT*]
- [**0. GitHub**](#0-GitHub)
- [**1. Git**](#1-Git)
  - [1.1 Intro. to Git](#11-Intro-to-Git)
    - [1.1.a Git Commands [[1]]( https://ourcodingclub.github.io/tutorials/git-for-labs/)](#11a-Git-Commands-1)
  - [1.2 Our Branching Strategy](#12-Our-Branching-Strategy)
  - [1.3 Readme Markdown](#13-Readme-Markdown)
- [**2. Documentation**](#2-Documentation)
  - [2.1 Doxygen Style:](#21-Doxygen-Style)
    - [2.1.a Python](#21a-Python)
  - [2.2 General Usage of Commenting Tags:](#22-General-Usage-of-Commenting-Tags)
  - [2.3 General File Commenting:](#23-General-File-Commenting)
- [**3. Python**](#3-Python)
  - [3.1 Common Header Format](#31-Common-Header-Format)
  - [3.2 Docstring](#32-Docstring)

---
</toc>



# 0. GitHub

- We would like to use GitHub for progress tracking and project collaboration
  - **Projects**: An interactive board to track and manage relevant issues and tasks
  - **Milestones**: A deadline you may set to ensure projects complete on-time
  - **Labels**: Tags that you may categorize the issue or task
  - **Issues**: You may create sub tasks by using checkbox in the comment editor, and you may also link with other issues
  - **Pull Requests (PR)**: Merge and integrate your work to stable branches, and you may link PR with particular issues
- A general guideline of coding may refer to the [Google-Style-Guide](https://google.github.io/styleguide)

# 1. Git

## 1.1 Intro. to Git 

- A really good basic tutorial about why and how to use Git for Lab:  [[1]]( https://ourcodingclub.github.io/tutorials/git-for-labs/)

### 1.1.a Git Commands [[1]]( https://ourcodingclub.github.io/tutorials/git-for-labs/)

| Command                                  | Is `hub` required? | Origin          | Destination     | Description                                                  |
| ---------------------------------------- | ------------------ | --------------- | --------------- | ------------------------------------------------------------ |
| `git fork`                               | Y                  | Other Github    | Personal Github | Creates github repo in your personal account from a previously cloned github repo. |
| `git clone git@github.com:user/repo.git` | N                  | Personal Github | Local           | Creates a local copy of a github repo called "repo" owned by the user "user". This can be copied from github.com. |
| `git add README.md`                      | N                  | Working Dir     | Staging Area    | Add "README.md" to staging area.                             |
| `git commit -m "Message"`                | N                  | Staging Area    | Local           | Commits changes to files to the local repo with the commit message "Message". |
| `git commit -a -m "Message"`             | N                  | Working Dir     | Local           | adds and commits all file changes to the local repo with the commit message "Message". |
| `git pull`                               | N                  | Personal Github | Local           | Retrieve any changes from a github repo.                     |
| `git push`                               | N                  | Local           | Personal Github | Sends commited file changes to github repo.                  |
| `git create`                             | Y                  | Local           | Personal Github | Create a github repo with the same name as the local repo.   |
| `git merge`                              | N                  | NA              | NA              | Merge any changes in the named branch with the current branch. |
| `git checkout -b patch1`                 | N                  | NA              | NA              | Create a branch called "patch1" from the current branch and switch to it. |

## 1.2 Our Branching Strategy

- Branch Name Guideline:
  - NOTE: the naming guidelines are defined by Jack here based on experiences, and may differ from some of the common naming standard. We may discuss for further modification and additions of commonly used naming strategies.
  - Branching Structure:
    - `{base-flag}/{base-name}/{sub-action}`
  - Recommended Namespace:
    - `demo/{}` : a branch for a specific demo topic
      - Ex:
        -  `demo/aurco-demo/refactoring` OR `demo/aurco-demo-refactoring` : A refactoring branch for aurco-demo, and will be merged to `demo/aurco-demo` parent branch once completed
    -  `usr/{name}/{opt:user-specific-action}:` : an on-going developing branch for a joint projects
      - Ex:
        -  `usr/jack/make-wiki-better`: A user-based task branch to alert that the owner and whom is in charge
    - `checkpoint/{date}/{opt:variance-name}` : a major check-point that you would like to keep and visit frequently
      - Ex:
        - `checkpoint/oct-7-2021/ARCHIVE-for-publication` :  a checkpoint on October  7th, 2021 (for publication milstone)
    - `main`: default main (stable) branch
  - Recommended Name Tags `../{TAG}-`:
    -  `ARCHIVE`: meaning the branch is an archive of some kind
    - `FIX` : fixes 
    - `FEATURE` : a particular new feature 

## 1.3 Readme Markdown

- Advanced formatting: https://gist.github.com/apaskulin/1ad686e42c7165cb9c22f9fe1e389558



# 2. Documentation

## 2.1 Doxygen Style:

- We recommend to use [[2] doxygen](https://www.doxygen.nl/manual/docblocks.html) style documenting 

### 2.1.a Python

```python
"""@package docstring
Documentation for this module.
 
More details.
"""
 
def func():
    """Documentation for a function.
 
    More details.
    """
    pass
 
class PyClass:
    """Documentation for a class.
 
    More details.
    """
   
    def __init__(self):
        """The constructor."""
        self._memVar = 0;
   
  def my_method(x, y):
      """
      my_method description

      @type x: int
      @param x: An integer

      @type y: int|string
      @param y: An integer or string

      @rtype: string
      @return: Returns a sentence with your variables in it
      """

      return "Hello World! %s, %s" % (x,y)
     
```

## 2.2 General Usage of Commenting Tags:

- `TODO:` todo tracking (many plugin support to-do tracking)
- `NOTE`: note about something
- `WARNING`: warning note about something that you might want yourself or someone to be aware of
- `FEATURE`: some sort of feature you would like to highlight
- `BUG`: some sort of bug you would like to investigate or debug shortly, make sure there is no such tag before merging !

## 2.3 General File Commenting:

- ASCII ART Generator: https://patorjk.com/software/taag

# 3. Python

## 3.1 Common Header Format 

- Refer to [[3]](https://stackoverflow.com/questions/1523427/what-is-the-common-header-format-of-python-files)
  1. First Line: `#!/usr/bin/env python` 
  2. Docstring with file description with a brief summary of the file
  3. Import python modules
     1. built-in python
     2. third-party
     3. path modifications and own modules
  4. authorship
  5. Rest of the code

## 3.2 Docstring

- Comments! But there are couple different styles [[4]](https://gist.github.com/nipunsadvilkar/fec9d2a40f9c83ea7fd97be59261c400) , and we prefer either epytext or reST.

- Note: no need for docstring typing hint, if we are using typing-hint from typing after *Python3.6*

- use 'Epytext' style [[5]](http://epydoc.sourceforge.net/epytext.html):

  - ```python
    def x_intercept(m, b):
        """
        Return the x intercept of the line M{y=m*x+b}.  The X{x intercept}
        of a line is the point at which it crosses the x axis (M{y=0}).
    
        This function can be used in conjuction with L{z_transform} to
        find an arbitrary function's zeros.
    
        @type  m: number
        @param m: The slope of the line.
        @type  b: number
        @param b: The y intercept of the line.  The X{y intercept} of a
                  line is the point at which it crosses the y axis (M{x=0}).
        @rtype:   number
        @return:  the x intercept of the line M{y=m*x+b}.
        """
        return -b/m
    ```

- Use 'reST' style:

  - commonly default in JetBrains PyCharm

  - ```python
    def x_intercept(m, b):
      """
      This is a reST style.
    
      :param param1: this is a first param
      :param param2: this is a second param
      :returns: this is a description of what is returned
      :raises keyError: raises an exception
      """
      return -b/m
    ```

  








<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>