Content-Type: multipart/mixed; boundary="===============0421545095551906279=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] sae: don't send commit in confirmed state
Date: Tue, 07 Sep 2021 14:14:49 -0700
Message-ID: <20210907211450.27270-8-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0421545095551906279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This works around a hostapd bug (described more in the TODO comment)
that deaths IWD if the initial commit is not acked. This behavior
has been identified in consumer access points and likely won't ever
be patched for older devices. Because of this IWD must work around
the problem which can be eliminated by not sending out this commit
message.
---
 src/sae.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/sae.c b/src/sae.c
index fbd0298d..4eda9225 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1165,7 +1165,18 @@ static int sae_verify_confirmed(struct sae_sm *sm, u=
int16_t trans,
 	sm->sync++;
 	sm->sc++;
 =

-	sae_send_commit(sm, true);
+	/*
+	 * TODO: There is a bug in hostapd which deaths stations if a commit
+	 * is received in an Accepted SAE state. This can be triggered if the
+	 * STA's commit is not acked, which triggers a re-transmission, and
+	 * ultimated causes the AP to death IWD.
+	 *
+	 * Since this bug is present in production APs out in the wild we must
+	 * work around it by going against the spec (802.11-2020 12.4.8.6.5) and
+	 * only send a confirm here.
+	 *
+	 * sae_send_commit(sm, true);
+	 */
 =

 	if (!sae_send_confirm(sm))
 		return -EPROTO;
-- =

2.31.1

--===============0421545095551906279==--

