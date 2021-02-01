Content-Type: multipart/mixed; boundary="===============0936517068733964105=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] doc: document Name property on AP interface
Date: Mon, 01 Feb 2021 15:52:15 -0800
Message-ID: <20210201235217.46602-2-prestwoj@gmail.com>
In-Reply-To: <20210201235217.46602-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0936517068733964105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/access-point-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 9682b3c7..68ba23c5 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -40,3 +40,8 @@ Methods		void Start(string ssid, string psk)
 Properties	boolean Started [readonly]
 =

 			Reflects whether an access point has been started.
+
+		string Name [readonly, optional]
+
+			The SSID being broadcast for a started AP (omitted if
+			AP has not been started)
-- =

2.26.2

--===============0936517068733964105==--

