Content-Type: multipart/mixed; boundary="===============7490603849504985955=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] sae: fix a few spec violations regarding dropped frames
Date: Tue, 07 Sep 2021 14:14:48 -0700
Message-ID: <20210907211450.27270-7-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7490603849504985955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were two places where SAE returned a fatal error code rather
than silently drop the frame as the spec requires. These two cases
return -EAGAIN which ultimately drops the frame in netdev.
---
 src/sae.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 62fd6c88..fbd0298d 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -678,7 +678,7 @@ static int sae_process_commit(struct sae_sm *sm, const =
uint8_t *from,
 	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
 			l_ecc_points_are_equal(sm->p_element, sm->element)) {
 		l_warn("peer scalar or element matched own, discarding frame");
-		return -ENOMSG;
+		return -EAGAIN;
 	}
 =

 	sm->sc++;
@@ -1185,7 +1185,7 @@ static int sae_verify_accepted(struct sae_sm *sm, uin=
t16_t trans,
 	/* spec does not specify what to do here, so print and discard */
 	if (trans !=3D SAE_STATE_CONFIRMED) {
 		l_error("received transaction %u in accepted state", trans);
-		return -EBADMSG;
+		return -EAGAIN;
 	}
 =

 	if (sm->sync > SAE_SYNC_MAX)
-- =

2.31.1

--===============7490603849504985955==--

