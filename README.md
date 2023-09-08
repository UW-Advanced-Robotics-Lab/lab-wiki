<toc>

# Table of Contents
[*Last generated: Mon 26 Dec 2022 11:03:19 EST*]
- [**Instructions on Wiki Page**](#Instructions-on-Wiki-Page)

---
</toc>
<a href="https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki" target="_blank"><img src="https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/blob/main/docs/resources/button.png" alt="Click Here to Access Lab Wiki Page and Guide"/></a>



# Instructions on Wiki Page

> :warning: Please Clone the Wiki Repository to maintain the changes and merge the changes. The Repository Actions will overwrite anything edited directly on Wiki, upon the next push onto the main branch.

1. [> Setup GitHub <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Workstation-Setup#133-ssh-keys--github)

2. Clone the Wiki: 

   ```bash
   $ git clone git@github.com:UW-Advanced-Robotics-Lab/lab-wiki.git
   ```

3. Create a new branch:

   ```bash
   $ git checkout -b user/jack/edit-2023-09-08
   ```

4. Modify files inside `./docs`, and add resources to `./docs/resources`

   > :notebook: The `Action` tab will automatically synchronize the contents inside `./docs` to the lab wiki page
   >
   > :warning: Do not directly modify the **wiki** tab online, as they will get overridden by a new push from the lab-wiki repository. (`lab-wiki` --> `lab-wiki.wiki` synchronization is one-way only. )

5. To generate Table of Contents:

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
      $ md_toc_dir docs 	# update all readme in docs
      $ md_toc docs/README.md	# update a specific readme file
      ```

6. To generate Sidebar Header for Github Wiki:

   - if-not* install via https://github.com/adriantanasa/github-wiki-sidebar
   - (advanced*) config via: `docs/options.json` 

   ```bash
   $ cd docs
   $ github-wiki-sidebar --silent
   ```

7. Push your changes:

   ```bash
   $ git commit .
   $ git push -u origin user/jack/edit-2023-09-08
   ```

8. Merge your changes to main --> Publish to Wiki

   - Create a PR like: [PR example](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/pull/3)
     - Tag Reviewers [jaku-jaku] or anyone you want to review
     - Once review is done, you may hit the button **[MERGE]**

   - Once, it is merged, the script inside GitHub Actions will publish your changes modified inside "./docs" to the wiki page.
   - check your published status: [Status-of-publish](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/actions) 
   - View your published wiki: [wiki page](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki)

9. You should also update your local main:

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

   

<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>