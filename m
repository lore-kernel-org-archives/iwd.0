Content-Type: multipart/mixed; boundary="===============6740866049382540328=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] dpp: unref DPP frame if sending fails
Date: Fri, 07 Jan 2022 09:58:48 -0800
Message-ID: <20220107175849.693241-1-prestwoj@gmail.com>

--===============6740866049382540328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 54947193..f62bcebb 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -219,8 +219,10 @@ static void dpp_send_frame(uint64_t wdev_id, struct io=
vec *iov, size_t iov_len,
 =

 	l_debug("Sending frame on frequency %u", freq);
 =

-	if (!l_genl_family_send(nl80211, msg, dpp_send_frame_cb, NULL, NULL))
+	if (!l_genl_family_send(nl80211, msg, dpp_send_frame_cb, NULL, NULL)) {
 		l_error("Could not send CMD_FRAME");
+		l_genl_msg_unref(msg);
+	}
 }
 =

 static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
-- =

2.31.1

--===============6740866049382540328==--

