Content-Type: multipart/mixed; boundary="===============5879040652329863106=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] auto-t: update AKA/SIM autotests SimAuthBackend
Date: Wed, 16 Sep 2020 10:08:14 -0700
Message-ID: <20200916170814.660095-7-prestwoj@gmail.com>
In-Reply-To: <20200916170814.660095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5879040652329863106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testEAP-AKA-ofono/main.conf       | 2 ++
 autotests/testEAP-AKA-prime-ofono/main.conf | 2 ++
 autotests/testEAP-AKA-prime/main.conf       | 2 ++
 autotests/testEAP-AKA/main.conf             | 2 ++
 autotests/testEAP-PEAP-SIM/main.conf        | 2 ++
 autotests/testEAP-SIM-ofono/main.conf       | 2 ++
 autotests/testEAP-SIM/main.conf             | 2 ++
 7 files changed, 14 insertions(+)
 create mode 100644 autotests/testEAP-AKA-ofono/main.conf
 create mode 100644 autotests/testEAP-AKA-prime-ofono/main.conf
 create mode 100644 autotests/testEAP-AKA-prime/main.conf
 create mode 100644 autotests/testEAP-AKA/main.conf
 create mode 100644 autotests/testEAP-PEAP-SIM/main.conf
 create mode 100644 autotests/testEAP-SIM-ofono/main.conf
 create mode 100644 autotests/testEAP-SIM/main.conf

diff --git a/autotests/testEAP-AKA-ofono/main.conf b/autotests/testEAP-AKA-=
ofono/main.conf
new file mode 100644
index 00000000..45c876d2
--- /dev/null
+++ b/autotests/testEAP-AKA-ofono/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dofono
diff --git a/autotests/testEAP-AKA-prime-ofono/main.conf b/autotests/testEA=
P-AKA-prime-ofono/main.conf
new file mode 100644
index 00000000..45c876d2
--- /dev/null
+++ b/autotests/testEAP-AKA-prime-ofono/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dofono
diff --git a/autotests/testEAP-AKA-prime/main.conf b/autotests/testEAP-AKA-=
prime/main.conf
new file mode 100644
index 00000000..4a67db8f
--- /dev/null
+++ b/autotests/testEAP-AKA-prime/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dhardcoded
diff --git a/autotests/testEAP-AKA/main.conf b/autotests/testEAP-AKA/main.c=
onf
new file mode 100644
index 00000000..4a67db8f
--- /dev/null
+++ b/autotests/testEAP-AKA/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dhardcoded
diff --git a/autotests/testEAP-PEAP-SIM/main.conf b/autotests/testEAP-PEAP-=
SIM/main.conf
new file mode 100644
index 00000000..4a67db8f
--- /dev/null
+++ b/autotests/testEAP-PEAP-SIM/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dhardcoded
diff --git a/autotests/testEAP-SIM-ofono/main.conf b/autotests/testEAP-SIM-=
ofono/main.conf
new file mode 100644
index 00000000..45c876d2
--- /dev/null
+++ b/autotests/testEAP-SIM-ofono/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dofono
diff --git a/autotests/testEAP-SIM/main.conf b/autotests/testEAP-SIM/main.c=
onf
new file mode 100644
index 00000000..4a67db8f
--- /dev/null
+++ b/autotests/testEAP-SIM/main.conf
@@ -0,0 +1,2 @@
+[General]
+SimAuthBackend=3Dhardcoded
-- =

2.26.2

--===============5879040652329863106==--

