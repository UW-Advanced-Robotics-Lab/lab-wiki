<a href="https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki" target="_blank"><img src="https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/blob/main/docs/resources/button.png" alt="Click Here to Access Lab Wiki Page and Guide"/></a>



# Instructions on Wiki Page

1. Modify files inside `./docs`, and add resources to `./docs/resources`

   > :notebook: The `Action` tab will automatically synchronize the contents inside `./docs` to the lab wiki page

2. To generate Table of Contents:
   
   1. Invoke markdown auto-gen scripts:

      ```bash
      # This file only targets `${scritp-loc}/../docs/*.md` files
      $ bash scripts/markdown-toc.sh
      ```
      - It will delete previous TOC block within `<toc> ... </toc>` 
      - It will then stub the latest TOC at teh head of the markdown file

3. To generate _SideBar.md for Wiki:
   
   1. Install: `$ npm install github-wiki-sidebar -g`
   
   2. Generate: `$ cd docs && github-wiki-sidebar --silent`
   
