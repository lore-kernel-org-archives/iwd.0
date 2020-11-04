Content-Type: multipart/mixed; boundary="===============2337970420379817572=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] doc: add man pages for AP provisioning files
Date: Wed, 04 Nov 2020 08:52:24 -0800
Message-ID: <20201104165227.2782516-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2337970420379817572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |  6 +++--
 src/iwd.ap.rst | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 src/iwd.ap.rst

diff --git a/Makefile.am b/Makefile.am
index d49833b7..1f0b0d30 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -171,7 +171,8 @@ man_MANS =3D
 endif
 =

 manual_pages =3D src/iwd.8 src/iwd.debug.7 src/iwd.config.5 src/iwd.networ=
k.5 \
-		client/iwctl.1 monitor/iwmon.1 wired/ead.8 tools/hwsim.1
+		src/iwd.ap.5 client/iwctl.1 monitor/iwmon.1 wired/ead.8 \
+		tools/hwsim.1
 =

 eap_sources =3D src/eap.c src/eap.h src/eap-private.h \
 				src/eap-md5.c \
@@ -263,7 +264,8 @@ systemd_network_DATA +=3D src/80-iwd.link
 endif
 =

 if MANUAL_PAGES
-man_MANS +=3D src/iwd.8 src/iwd.debug.7 src/iwd.config.5 src/iwd.network.5
+man_MANS +=3D src/iwd.8 src/iwd.debug.7 src/iwd.config.5 src/iwd.network.5=
 \
+		src/iwd.ap.5
 endif
 endif
 =

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
new file mode 100644
index 00000000..939bf99d
--- /dev/null
+++ b/src/iwd.ap.rst
@@ -0,0 +1,62 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ iwd.ap
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+--------------------------------------
+Configuration of IWD access point
+--------------------------------------
+
+:Author: James Prestwood <prestwoj@gmail.com>
+:Copyright: 2020 Intel Corporation
+:Version: iwd
+:Date: 20 October 2020
+:Manual section: 5
+:Manual group: Linux Connectivity
+
+NAME
+=3D=3D=3D=3D
+iwd.ap - Access point provisioning files
+
+SYNOPSIS
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Description of access point provisioning files.
+
+DESCRIPTION
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+An access point provisioning files define the configuration of an IWD acce=
ss
+point. These files live in *$STATE_DIRECTORY*/ap (/var/lib/iwd/ap by defau=
lt).
+
+FILE FORMAT
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+See *iwd.network* for details on the file format.
+
+SETTINGS
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The settings are split into several categories.  Each category has a group
+associated with it and described in separate tables below.
+
+Network Authentication Settings
+-------------------------------
+
+The group ``[Security]`` contains settings for Wi-Fi security and authenti=
cation
+configuration.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - Passphrase
+     - 8..63 character string
+
+       Passphrase to be used with this access point.
+
+SEE ALSO
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+iwd(8), iwd.network(5)
-- =

2.26.2

--===============2337970420379817572==--

