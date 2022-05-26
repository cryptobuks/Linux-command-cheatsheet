Fonts list bekijken

```
fc-list
fc-list | grep -i Noto
```

Many non-western font families can removed by running this command in the terminal:

```
sudo apt remove fonts-lao fonts-lklug-sinhala fonts-sil-abyssinica fonts-sil-padauk fonts-tibetan-machine fonts-thai-tlwg fonts-lohit-guru fonts-guru-extra
sudo apt remove fonts-stix
```



## Complete method

Check all installed fonts installed EXCEPT those within the regexp.  These fonts you want to keep for sure.

```
echo `dpkg -l fonts\*|grep ii|awk '{print $2}'|grep -vE 'fonts-(noto$|liberation|dejavu|freefont|hack)'`
```

The output looks like this

```
fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-droid-fallback fonts-font-awesome fonts-gargi fonts-glyphicons-halflings fonts-gubbi fonts-gujr fonts-gujr-extra fonts-kacst fonts-kacst-one fonts-kalapi fonts-khmeros-core fonts-knda fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-mathjax fonts-mlym fonts-nakula fonts-navilu fonts-noto-cjk fonts-noto-color-emoji fonts-noto-mono fonts-opensymbol fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-sarai fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-gayathri fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-taml fonts-telu fonts-telu-extra fonts-tlwg-garuda fonts-tlwg-garuda-ttf fonts-tlwg-kinnari fonts-tlwg-kinnari-ttf fonts-tlwg-laksaman fonts-tlwg-laksaman-ttf fonts-tlwg-loma fonts-tlwg-loma-ttf fonts-tlwg-mono fonts-tlwg-mono-ttf fonts-tlwg-norasi fonts-tlwg-norasi-ttf fonts-tlwg-purisa fonts-tlwg-purisa-ttf fonts-tlwg-sawasdee fonts-tlwg-sawasdee-ttf fonts-tlwg-typewriter fonts-tlwg-typewriter-ttf fonts-tlwg-typist fonts-tlwg-typist-ttf fonts-tlwg-typo fonts-tlwg-typo-ttf fonts-tlwg-umpush fonts-tlwg-umpush-ttf fonts-tlwg-waree fonts-tlwg-waree-ttf fonts-ubuntu fonts-urw-base35 fonts-yrsa-rasa
```

Add these to a deinstall file for later use with apt

```
echo `dpkg -l fonts\*|grep ii|awk '{print $2}'|grep -vE 'fonts-(noto$|liberation|dejavu|freefont|hack)'` >  not-needed-font-packages.txt
```

Now  test the remove these fonts command with dryrun option.

```
sudo dpkg --remove --dry-run `cat not-needed-font-packages.txt`
```

To remove ONLY specified packages and IGNORE all broken dependencies and requirements of other installed packages, run the command:

```
sudo dpkg --remove --force-all --dry-run `cat not-needed-font-packages.txt`
```

To finally remove unnecessary packages, remove the --dry-run option, and run the final command:

```
sudo dpkg --remove --force-all `cat not-needed-font-packages.txt`
```

You can always reinstall them if there is a problem

```
```

After that, I have the system with ONLY fonts I like. You can check what font packages remained using this command:

```
dpkg -l fonts\*|grep ^ii|awk '{print $2}'
```

To refresh the font cache, so that applications stop showing the removed fonts, run

```
fc-cache -fv
```
