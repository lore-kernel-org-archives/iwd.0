Content-Type: multipart/mixed; boundary="===============6213577945377304062=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: update deprecated option
Date: Fri, 30 Jul 2021 13:07:25 -0700
Message-ID: <20210730200725.222072-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6213577945377304062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

testBSSBlacklist was using the old addressr randomization option
---
 autotests/testBSSBlacklist/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testBSSBlacklist/main.conf b/autotests/testBSSBlackl=
ist/main.conf
index d1e78fef..f81a5ae8 100644
--- a/autotests/testBSSBlacklist/main.conf
+++ b/autotests/testBSSBlacklist/main.conf
@@ -2,4 +2,4 @@
 InitialTimeout=3D10
 =

 [Scan]
-disable_mac_randomization=3Dtrue
+DisableMacAddressRandomization=3Dtrue
-- =

2.31.1

--===============6213577945377304062==--

