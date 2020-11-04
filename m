Content-Type: multipart/mixed; boundary="===============4765413722105347050=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] doc: document AP StartProfile
Date: Wed, 04 Nov 2020 08:52:25 -0800
Message-ID: <20201104165227.2782516-2-prestwoj@gmail.com>
In-Reply-To: <20201104165227.2782516-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4765413722105347050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/access-point-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 9ee06baa..9682b3c7 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -25,6 +25,18 @@ Methods		void Start(string ssid, string psk)
 						net.connman.iwd.Failed
 						net.connman.iwd.InvalidArguments
 =

+		void StartProfile(string ssid)
+
+			Start a profile based access point. A profile must exist
+			in IWD's AP configuration directory (/var/lib/iwd/ap/
+			by default) of the name <ssid>.ap.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.Failed
+						net.connman.iwd.InvalidArguments
+						net.connman.iwd.AlreadyExists
+						net.connman.iwd.NotFound
+
 Properties	boolean Started [readonly]
 =

 			Reflects whether an access point has been started.
-- =

2.26.2

--===============4765413722105347050==--

