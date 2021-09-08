Content-Type: multipart/mixed; boundary="===============8054939128606606423=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] sae: don't send commit/confirm in confirmed state
Date: Wed, 08 Sep 2021 13:48:02 -0700
Message-ID: <20210908204805.92005-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8054939128606606423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This works around a hostapd bug (described more in the TODO comment)
which is exposed because of the kernels overly agressive re-transmit
behavior on missed ACKs. Combined this results in a death if the
initial commit is not acked. This behavior has been identified in
consumer access points and likely won't ever be patched for older
devices. Because of this IWD must work around the problem which can
be eliminated by not sending out this commit message.

This bug was reported to the hostapd ML:

https://lists.infradead.org/pipermail/hostap/2021-September/039842.html

This change should not cause any compatibility problems to non-hostapd
access points and is identical to how wpa_supplicant treats this
scenario.
---
 src/sae.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

v3:
 * Kept existing behavior for non-STA handshakes
 * Better described the sequence of events that requires this workaround

diff --git a/src/sae.c b/src/sae.c
index c14b646f..ccba74cc 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1158,6 +1158,31 @@ static int sae_verify_confirmed(struct sae_sm *sm, u=
int16_t trans,
 	if (l_get_le16(frame) !=3D sm->group)
 		return -EBADMSG;
 =

+	/*
+	 * Because of kernel retransmit behavior on missed ACKs plus hostapd's
+	 * incorrect handling of confirm packets while in accepted state the
+	 * following can happen:
+	 *
+	 * 1. Client sends commit, not acked (committed state)
+	 * 2. AP receives commit, sends commit reply (committed state)
+	 * 3. Client retransmits original commit
+	 * 4. Client receives AP's commit, sends confirm (confirmed state)
+	 * 5. AP receives clients retransmitted commit, sends only commit
+	 * 6. AP receives clients confirm and accepts (accepted state)
+	 * 7. Client receives AP's commit and sends both commit + confirm
+	 *    (the code below).
+	 * 8. AP receives clients commit while in accepted state, and deauths
+	 *
+	 * Due to this, any commit received while in a confirmed state will be
+	 * ignored by IWD since it is probably caused by this retransmission
+	 * and sending the commit/confirm below would likely cause hostapd to
+	 * deauth us.
+	 *
+	 * As for non-sta (currently not used) we want to keep with the spec.
+	 */
+	if (!sm->handshake->authenticator)
+		return -EBADMSG;
+
 	/*
 	 * the protocol instance shall increment Sync, increment Sc, and
 	 * transmit its Commit and Confirm (with the new Sc value) messages.
@@ -1170,7 +1195,7 @@ static int sae_verify_confirmed(struct sae_sm *sm, ui=
nt16_t trans,
 	if (!sae_send_confirm(sm))
 		return -EPROTO;
 =

-	return -EAGAIN;
+	return -EBADMSG;
 }
 =

 /*
-- =

2.31.1

--===============8054939128606606423==--

