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
Version 0, 20 January 2020

Copyright (C) 2020 [RiXotStudio](http://rixotstudio.cz)
Copyright (C) 2019 [Jacob Hrbek](mailto:kreyren@rixotstudio.cz)

<!-- FIXME: Rephrase -->
None is allowed to distribute copies of this license without explicit permission granted by this license.

<!-- FIXME: Render preamble in the middle of the documment -->
## Preamble
This license is made to protect the intellectual property and direct workflow of project codenamed as **RXT0112** also known as **Zernit** where this license is developed based on [GPL-3 license](https://www.gnu.org/licenses/gpl-3.0.en.html) and [Free Software Foundation](https://www.fsf.org) philosophy adapted for commercial use.

License is community maintained where only the authorized personel identified as **license managers** (or LM for short) are permitted to make changes in the original repository in which this license has been created.
These authorized personel can be also clarified in `.github/CODEOWNERS` to appropriate GitHub Team or personal to allow auto-merge in source.

## TERMINOLOGY

### Comments
Comments are a feature in Markdown (Formatting method used to write this file) that do not render on runtime and are not part of the license.

Every comment is prefixed with `<!--` and suffixed with `-->` which can be applied through multiple lines.

### License Managers (or 'LM' for short)
**L**icense **M**anagers clarified in path `.github/CODEOWNERS` in this repository are authorised personell with permission to perform merges in LICENSE files.

### Original Creator (or 'OC' for short)
Original Creator of this repository is `Jacob Hrbek <kreyren@rixotstudio.cz>`. OC reserves all rights to whole repository unless license provide in the root of affected directory of file header states otherwise.

### Repository Managers (or 'RM' for short)
Repository Managers are defined as service with the ability to host this repository for maintainer or General Public access.

### Merge Request
Also wrongly named as 'Pull Requst' by many RMs is method to submit new changes in the target repository.

#### Draft Merge Requests
Referencing https://github.blog/2019-02-14-introducing-draft-pull-requests/ for upstream (github) explanation.

In short this is merge request which is being worked on before it can be submitted for review and considered for merge.

### Forks
Forks are RM's features that allows anyone to make a copy of a repository in their specified profile.

## Terms and conditions 

### Contributions
Everyone is allowed to fork this repository as long as the source code stays public with the intention to provide a contribution to the original repository.

Creating standalone forks alike creating standalone fork with the intention to provide unique features that are not developed with the intention to contribute the changes in original repository are not allowed and OC reserves an explicit permission to issue DMCA takedown to prevent segmentation of original repository.

Contributions of new features are expected to be submitted in a form of new merge request set as draft until reviw is requested by switching the contribution from draft to open.

Contributor has the right to specify his own license assuming following methods used:
- License specified as comment in the header (or at the top) of the file which will apply only for specified file

This clarification has to follow this syntax:
```
Created by Jon Doe <jon@doe.wow> using LICENSE (hyperlink://on.theLicense.wow) in 2020
```

- `LICENSE` or `LICENSE.md` file created in the root of directory which will be applied for the whole directory.