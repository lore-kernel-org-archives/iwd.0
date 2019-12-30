Content-Type: multipart/mixed; boundary="===============8422401661342960338=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] doc: add CONFIG_DRIVER_NONE to hostapd config
Date: Mon, 30 Dec 2019 10:09:50 -0800
Message-ID: <20191230180954.12644-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8422401661342960338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows hostapd to be started as a standalone radius server
---
 doc/hostapd.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/hostapd.config b/doc/hostapd.config
index cf88386e..2ad99b8a 100644
--- a/doc/hostapd.config
+++ b/doc/hostapd.config
@@ -1,5 +1,6 @@
 CONFIG_DRIVER_HOSTAP=3Dy
 CONFIG_DRIVER_NL80211=3Dy
+CONFIG_DRIVER_NONE=3Dy
 CONFIG_LIBNL32=3Dy
 CONFIG_IAPP=3Dy
 CONFIG_RSN_PREAUTH=3Dy
-- =

2.17.1

--===============8422401661342960338==--

