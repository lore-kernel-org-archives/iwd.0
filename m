Content-Type: multipart/mixed; boundary="===============5799227723025539561=="
MIME-Version: 1.0
From: caljorden@hotmail.com
Subject: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Wed, 26 Aug 2020 05:51:50 +0000
Message-ID: <20200826055150.2753.90553@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5799227723025539561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I wanted to note an issue that I have hit with iwd when I upgraded to the L=
inux 5.8.3 stable kernel.  My office network uses WPA Enterprise with EAP-P=
EAPv0 + MSCHAPv2.  When using this office network, upgrading to Linux 5.8.3=
 caused my system to refuse to associate successfully to the network.  I ge=
t the following in my dmesg logs:

[   40.846535] wlan0: authenticate with <redacted>:60
[   40.850570] wlan0: send auth to <redacted>:60 (try 1/3)
[   40.854627] wlan0: authenticated
[   40.855992] wlan0: associate with <redacted>:60 (try 1/3)
[   40.860450] wlan0: RX AssocResp from <redacted>:60 (capab=3D0x411 status=
=3D0 aid=3D11)
[   40.861620] wlan0: associated
[   41.886503] wlan0: deauthenticating from <redacted>:60 by local choice (=
Reason: 23=3DIEEE8021X_FAILED)
[   42.360127] wlan0: authenticate with <redacted>:22
[   42.364584] wlan0: send auth to <redacted>:22 (try 1/3)
[   42.370821] wlan0: authenticated
[   42.372658] wlan0: associate with <redacted>:22 (try 1/3)
[   42.377426] wlan0: RX AssocResp from <redacted>:22 (capab=3D0x411 status=
=3D0 aid=3D15)
[   42.378607] wlan0: associated
[   43.402009] wlan0: deauthenticating from <redacted>:22 by local choice (=
Reason: 23=3DIEEE8021X_FAILED)
[   43.875921] wlan0: authenticate with <redacted>:60
[   43.879988] wlan0: send auth to <redacted>:60 (try 1/3)
[   43.886244] wlan0: authenticated
[   43.889273] wlan0: associate with <redacted>:60 (try 1/3)
[   43.894586] wlan0: RX AssocResp from <redacted>:60 (capab=3D0x411 status=
=3D0 aid=3D11)
[   43.896077] wlan0: associated
[   44.918504] wlan0: deauthenticating from <redacted>:60 by local choice (=
Reason: 23=3DIEEE8021X_FAILED)

This continues as long as I let iwd run.

I downgraded back to Linux 5.8.2, and verified that everything works as exp=
ected.  I also tried using Linux 5.8.3 on a different system at my home, wh=
ich uses WPA2-PSK.  It worked fine (though it uses an Atheros wireless card=
 instead of an Intel card - but I assume that is irrelevant).

I decided to try to figure out what caused the issue in the changes for Lin=
ux 5.8.3.  I assumed that it was something that changed in the crypto inter=
face, which limited my bisection to a very few commits.  Sure enough, I fou=
nd that if I revert commit e91d82703ad0bc68942a7d91c1c3d993e3ad87f0 (crypto=
: algif_aead - Only wake up when ctx->more is zero), the problem goes away =
and I am able to associate to my WPA Enterprise network successfully, and u=
se it.  I found that in order to revert this commit, I also first had to re=
vert 465c03e999102bddac9b1e132266c232c5456440 (crypto: af_alg - Fix regress=
ion on empty requests), because the two commits have coupled changes.

I normally would have assumed that this should be sent to the kernel list, =
but I thought I would first mention it here because of what I found in some=
 email threads on the Linux-Crypto list about the crypto interfaces to the =
kernel being sub-optimal and needing to be fixed.  The changes in these com=
mits look like they are just trying to fix what could be broken interfaces,=
 so I thought that it would make sense to see what the iwd team thinks abou=
t the situation first.

The wireless card I was using during this testing is an Intel Wireless 3165=
 (rev 81).  If there is any additional information I could help provide, pl=
ease let me know.

Thanks!

Caleb Jorden
--===============5799227723025539561==--

