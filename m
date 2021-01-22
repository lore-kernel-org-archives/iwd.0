Content-Type: multipart/mixed; boundary="===============2286873296618138885=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH v2] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 14:41:23 +0000
Message-ID: <20210122144121.613727-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2286873296618138885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

systemd specifies a special passive target unit 'network-pre.target'
which may be pulled in by services that want to run before any network
interface is brought up or configured. Correspondingly, network
management services such as iwd and ead should specify
After=3Dnetwork-pre.target to ensure a proper ordering with respect to
this special target. For more information on network-pre.target, see
systemd.special(7).

Two examples to explain the rationale of this change:

1. On one of our embedded systems running iwd, a oneshot service is
   run on startup to configure - among other things - the MAC address of
   the wireless network interface based on some data in an EEPROM.
   Following the systemd documentation, the oneshot service specifies:

        Before=3Dnetwork-pre.target
        Wants=3Dnetwork-pre.target

   ... to ensure that it is run before any network management software
   starts. In practice, before this change, iwd was starting up and
   connecting to an AP before the service had finished. iwd would then
   get kicked off by the AP when the MAC address got changed. By
   specifying After=3Dnetwork-pre.target, systemd will take care to avoid
   this situation.

2. An administrator may wish to use network-pre.target to ensure
   firewall rules are applied before any network management software is
   started. This use-case is described in the systemd documentation[1].
   Since iwd can be used for IP configuration, it should also respect
   the After=3Dnetwork-pre.target convention.

Note that network-pre.target is a passive unit that is only pulled in if
another unit specifies e.g. Wants=3Dnetwork-pre.target. If no such unit
exists, this change will have no effect on the order in which systemd
starts iwd or ead.

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
--===============2286873296618138885==--

