## Quick & dirty Git repo creation

From the commandline:

```
mkdir freqtrade-datasets
cd freqtrade-datasets

# Make file
echo "# freqtrade-datasets" >> README.md

# Initialize GIT repo
git init
git add .
git commit -m "first commit"
git branch -M main

# Make remote Github Git container on github
# and upload initial Git.
git remote add origin https://github.com/Willemstijn/freqtrade-datasets.git
git push -u origin main
```

From now every local change can be added to Github with:

Nb. `git add .` doet alleen de huidige directory met onderliggende directories toevoegen.
De standaard is eigenlijk `git add -A` om alles in alle directories toe te voegen van de betreffende GIT repo.

```
git add .
git commit -m "Comment for last change"
git push
```

## Synchronise local git with remote repository

```
git pull
```

## Cloning a repository from github

```
git clone <repository link>
```

## Other procedure for making a new repository

```
#!/bin/back
# Below a short shell script to initialize a local git repository

mkdir repo
cd repo
git init
echo abc . text.txt
git add .
git commit -c 'first commit'

dd if=/dev/urandom of=archlinux-2017.01.01.dual.iso count=100 bs=1M
echo abc > text1.txt
git add .
git commit -c 'second commit'

echo dec >> text.txt
git add .
git commit -c 'mods to text'
git repack -A

# How to check on the disk size, make git not use the iso for the repo and check again

du -shc .git
git forget-blob rchlinux-2017.01.01.dual.iso
du -shc .git
```

## Let Git remember your user credentials

```
git config --global credential.helper store
```

provide a username and password and those details will then be remembered later. The credentials are stored in a file on the disk, with the disk permissions of "just user readable/writable" but still in plaintext.

If you want to change the password later `git pull` will fail, because the password is incorrect, git then removes the offending user+password from the ~/.git-credentials file, so now re-run
git pull to provide a new password so it works as earlier.

```
$ git config --list
credential.helper=store
user.email=willemstijn@gmail.com
user.name=bas@exegol
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=https://github.com/Willemstijn/freqtrade-datasets.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
```

## Handle untracked files

```
git add --all
git commit -m "untracked files fix"
git push
```

## Force overwrite to local files

When the notification error: Your local changes to the following files would be overwritten by merge: is shown because you've been working on the code on another computer and this computer is 'out of sync'.
Use:

```
git fetch --all
git reset --hard origin/main
```

OR If you are on some other branch:

```
git reset --hard origin/<branch_name>
```

## Large file problem in GIT

The following error occurs remote: `error: GH001: Large files` detected. You may want to try Git Large File Storage.

It turns out that GitHub only allows for 100 MB file. The problem is that you can’t simply remove the file because it is tracked inside the previous commits so you have to remove this file completely from my repo.

Solution:

```
git filter-branch -f --tree-filter 'rm -f programming/Javascript-books/2019-07-11 JavaScript Guru Guide.pdf' HEAD --all
```

## Git Branches

https://www.youtube.com/watch?v=sgzkY5vFKQQ

### Maken van een nieuwe branch

```
git checkout -b secondBranch
```

Of

```
git branch
git branch secondBranch
git checkout secondBranch
git branch
```

Make changes, then after changes

```
git add .
git commit -m “comment”
git log # toont logs van de huidige branch (secondBranch)
```

### Uploaden naar github van secondBranch

```
git checkout secondBranch
git add .
git commit -m “comment”
git push
```

Indien deze branch nog niet bestaat

```
git push --set-upstream origin secondBranch
```

### Terug naar main branch

```
git checkout main
git log # toont logs van de huidige branch (main)
```

Merk op dat alle wijzigingen nu niet meer zichtbaar zijn

Nu weer terug

```
git checkout secondBranch
```

### Merge branches met:

```
# LET OP! Altijd vanuit de main branch mergen!
git checkout main
git merge secondBranch
# geef comment en daarna enter
```

