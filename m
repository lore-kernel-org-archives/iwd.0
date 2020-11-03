Content-Type: multipart/mixed; boundary="===============7299225487955370984=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: fix agent path timing issue
Date: Tue, 03 Nov 2020 11:06:41 -0800
Message-ID: <20201103190641.2736204-4-prestwoj@gmail.com>
In-Reply-To: <20201103190641.2736204-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7299225487955370984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The agent path was generated based on the current time which
sometimes yielded duplicate paths if agents were created quickly
after one another. Instead a simple iterator removes any chance
of a duplicate path.
---
 autotests/util/iwd.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 7b08c23e..3ffd9f23 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -705,17 +705,22 @@ class OrderedNetwork(object):
                         str(self.signal_strength)) + '\n'\
                 '\tObject: \n' + self.network_object.__str__('\t\t')
 =

+agent_count =3D 0
 =

 class PSKAgent(dbus.service.Object):
 =

     def __init__(self, passphrases=3D[], users=3D[]):
+        global agent_count
+
         if type(passphrases) !=3D list:
             passphrases =3D [passphrases]
         self.passphrases =3D passphrases
         if type(users) !=3D list:
             users =3D [users]
         self.users =3D users
-        self._path =3D '/test/agent/' + str(int(round(time.time() * 1000)))
+        self._path =3D '/test/agent/%s' % agent_count
+
+        agent_count +=3D 1
 =

         dbus.service.Object.__init__(self, dbus.SystemBus(), self._path)
 =

-- =

2.26.2

--===============7299225487955370984==--

