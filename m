Content-Type: multipart/mixed; boundary="===============3361020258962595607=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] adhoc: print handshake failure reason
Date: Mon, 14 Sep 2020 14:04:03 -0700
Message-ID: <20200914210407.428918-3-prestwoj@gmail.com>
In-Reply-To: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3361020258962595607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/adhoc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index 3050ce27..9f3b32e7 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -179,10 +179,15 @@ static void adhoc_handshake_event(struct handshake_st=
ate *hs,
 {
 	struct sta_state *sta =3D user_data;
 	struct adhoc_state *adhoc =3D sta->adhoc;
+	va_list args;
+
+	va_start(args, user_data);
 =

 	switch (event) {
 	case HANDSHAKE_EVENT_FAILED:
-		l_error("handshake failed with STA "MAC, MAC_STR(sta->addr));
+		l_error("handshake failed with STA "MAC" (%d)",
+						MAC_STR(sta->addr),
+						va_arg(args, int));
 =

 		/*
 		 * eapol frees the state machines upon handshake failure. Since
-- =

2.26.2

--===============3361020258962595607==--

