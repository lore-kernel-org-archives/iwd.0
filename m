Content-Type: multipart/mixed; boundary="===============0946344755586714611=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] netdev: use NL80211_STA_INFO_SIGNAL rather than average
Date: Wed, 10 Mar 2021 12:27:41 -0800
Message-ID: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0946344755586714611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since GET_STATION (and in turn GetDiagnostics) gets the most
current station info this attribute serves as a better indication
of the current signal strength. In addition full mac cards don't
appear to always have the average attribute.
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1f2aa51c..e0779de5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -443,7 +443,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *a=
ttr,
 =

 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		switch (type) {
-		case NL80211_STA_INFO_SIGNAL_AVG:
+		case NL80211_STA_INFO_SIGNAL:
 			if (len !=3D 1)
 				return false;
 =

-- =

2.26.2

--===============0946344755586714611==--

