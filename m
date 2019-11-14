Content-Type: multipart/mixed; boundary="===============6323279318292668618=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix intermittent failures in testEAP-MSCHAPV2
Date: Thu, 14 Nov 2019 10:43:56 -0800
Message-ID: <20191114184356.23993-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6323279318292668618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Occationally autoconnect would start which was not expected in the
test. This is fixed by disabling autoconnect in the provisioning files.
---
 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x | 3 +++
 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x | 3 +++
 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x | 3 +++
 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x
index 1cbdc821..55eb431d 100644
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x
+++ b/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x
@@ -2,3 +2,6 @@
 EAP-Method=3DMSCHAPV2
 EAP-Identity=3Ddomain\\User
 EAP-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x
index 04ff213a..a2c58b33 100644
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x
+++ b/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x
@@ -2,3 +2,6 @@
 EAP-Method=3DMSCHAPV2
 EAP-Identity=3Ddomain\\User
 EAP-Password-Hash=3Da4f49c406510bdcab6824ee7c30fd852
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x
index 56390d76..2c18c8fd 100644
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x
+++ b/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x
@@ -1,3 +1,6 @@
 [Security]
 EAP-Method=3DMSCHAPV2
 EAP-Identity=3Ddomain\\User
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x
index 39820dff..d7528b38 100644
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x
+++ b/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x
@@ -1,2 +1,5 @@
 [Security]
 EAP-Method=3DMSCHAPV2
+
+[Settings]
+AutoConnect=3Dfalse
-- =

2.17.1

--===============6323279318292668618==--

