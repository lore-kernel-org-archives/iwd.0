Content-Type: multipart/mixed; boundary="===============6014732146546864262=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] adhoc: fix missing call to va_end
Date: Mon, 08 Feb 2021 13:07:25 -0800
Message-ID: <20210208210725.611632-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6014732146546864262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since only one switch case uses this, va_start/end were just
moved into that case specifically.
---
 src/adhoc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index 7f9ce765..506e596a 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -186,14 +186,15 @@ static void adhoc_handshake_event(struct handshake_st=
ate *hs,
 	struct adhoc_state *adhoc =3D sta->adhoc;
 	va_list args;
 =

-	va_start(args, user_data);
-
 	switch (event) {
 	case HANDSHAKE_EVENT_FAILED:
+		va_start(args, user_data);
+
 		l_error("handshake failed with STA "MAC" (%d)",
 						MAC_STR(sta->addr),
 						va_arg(args, int));
 =

+		va_end(args);
 		/*
 		 * eapol frees the state machines upon handshake failure. Since
 		 * this is only a failure on one of the handshakes we need to
-- =

2.26.2

--===============6014732146546864262==--

