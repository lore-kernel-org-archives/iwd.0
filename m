Content-Type: multipart/mixed; boundary="===============4523069164404659467=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/5] auto-t: fix testRSSIAgent after signal agent changes
Date: Wed, 25 May 2022 12:23:28 -0700
Message-ID: <20220525192328.335557-5-prestwoj@gmail.com>
In-Reply-To: 20220525192328.335557-1-prestwoj@gmail.com

--===============4523069164404659467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The signal agent notifications were changed which breaks this test.
Specifically commit ce227e7b94 sends a notification when connected
which breaks the 'agent.calls' check. Since this check is done both
after connecting and once already connected the initial value may
be 1 or 0. Because of this that check was removed entirely.
---
 autotests/testRSSIAgent/connection_test.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/autotests/testRSSIAgent/connection_test.py b/autotests/testRSS=
IAgent/connection_test.py
index 160a17b3..4ffa3d2c 100644
--- a/autotests/testRSSIAgent/connection_test.py
+++ b/autotests/testRSSIAgent/connection_test.py
@@ -56,7 +56,6 @@ class Test(unittest.TestCase):
             # at least) uses a moving-window average value over the last R=
SSI
             # measurements received from the driver and it changes gradual=
ly.
             # Normally 1 second is enough.
-            self.assertEqual(agent.calls, 0)
             for centre, level in rssi_pairs:
                 rule.signal =3D centre
                 agent.level =3D -1
-- =

2.34.1

--===============4523069164404659467==--