### Delete a branch

```
git branch -d secondBranch
```

Meer info op: https://www.youtube.com/watch?v=HVsySz-h9r4

## GIT repo herstellen of terugzetten

### Unstage

Een bestand dat staged is (git add) unstagen met

```
git reset (filename)
git status
```

Laat nu zien dat het bestand unstaged is.

### Undo de laatste commit

Een commit terugdraaien met

```
git reset HEAD~1
git status
git diff
```

HEAD~1 zegt dat git moet kijken naar de eenvoorlaatste commit.

### Undo naar een commit ergens in de geschiedenis

Eerst kijk je naar de log van git en haalt de UID van de betreffende commit op waarnaar je terug wilt.

```
git log
git reset 1134038410491812098j3232-43jr32432
git status
git diff
```

Je bent nu terug bij de betreffende commit eerder.

### Undo een commit naar een eerder commit EN verwijderen van alle wijzigingen

In de bovenstaande reset is teruggegaan naar de eerdere git versie en zijn alle wijzigingen behouden.
In deze methode gaan we terug naar een git in de geschiedenis EN verwijderen we tegelijk alle wijzigingen die zijn uitgevoerd.
Dit is dus echt versiebeheer.

```
git log
git reset --hard 3423-40834820483204238048234328
git status
git diff
```

Merk nu op dat alle wijzigingen ook echt weg zijn. HEAD is nu naar een eerdere git versie aan het verwijzen.

## Force overwrite to local files

When the notification `error: Your local changes to the following files would be overwritten by merge:` is shown because you've been working on the code on another computer and this computer is 'out of sync'.

Use:

```bash
git fetch --all
git reset --hard origin/master

#OR If you are on some other branch:
git reset --hard origin/<branch_name>
```

## Large file problem in GIT

The following error occurs `remote: error: GH001: Large files detected. You may want to try Git Large File Storage`.

It turns out that GitHub only allows for 100 MB file. The problem is that you can’t simply remove the file because it is tracked inside the previous commits so you have to remove this file completely from my repo.

Solution:

```bash
git filter-branch -f --tree-filter 'rm -f programming/Javascript-books/2019-07-11 JavaScript Guru Guide.pdf' HEAD --all
```

## Viewing what changed in the repository

To view the log, type:

```
git log
```

To view the log in list format, type:

```
git lg
```

To view the lines that have changed during the last commits, type:

```
git lg -p
```

## GIT differences between files

```
git diff
```

## Reset van Git add commando

Nadat je git add hebt gedaan, kun je deze nog terugzetten naar alle wijzigingen voor dit commando:

Gebruik daarvoor:

```
git reset
```

Alle veranderingen zijn daarna unstaged

### Alleen wijzigingen van een specifieke directory doorvoeren aan stage

```
git add -A my_dir
```

### Alleen tracked files in een stage voor commit plaatsen

```
git add -u
```

Nieuwe bestanden die nog niet in de git repo zijn getracked worden niet meegenomen.

## Undo mistakes and rollback commits

Van Corey Shafer...

```
# krijg statusoverzicht van de repo
git status

# Toon log van eerdere activiteiten
git log

# Toon alle branches
git branch

# Toon verschillen tussen huidige bestand en eerdere commit bestand
git diff

# Alle wijzigingen terugdraaien naar vorige git commit van een file
git checkout [filenaam.py]

# Eerdere git commit message fout herstellen (git commit -m "fout bericht")
# Zonder een nieuwe commit te moeten doen
git commit --amend -m "herstelbericht van vorige fout"

# controleren
git log

# vergeten bestand aan vorige commit toevoegen (veelgebruikte fout door mij...)
git add [aanvullend bestand]
git commit --amend
git log

# toon wijzigingen in de git log
git log --stat

# Git commits aan de verkeerde branch toegevoegd, wat nu?
git log (achterhaal de git commit hash)
git checkout [andere branch naam]
git log (on deze branch te controleren)
git cherry-pick [deel van de hash van andere branch]
git log (zie dat de andere commit hiernaartoe is gebracht)
git checkout master (terug naar master branch)
git log (bewaar begindeel van de commit hash)
git status
git reset --soft [hashdeel] (vorige commit wordt teruggedraaid maar wijzigingen in die branch niet)
git status
git reset [hashdeel] (Dit is de mised standaard mode die nog steeds wijzigingen bewaard maar de bestanden uit staging mode haalt) 
git reset --hard [hasdeel] (ALLE wijzigingen worden teruggebracht naar vorige commit en alle wijzigingen zijn weg van tracked files)
git log (merk op dat untracked files nog bestaan)
git clean -df (verwijder ook alle untracked files in deze repository)
```

