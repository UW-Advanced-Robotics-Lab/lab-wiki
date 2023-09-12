<toc>

# Table of Contents
[*Last generated: Tue 12 Sep 2023 16:31:48 EDT*]
- [**1. Instructions on Wiki Page**](#1-Instructions-on-Wiki-Page)
  - [1.0 Clone the wiki locally:](#10-Clone-the-wiki-locally)
  - [1.1 Modifying Contents:](#11-Modifying-Contents)
    - [1.1.1 If Modifing Contents:](#111-If-Modifing-Contents)
    - [1.1.2* If Creating a New Page:](#112-If-Creating-a-New-Page)
  - [1.2 Run Automated Book-keeping:](#12-Run-Automated-Book-keeping)
    - [1.2.1 If Modified Contents:](#121-If-Modified-Contents)
    - [1.2.2* If Created a New Page:](#122-If-Created-a-New-Page)
  - [1.3 Push your Wiki:](#13-Push-your-Wiki)
- [**2. Tips**](#2-Tips)
  - [2.1 Recommended Editors:](#21-Recommended-Editors)

---
</toc>
<a href="https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki" target="_blank"><img src="https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/blob/main/docs/resources/button.png" alt="Click Here to Access Lab Wiki Page and Guide"/></a>



# 1. Instructions on Wiki Page

> :warning: Please Clone the Wiki Repository to maintain the changes and merge the changes. The Repository Actions will overwrite anything edited directly on Wiki, upon the next push onto the main branch.

## 1.0 Clone the wiki locally:

1. [> Setup GitHub <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Workstation-Setup#133-ssh-keys--github)

2. Clone the Wiki: 

   ```bash
   $ git clone git@github.com:UW-Advanced-Robotics-Lab/lab-wiki.git
   ```

## 1.1 Modifying Contents:

1. Create a new branch:

   ```bash
   $ git checkout -b user/jack/edit-2023-09-08
   ```

2. Modify files inside `./docs`, and add resources to `./docs/resources`

   > :notebook: The `Action` tab will automatically synchronize the contents inside `./docs` to the lab wiki page
   >
   > :warning: Do not directly modify the **wiki** tab online, as they will get overridden by a new push from the lab-wiki repository. (`lab-wiki` --> `lab-wiki.wiki` synchronization is one-way only. )

### 1.1.1 If Modifing Contents:

- Do not change anything manually between the html tags:

  - ```html
    <!-- Header -->
    <!-- Body -->
    
    <!-- Here is where you can touch! -->
    
    <!-- Footer -->
    ```

- Make proper indexing of the header with explicit numbering:

  ```md
  # 1. Section
  # 1.2 Subsection
  ...
  ```

### 1.1.2* If Creating a New Page:

- Make sure your file name styles:

  ```
  [Group]:[File-name].md
  
  == [Group]:
  * Lab:            Lab specific contents
  * Logbook:        Logbook, does not need to be up-to-date instruction
  * Tips:           General Tips, need to be concise, and up-to-date
  * Waterloo-Steel: Hardware specific and setup related, MUST up-to-date, and concise, summarized and step-by-step instructions
  ```

  - This file name style will be used by the header generator to generate the Table-of-Contents (TOC) in the next step

## 1.2 Run Automated Book-keeping:

### 1.2.1 If Modified Contents:

1. To generate Table of Contents:

   1. Invoke markdown auto-gen scripts:

      ```bash
      # This file only targets `${scritp-loc}/../docs/*.md` files
      # - to update toc for modified files before committing:
      $ source scripts/markdown-toc.sh && markdown_toc_directory -git
      # - update all toc for all files regardless of files changes:
      $ source scripts/markdown-toc.sh && markdown_toc_directory docs
      ```
      
   1. ⭐ If `uwarl-robot_configs` is installed, use:

      ```bash
      $ md_toc_dir git  	# update only modified readme
      # OR:
      $ md_toc_dir docs 	# update all readme in docs
      # OR:
      $ md_toc docs/README.md	# update a specific readme file
      ```

### 1.2.2* If Created a New Page:

1. To generate a Sidebar Header for Github Wiki:

   - if-not* install via https://github.com/adriantanasa/github-wiki-sidebar
   - (advanced*) config via: `docs/options.json` 

   ```bash
   $ cd docs
   $ github-wiki-sidebar --silent
   ```

## 1.3 Push your Wiki:

1. Push your changes:

   ```bash
   $ git commit .
   $ git push -u origin user/jack/edit-2023-09-08
   ```

2. Merge your changes to main --> Publish to Wiki

   - Create a PR like: [PR example](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/pull/3)
     - Tag Reviewers [jaku-jaku] or anyone you want to review
     - Once review is done, you may hit the button **[MERGE]**

   - Once, it is merged, the script inside GitHub Actions will publish your changes modified inside "./docs" to the wiki page.
   - check your published status: [Status-of-publish](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/actions) 
   - View your published wiki: [wiki page](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki)

3. You should also update your local main:

   ```bash
   $ git checkout main
   $ git pull
   # [OPTIONAL] delete old branch:
   $ git branch -D user/jack/edit-2023-09-08
   # [OPTIONAL] rebase to latest:
   $ git checkout user/jack/edit-2023-09-08
   $ git rebase main
   $ git push 
   ```




# 2. Tips

## 2.1 Recommended Editors:

1. [VS Code with Extension](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one): free, all OS, as long as you have VSCode
2. [Typora](https://typora.io), great but no longer free
3. [Obsidian](https://obsidian.md), should be free




<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>