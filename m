Content-Type: multipart/mixed; boundary="===============6040557472905771483=="
MIME-Version: 1.0
From: Jesus Gonzalez <jesusmgh@gmail.com>
Subject: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Fri, 27 Aug 2021 08:05:30 +0000
Message-ID: <20210827080530.2802.3544@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6040557472905771483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First of all: I looked around and found no dedicated bug tracker. if this i=
s not the place to report bugs, please excuse me, and I would be glad to be=
 pointed in the correct direction. Thank you!

Starting with iwd 1.16 I am not able to connect to my home WLAN network. It=
 is a WPA3 SAE protected access point running on a Netgear R7800 with OpenW=
RT, in case it matters. Connecting to my WPA2 PSK AP on my phone as a test =
works just fine.

The connection log from the client: https://pastebin.com/48umPPzh

The only but decisive log entry in the AP: https://pastebin.com/W7JsH1kY

It seems after iwd 1.16 the client tries to associate before it is correctl=
y authenticated. Maybe a race condition, and iwd got too fast for the route=
r?

I tried to bisect between 1.15 and 1.16 to get the commit, but I ran into p=
roblems while building (make[1]: *** No rule to make target 'ell/util.c', n=
eeded by 'ell/util.lo'.  Stop.) and I currently lack the time to troublesho=
ot Makefiles.

Sorry for the vague infos. If you want more logs, tell me what you need and=
 I'll be happy to provide it! Thank you!
--===============6040557472905771483==--

