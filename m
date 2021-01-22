Content-Type: multipart/mixed; boundary="===============1260547855423932575=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 13:56:00 +0000
Message-ID: <20210122135558.588248-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1260547855423932575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

systemd specifies a special passive target unit 'network-pre.target'
which may be pulled in by services that want to run before any network
interface is brought up or configured. Correspondingly, network
management services such as iwd and ead should specify
After=3Dnetwork-pre.target to ensure a proper ordering with respect to
this special target.

For more information, see systemd.special(7) and [1].

[1] https://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/
---
 src/iwd.service.in   | 1 +
 wired/ead.service.in | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/iwd.service.in b/src/iwd.service.in
index 77819eaf..96e4abac 100644
--- a/src/iwd.service.in
+++ b/src/iwd.service.in
@@ -1,5 +1,6 @@
 [Unit]
 Description=3DWireless service
+After=3Dnetwork-pre.target
 Before=3Dnetwork.target
 Wants=3Dnetwork.target
 =

diff --git a/wired/ead.service.in b/wired/ead.service.in
index 387fdb68..6403c9e4 100644
--- a/wired/ead.service.in
+++ b/wired/ead.service.in
@@ -1,5 +1,6 @@
 [Unit]
 Description=3DEthernet service
+After=3Dnetwork-pre.target
 Before=3Dnetwork.target
 Wants=3Dnetwork.target
 =

-- =

2.29.2
--===============1260547855423932575==--

