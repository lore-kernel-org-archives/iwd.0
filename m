Content-Type: multipart/mixed; boundary="===============0299661837318279866=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: iwd.py: use spaces instead of tabs
Date: Tue, 04 Jan 2022 10:29:53 -0800
Message-ID: <20220104182953.110310-1-prestwoj@gmail.com>

--===============0299661837318279866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 4e69c7e8..54b4819e 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -710,7 +710,7 @@ class Network(IWDDBusAbstract):
             Connect to the network. Request the device implied by the obje=
ct
             path to connect to specified network.
 =

-			Possible exception: AbortedEx
+            Possible exception: AbortedEx
                                 BusyEx
                                 FailedEx
                                 NoAgentEx
-- =

2.31.1

--===============0299661837318279866==--

