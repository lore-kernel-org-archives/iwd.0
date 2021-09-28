Content-Type: multipart/mixed; boundary="===============4919937309195359039=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/6] doc: add testing option to hostapd.config
Date: Tue, 28 Sep 2021 15:36:04 -0700
Message-ID: <20210928223609.1163537-1-prestwoj@gmail.com>

--===============4919937309195359039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is required to be built in for hostapd to rekey on command.
---
 doc/hostapd.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/hostapd.config b/doc/hostapd.config
index 91d1b4cf..c114e127 100644
--- a/doc/hostapd.config
+++ b/doc/hostapd.config
@@ -36,3 +36,4 @@ CONFIG_OCV=3Dy
 CONFIG_OWE=3Dy
 CONFIG_DPP=3Dy
 CONFIG_SAE=3Dy
+CONFIG_TESTING_OPTIONS=3Dy
-- =

2.31.1

--===============4919937309195359039==--

