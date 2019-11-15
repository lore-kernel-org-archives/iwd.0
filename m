Content-Type: multipart/mixed; boundary="===============8970235571230117692=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/7] monitor: print parent TSF
Date: Fri, 15 Nov 2019 10:39:24 -0800
Message-ID: <20191115183926.1887-5-prestwoj@gmail.com>
In-Reply-To: <20191115183926.1887-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8970235571230117692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 4053879f..94d16979 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -4569,6 +4569,7 @@ static const struct attr_entry bss_table[] =3D {
 	{ NL80211_BSS_CHAN_WIDTH,	"Chan Width",	ATTR_U32	},
 	{ NL80211_BSS_BEACON_TSF,	"Beacon TSF",	ATTR_U64	},
 	{ NL80211_BSS_PRESP_DATA,	"Probe Response", ATTR_FLAG	},
+	{ NL80211_BSS_PARENT_TSF,	"Parent TSF",	ATTR_U64	},
 	{ }
 };
 =

-- =

2.17.1

--===============8970235571230117692==--

