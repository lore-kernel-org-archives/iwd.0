Content-Type: multipart/mixed; boundary="===============6402972455684527614=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] eapol: reorder eapol_sm_free
Date: Wed, 16 Oct 2019 16:43:02 -0700
Message-ID: <20191016234304.14716-2-prestwoj@gmail.com>
In-Reply-To: <20191016234304.14716-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6402972455684527614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was reported by coverity as a use after free. Technically it is
correct, though this will not pose a problem since l_queue_remove will
not actually dereference the pointer. Reordering this should fix the
warning and not change behavior at all.
---
 src/eapol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 6732b370..cbaf0f4f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -886,9 +886,9 @@ struct eapol_sm *eapol_sm_new(struct handshake_state *h=
s)
 =

 void eapol_sm_free(struct eapol_sm *sm)
 {
-	eapol_sm_destroy(sm);
-
 	l_queue_remove(state_machines, sm);
+
+	eapol_sm_destroy(sm);
 }
 =

 void eapol_sm_set_listen_interval(struct eapol_sm *sm, uint16_t interval)
-- =

2.17.1

--===============6402972455684527614==--

