Content-Type: multipart/mixed; boundary="===============8268650490867137100=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] adhoc: start both eapol SM's
Date: Mon, 14 Sep 2020 14:04:02 -0700
Message-ID: <20200914210407.428918-2-prestwoj@gmail.com>
In-Reply-To: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8268650490867137100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At some point in the past starting only one SM worked. But now it does
not. Both SM's need to be started for EAPoL to work properly and kick
off both sets of handshakes.
---
 src/adhoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/adhoc.c b/src/adhoc.c
index ceec2dea..3050ce27 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -302,6 +302,7 @@ static void adhoc_start_rsna(struct sta_state *sta, con=
st uint8_t *gtk_rsc)
 	eapol_register(sta->sm_a);
 =

 	eapol_start(sta->sm);
+	eapol_start(sta->sm_a);
 =

 	return;
 =

-- =

2.26.2

--===============8268650490867137100==--

