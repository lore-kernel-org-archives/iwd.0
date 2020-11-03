Content-Type: multipart/mixed; boundary="===============2777969084923128178=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: remove /var/lib/iwd references in
 testKnownNetworks
Date: Tue, 03 Nov 2020 11:06:40 -0800
Message-ID: <20201103190641.2736204-3-prestwoj@gmail.com>
In-Reply-To: <20201103190641.2736204-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2777969084923128178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testKnownNetworks/frequency_test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testKnownNetworks/frequency_test.py b/autotests/test=
KnownNetworks/frequency_test.py
index f07074f2..9c523bb2 100644
--- a/autotests/testKnownNetworks/frequency_test.py
+++ b/autotests/testKnownNetworks/frequency_test.py
@@ -67,7 +67,7 @@ class Test(unittest.TestCase):
         hs20_freqs =3D None
         hs20_uuid =3D None
         config =3D ConfigParser()
-        config.read('/var/lib/iwd/.known_network.freq')
+        config.read('/tmp/iwd/.known_network.freq')
         for s in config.sections():
             if os.path.basename(config[s]['name']) =3D=3D 'ssidCCMP.psk':
                 psk_freqs =3D config[s]['list']
@@ -116,7 +116,7 @@ class Test(unittest.TestCase):
         psk_uuid2 =3D None
         hs20_freqs =3D None
         config =3D ConfigParser()
-        config.read('/var/lib/iwd/.known_network.freq')
+        config.read('/tmp/iwd/.known_network.freq')
         for s in config.sections():
             self.assertNotEqual(os.path.basename(config[s]['name']),
                                     'example.conf')
-- =

2.26.2

--===============2777969084923128178==--

