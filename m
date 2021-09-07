Content-Type: multipart/mixed; boundary="===============3303907622314620578=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] sae: print state and transaction on received packets
Date: Tue, 07 Sep 2021 14:14:47 -0700
Message-ID: <20210907211450.27270-6-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3303907622314620578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will make SAE a bit easier to debug in the future.
---
 src/sae.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/sae.c b/src/sae.c
index 6b282e8e..62fd6c88 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1226,10 +1226,28 @@ static int sae_verify_accepted(struct sae_sm *sm, u=
int16_t trans,
 	return -EAGAIN;
 }
 =

+static const char *sae_state_to_str(enum sae_state state)
+{
+	switch (state) {
+	case SAE_STATE_NOTHING:
+		return "nothing";
+	case SAE_STATE_COMMITTED:
+		return "committed";
+	case SAE_STATE_CONFIRMED:
+		return "confirmed";
+	case SAE_STATE_ACCEPTED:
+		return "accepted";
+	}
+
+	return "unknown";
+}
+
 static int sae_verify_packet(struct sae_sm *sm, uint16_t trans,
 				uint16_t status, const uint8_t *frame,
 				size_t len)
 {
+	l_debug("rx trans=3D%u, state=3D%s", trans, sae_state_to_str(sm->state));
+
 	if (trans !=3D SAE_STATE_COMMITTED && trans !=3D SAE_STATE_CONFIRMED)
 		return -EBADMSG;
 =

-- =

2.31.1

--===============3303907622314620578==--

