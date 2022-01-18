Content-Type: multipart/mixed; boundary="===============7119943481901219261=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 06/12] frame-xchg: set allow multicast flag
Date: Tue, 18 Jan 2022 13:25:06 -0800
Message-ID: <20220118212512.2017977-6-prestwoj@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============7119943481901219261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Receiving multicast frames is required by DPP
---
 src/frame-xchg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 5ba36081..95c030d8 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -611,6 +611,7 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group_i=
d, uint16_t frame_type,
 =

 	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_RECEIVE_MULTICAST, 0, NULL);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
 				prefix_len, prefix);
 =

-- =

2.31.1

--===============7119943481901219261==--

