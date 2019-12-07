Content-Type: multipart/mixed; boundary="===============0623586425010719164=="
MIME-Version: 1.0
From: hoe.dom@gmx.de
Subject: Suggestion: make iwctl follow the XDG Base Directory Specification
Date: Sat, 07 Dec 2019 10:47:13 +0000
Message-ID: <20191207104713.2883.96138@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0623586425010719164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.
Currently iwctl writes its history to a file named .iwctl_history in the us=
ers home directory. The XDG Base Directory Specification tries to standardi=
ze these kind of things (see https://specifications.freedesktop.org/basedir=
-spec/basedir-spec-latest.html for details). The bottom line would probably=
 be to:
* check XDG_DATA_HOME (with fall back to .local/share/) and save the histor=
y in an iwd subfolder of that directory
* potentially read (and migrate?) .iwctl_history from the home directory fo=
r compatibility purposes

Thanks for iwd by the way. Its a huge improvement over the wpa_supplicant w=
orld!
--===============0623586425010719164==--