git clean df kan ook helpen bij het verwijderen van per ongeluk uitgepakte zips of kopieren naar de repo wat niet handig was.

Wat als we bovenstaande uitgevoerd hadden maar we willen deze bestanden toch weer terug hebben..?

```
# kijken naar de commando's die je hebt uitgevoerd
git reflog

# Pack de hash van voor de reset die je uitgevoerd hebt
git checkout [hash]

# zie nu dat je alle veranderingen terug hebt
git log

# Omdat dit geen onderdeel is van een actieve branch raak je eventueel toch deze spullen kwijt
# Dit zit namelijk in de detached HEAD van de git repo
# Maak er daarom een branch van met:
git branch backup

git branch

git checkout backup
git log (zie dat deze wijzigingen toch bewaard zijn)

git reflog
```

Bovenstaande verwijderd wel elke keer een voorgaande commit en dat kan onhandig uitpakken als iemand anders jouw repo heeft gebranched

Om terug te gaan naar een vorige commit en toch de tussentijdse commit wijzigingen te bewaren, gebruik dan:

```
git revert [hash van commit die je wilt weghalen]

git log (nieuwe commit is gemaakt met revert vorige commit)
```

Verschill (difference) tussen twee commits tonen

```
git log
git diff [oudste commit hash] [nieuwste commit hash]
```

Download a private repo

You need to add **"username:pat@"** after **"https://"** and before **"github.com/"** as shown below:

****pat** is **PAT(Personal Access Token)**.*

```
git clone https://username:pat@github.com/username/reponame.git 
```

***To clone a private repository, you need to generate a PAT(Personal Access Token) on **Github** and add it to the command.***

### This is how you generate a PAT(Personal Access Token) on Github:

**1,** Go to **"Settings"**:

[![enter image description here](:/ae276e1b529d4a819a1801b66205a384)](https://i.stack.imgur.com/3VrIs.png)

**2,** Scroll down then go to **"Developer settings"**:

[![enter image description here](:/282f851e81e148eeab8184eebcd50a38)](https://i.stack.imgur.com/uDsJm.png)

**3,** Press **"Personal access tokens"** then press **"Generate new token"**:

[![enter image description here](:/8a786d29777b473a81f91ace0ee524b8)](https://i.stack.imgur.com/QtFtT.png)

**4,** Fill **"Note"** then check **"repo"**:

**If **"repo"** is not checked, you cannot clone a private repository.*

[![enter image description here](:/02f3cfba4dcf45228a760d1dc2110bce)](https://i.stack.imgur.com/3HshU.png)

**5,** Scroll down then press **"Generate token"**:

[![enter image description here](:/47d6be614b284f29b7ca8352e943e6ae)](https://i.stack.imgur.com/Nxmr0.png)

**6,** Finally, a **PAT** is generated:

[![enter image description here](:/8d0c72a0a5cb44a5b9099cd55777f9bc)](https://i.stack.imgur.com/9XEDY.png)

This is the command with **the PAT generated above**:

```
git clone https://username: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@github.com/username/reponame.git 
```