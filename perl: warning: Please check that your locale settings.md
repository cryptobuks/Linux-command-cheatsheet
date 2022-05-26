```
perl: warning: Please check that your locale settings:

perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_MONETARY = "nl_NL.UTF-8",
	LC_ADDRESS = "nl_NL.UTF-8",
	LC_TELEPHONE = "nl_NL.UTF-8",
	LC_NAME = "nl_NL.UTF-8",
	LC_MEASUREMENT = "nl_NL.UTF-8",
	LC_IDENTIFICATION = "nl_NL.UTF-8",
	LC_NUMERIC = "nl_NL.UTF-8",
	LC_PAPER = "nl_NL.UTF-8",
	LANG = "en_GB.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_GB.UTF-8").


You can fix the issue by setting the locale to en_US.UTF-8 for example:

$ export LANGUAGE=en_US.UTF-8
$ export LANG=en_US.UTF-8
$ export LC_ALL=en_US.UTF-8
$ locale-gen en_US.UTF-8
$ dpkg-reconfigure locales




I was having a very similar issue. Here's how I fixed it:

Run sudo nano /etc/default/locale

Change it to include these three lines:

LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANGUAGE=en_US.UTF-8

```
