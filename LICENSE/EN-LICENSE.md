<!--
Expecting
- Paid for commercial use (small fee maybe depending on the amount of employees) unless said person is actively contributing to the repository (free-of-charge)
- Do not allow keeping the source code closed
- Forks are allowed only for contribution unless upstream prevents implementation (excluding changes to the license over which the upstream has full control for obvious reasons, but allow contributions to the license) of a feature for which the fork would be allowed as standalone (This is made to direct the workflow)
  - Add method to handle projects that rewrite this in a different programming language -> Host in our organization
- Anyone can request additional rights for the use of this software (We try to make this as free as possible with the option to finance the development)
- Paid for non-contributing users?
  - Since non-contributing users are basically investment (usually with low return value) of our resources and to encourage contribution in docummentation, etc..?
-->

# RXT ZERNIT LICENSE (RXT0112-LICENSE)
Version 18061016022020, 20 January 2020

Copyright (C) 2020 [RiXotStudio](http://rixotstudio.cz)<br/>
Copyright (C) 2019 [Jacob Hrbek](mailto:kreyren@rixotstudio.cz)

Redistribution of this license is not allowed unless explicitly stated in the license itself assuming provided conditions met.

<center><h4>Preamble</h4></center>

This license is made to protect the intellectual property and direct workflow of project codenamed as **RXT0112** also known as **Zernit** publicly represented on hyperlink https://github.com/RXT0112/Zernit and understood as original repository where this license is developed based on [GPL-3 license](https://www.gnu.org/licenses/gpl-3.0.en.html) and [Free Software Foundation](https://www.fsf.org) philosophy adapted for commercial use and to avoid segmentation while providing sustainable business plan with the intention to provide open-source software for everyone.

License is designed to be community maintained where only the authorized personel further identified in this file are permitted to make changes in the original repository in which this license has been created.
These authorized personel can be also clarified in file located in `.github/CODEOWNERS` with syntax explanation on hyperlink https://help.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners to appropriate GitHub Team or personal to allow making changes in this file which has to be archived using `git` which is version-control system for tracking changes in source code further explained by it's maintainers on hyperlink https://git-scm.com/.

This file is written in markdown syntax further explained on hyperlink https://en.wikipedia.org/wiki/Markdown.

## 0. TERMINOLOGY
This section is dedicated to provide explanation of used terms in this file.

### Comments
Comments are a feature in markdown syntax that do not render the appropriate section specified by this syntax on the final version and is not meant to be a part of final version due it's usage for development of this license.

To elaborate further every comment is prefixed with `<!--` and suffixed with `-->` which can be applied through multiple lines.

Example of comments:

<!-- I'm example! :) -->

Notice that said example is not rendered in the final version.

#### FIXME comments
FIXME comments are lines in this documment prefixed with `FIXME:` which are also considered as not part of the final form of this document due to it's usage to direct development of this license.

Example of FIXME comment:

FIXME: Hello, i'm example

### Source code
Source code is a collection of text recognized by compiler that are used to perform specified action in the hardware itself.

### Repositories
Repositories are a method to provide source code for public which are in our case provided on GitHub presented under hyperlink https://www.github.com/RXT0112/Zernit as of 16.02.2020.

### Upstream
Upstream is original creator of said directory or files used on this project not to be confused with original creator who is understood to be upstrem for this project.

### Paths
Unless it is not obvious paths are representing physicall files or directories in this repository for example:

path `src/bin/main.rs` points to file located in repository use

### License Managers (or 'LM' for short)
**L**icense **M**anagers clarified in path `.github/CODEOWNERS` on original repository in this repository are authorised personnel with permission to perform changes in LICENSE files.

### Original Creator (or 'OC' for short)
Original Creator of this repository is `Jacob Hrbek <kreyren@rixotstudio.cz>`.

FIXME: Limit my power as you see appropriate, this is done to avoid unexpected abuse of the license in early development which could have kill the project. - Kreyren

OC reserves absolute right for whole repository to decide hierarchy of parties associated in this repository, change of read and write access and revoking of the license for any party with or without provided reason.

### Repository Managers
Repository Managers are defined as service with the ability to provide our project for the general public in on-line form.

### Merge Request
Also wrongly named as 'Pull Requst' by many RMs is method to submit new changes in the target repository.

#### Draft Merge Requests
Referencing https://github.blog/2019-02-14-introducing-draft-pull-requests/ for upstream (github) explanation.

In short this is merge request which is being worked on before it can be submitted for review and considered for merge.

### Forks
Forks are repository manager's features that allows anyone to make a copy of a repository in their specified profile.

## 1. CONDITIONS

### Agreenment
You are not required to accept this License, since you have not signed it. However, nothing else grants you permission to modify or distribute the Program or its derivative works. These actions are prohibited by law if you do not accept this License. Therefore, by modifying or distributing the provided content on original repository (or any work based on the Program), you indicate your acceptance of this License to do so, and all its terms and conditions for copying, distributing or modifying the Program or works based on it.

### Contributions
Everyone is allowed to fork this repository as long as the source code stays public with the intention to provide a contribution to the original repository.

Creating standalone forks alike creating standalone fork with the intention to provide unique features that are not developed with the intention to contribute the changes in original repository are not allowed and OC reserves an explicit permission to revoke license of those who violate this condition to the extent permitted by the law with the intention to avoid segmentation.
- If the difference between original repository and standalone fork is a feature which is not beneficial to the original repository decided by OC then the standalone fork is allowed for the period of which this still meets this requirement.

Contributions of new features are expected to be submitted in a form of new merge request set as draft until reviw is requested by switching the contribution from draft to open.

Contributor has the right to specify his own license assuming following methods used:
- License specified as comment in the header (or at the top) of the file which will apply only for specified file

This clarification has to follow this syntax:
```
Created by Jon Doe <jon@doe.wow> using LICENSE (hyperlink://on.theLicense.wow) in 2020
```

- `LICENSE` or `LICENSE.md` file created in the root of directory which will be applied for the whole directory.

All affiliated parties that changed content provided in original repository are required to place following signature in their commit messages to prove that they agree with terms provided in said license and the terms in following versions.

```
Signed-off-by: Jon Doe <jondoe@example.foo>
```

### Methods used to maintain this license
This license is based on rolling release development which means that version is made by using following syntax HHMMSSDDMMYY which represents the day on which the license has been updated where the most recent version always replaces the previous version.

Example of syntax used for versioning:

**18061016022020** meaning **16th February of the year 2020 at 18 hours, 6 minutes and 10 seconds**

## 2. Warranty

This program is provided without any warranty unless required by law in which case the party which requires said implementation of law in this license is required to inform the project for said laws to be adapted in this license so that the the program can be used legally in their area.

Warranty can also be specified based on invidual contract or agreenment with party that requires it.