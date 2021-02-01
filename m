Content-Type: multipart/mixed; boundary="===============9221732956940862317=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] doc: document SSID property on AP interface
Date: Mon, 01 Feb 2021 14:05:17 -0800
Message-ID: <20210201220518.36975-4-prestwoj@gmail.com>
In-Reply-To: <20210201220518.36975-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9221732956940862317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/access-point-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 9682b3c7..27f4e244 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -40,3 +40,8 @@ Methods		void Start(string ssid, string psk)
 Properties	boolean Started [readonly]
 =

 			Reflects whether an access point has been started.
+
+		string SSID [readonly]
+
+			The SSID being broadcast for a started AP. This will be
+			an empty string prior to the AP being started.
-- =

2.26.2

--===============9221732956940862317==--

