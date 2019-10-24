Content-Type: multipart/mixed; boundary="===============6330354736781165019=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8] nl80211util: Fail in nl80211_parse_attrs if attribute
 missing
Date: Thu, 24 Oct 2019 06:29:57 +0200
Message-ID: <20191024043000.13687-5-andrew.zaborowski@intel.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6330354736781165019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The users of this function expect an error return value if any of the
attributes wanted was not present in the message.
---
 src/nl80211util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index cac4de09..df895a77 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -162,9 +162,12 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int ta=
g, ...)
 			ret =3D -EINVAL;
 			goto done;
 		}
+
+		l_queue_remove(entries, entry);
+		l_free(entry);
 	}
 =

-	ret =3D 0;
+	ret =3D l_queue_isempty(entries) ? 0 : -ENOENT;
 =

 done:
 	l_queue_destroy(entries, l_free);
-- =

2.20.1

--===============6330354736781165019==--

