The licensing has been discussed in FSF which is due to the activity and info provided getting out of hand for me to process all the informations and resolve duplicate questions thus this file has been created hopefully being usable for the project in the future.

# What is this?
Summary: This is project codenamed as RXT0112 with assigned name Zernit currently hosted on https://github.com/RXT0112/Zernit which is expected to be system/package-manager that is expected to supports any downstream on any kernel with custom dowsntream method.

Project supports all programming languages and it's file hiearchy has been adapted for this workflow
- currently with issues in cargo (rustlang crate manager and compiler) and vlang that are currently in works.

Project currently has 248 checks that trigger based on files changed designed to ensure code quality with option to make custom solution where needed.

Developed with optional GUI to allow software modding (i.e game modding using GUI)
- Due to the usage of games it is designed to allow proprietary software with option to help developers to convert their code on open-source where it would make sense.

Project requires redistribution of downstream so that end-user would be able to download the instructions
- Using mirrors of official downstream
- Using P2P of official and unofficial instructions (using blockchain-like structure so that end-user would be able to download the required instructions without limitations on our end)
- Allows 3rd party sources so that everyone can make their own packages, mods, etc..

Project is planned to have mentoring program for end-users/contributors for free to learn programming language and how to contribute/use the software properly
- Mentoring program will have IRC to Discord to Matrix.org to zulip bridge set up in case end-user requires help through chat
- Forum is expected to be set up for complicated issues only
- Documentation is hosted using jekyll which will be referenced during support in case it mensions the solution with additional support in case the content is not fully understood.
  - If the content is not fully understood or documentation is missing required info the supportee will be encouraged to make a contribution (inspired by archlinux/gentoo)

Project expects stable economy that would allow bug bounties and optional method to pay contributors for their productivity.

Original creator plans on making OSS hardware which is expected to be covered by this project as well.

Business plan that would allow for a stable profit is preferred.

This project is designed to be compatible with four freedoms mensioned on https://www.gnu.org/philosophy/free-sw.en.html

## Issues

### Mentoring program
Inspired by exherbo.org approach this project does not expect help-vampires that expects babysitting that would cost the project it's resources
- End-users that are willing to learn and are asking relevant informations are always welcomed and for these we designed this program
- Mentoring program is expected to be for free to avoid placing a paywall on end-user's competence and to avoid mentors rushing through with the education to maximalize their profit while sacrificing the end-user's education.
- Original creator has community of students that are already following this ideology of free education and are expected to perform as mentors on this project.

Based on my understanding and info provided by exherbo and my experience with them i believe that exherbo has implemented what i would call “filtering mechanism” which makes the distro not usable or pain to use for users (confusing the end-user with wrong info, banning end-users, etc… ) and keeps only contributors and developers capable of maintaining it.
Since to use the distro you need an access to repositories and know how to make the downstream in case you encounter blocking bug (which happens a lot) and the initial installation using tarball seems to be made to make the initial compilation painful to do due to the blocks, banned features without which the package manager won’t resolve the packages and requires configuration of /etc/paludis which may take hours-weeks to do without proper documentation and guidance.
For example there were few users enraged by this that they made https://web.archive.org/web/20190302155000/https://exherbo.com/ and pages purposely spreading false informations about the creator one of which is still up https://bryanostergaard.com/ (the creator is friendly and nice guy don’t believe the info provided on mensioned websites).
Which is what inspired this approach, but i want to make it more user-friendly to avoid confused users that are just not willing to learn how to use the software properly that would otherwise cause a segmentation of them making weird forks that has code quality issues and breaks the software in a way that fixes their issue by breaking other X functions.

### Segmentation
Referencing ripple project on https://github.com/osuripple/lets/pull/5 this project is expected to have a method to avoid segmentation of the project to comply with four freedoms it has been developed as such:
- Standalone forks are not allowed unless upstream prevents a feature to be implemented.
- Contribution forks are welcomed assuming that contributor makes a draft merge request to the original repository for the porpose of code-quality and direct upstream support
- Competent and trusted contributors will be able to get write access to relevant files, but reviews will be encouraged even with this access.

### Redistribution
Malware in distributed files is a concern
- Digital distribution is expected to be handled by upstream
- There is expected to be set of rules maintained by upstream and community to ensure that the digital distribution is safe to use
  - Project will issue a warning to third party if these rules are not met and do it's best to help with compliance with these rules
  - If third party does not comply with these rules even after it has been warned the project will take legal action.
- Digital distribution will always have checksums
  - in case upstream gets compromised
  - in case repository hoster gets compromised
  - in case end-user downloads corrupted file
- Physicall distribution is expected to be handled by upstream and authorised parties
  - There is expected to be set of rules maintaned by upstream and community to ensure safety of these physicall copies
  - From business point of view upstream expects cut from profit
  - Will be bundled with checksum hosted on remote in case the physical device gets corrupted or mishandled
Project is rolling release with version control
- Physical distribution of rolling releases is not allowed to avoid unsable software distribution and outdated software.

### Profit
Project is expected to have stable economy to sustain bug bounties, it's activity and ideally improve wealth of original creator.
- Project is expected to be paid for commercial use
- Project considers paid license for non-contributing members assuming it being implemented in a way that would motivate end-users from being help-vampires without sacrificing four freedoms
- Support provided by the project is expected to be always free.
- Project accepts donations
- Project accepts sponsorships
- Project is designed to be for sale for X amount of time inspired by OpenSUSE's approach where original creator would stay in charge to avoid new owner from changing it's components.
- In general more funds without sacrificing four freedoms the better.

## Solutions

### Code-quality
Currently project has 248 tests set up with expectation on 811 that are going to trigger based on files edited to help with project maintainance.

Project has set up hierarchy for reviewers that are expected to review merge requests before being merged (sourced from original creator's community for a kick-start)

mensioned mentoring project and method to handle contribution forks

### 

### Other plans

#### Free hosting
Project is expected to provide free hosting as a part of mentoring program and to support new developers. (requires funds to handle the server cost)
- VPN hosting not allowed
- Cryptocurrency mining not allowed
- Setting up a rendering farm not allowed

#### OSS hardware development
Project's business plan is expected to handle OSS hardware development
- Currently Portable device (https://github.com/kreyware/RXT0117) and aircraft (https://github.com/kreycraft0) assuming cooperation with EAA (https://www.eaa.org/eaa) in the works.


