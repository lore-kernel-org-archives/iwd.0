Content-Type: multipart/mixed; boundary="===============4308830450807686936=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 4/5] doc: add python package requirements for test-runner
Date: Wed, 27 Jan 2021 10:05:03 +0000
Message-ID: <20210127100457.341757-4-alsi@bang-olufsen.dk>
In-Reply-To: <20210127100457.341757-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4308830450807686936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/test-runner.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 3426d1dc..c5f29324 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -40,6 +40,15 @@ Note: Running EAP-SIM/AKA/AKA' tests using oFono will re=
quire oFono and
 phonesim to be installed on the host. This is explained further in the
 "Running with oFono and phonesim" section.
 =

+In addition, the following Python packages are required:
+
+	Name:			Tested ver.:
+	 1. python-prettytable	0.7.2
+	 2. python-termcolor	1.1.0
+	 3. python-pyroute2	0.5.14
+	 4. python-gobject	3.38.0
+	 5. python-dbus		1.2.16
+
 Building Kernel
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.29.2
--===============4308830450807686936==--

