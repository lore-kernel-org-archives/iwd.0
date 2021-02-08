Content-Type: multipart/mixed; boundary="===============6219306178168647386=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] adhoc: fix missing call to va_end
Date: Mon, 08 Feb 2021 12:19:56 -0800
Message-ID: <20210208201958.607049-3-prestwoj@gmail.com>
In-Reply-To: <20210208201958.607049-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6219306178168647386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/adhoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/adhoc.c b/src/adhoc.c
index 7f9ce765..1263d00a 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -228,6 +228,8 @@ static void adhoc_handshake_event(struct handshake_stat=
e *hs,
 	default:
 		break;
 	}
+
+	va_end(args);
 }
 =

 static struct eapol_sm *adhoc_new_sm(struct sta_state *sta, bool authentic=
ator,
-- =

2.26.2

--===============6219306178168647386==--

