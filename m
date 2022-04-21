Content-Type: multipart/mixed; boundary="===============4370678538275197606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: How to run separate iwd for every wifi dongle on the same host?
Date: Thu, 21 Apr 2022 14:29:39 -0500
Message-ID: <212175de-72bc-7278-280d-6682d19be617@gmail.com>
In-Reply-To: 20220421125452.2318.30914@ml01.vlan13.01.org

--===============4370678538275197606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 4/21/22 07:54, zlinuxboy(a)outlook.com wrote:
> could you elaborate more details about how to create private dbus and sta=
rt iwd instance to attach these dbus?

You can take a look at the ell dbus unit test, to get the general idea:

https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/unit/test-dbus.c

Also look at iwd's test-runner, it does something similar as well.

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/utils.py=
#n266

Basically you need to:

1. Start a private dbus-daemon instance at a private address.
2. Point iwd to this dbus-daemon instance by setting the DBUS_SYSTEM_BUS_AD=
DRESS =

environment variable prior to starting iwd.
3. Override iwd's STATE_DIRECTORY or CONFIGURATION_DIRECTORY as needed by =

setting the appropriate environment variables (see 'man 8 iwd').
4. Each iwd instance would only be accessible via the private dbus daemon =

instance.  So 'iwctl' or your own dbus client would need to use the private=
 dbus =

address(es) from step 1.

Probably something else I'm not thinking of?  Hope this helps.

Regards,
-Denis
--===============4370678538275197606==--

