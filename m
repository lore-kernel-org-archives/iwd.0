Content-Type: multipart/mixed; boundary="===============7208973806338287091=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] sae: fix incorrect length adjustment
Date: Mon, 21 Oct 2019 14:59:17 -0700
Message-ID: <20191021215917.12691-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7208973806338287091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The commit/confirm processing was incorrectly subtracting 2 from
the length when they should be subtracting 6. As with the other
similar change, the length is validated with mpdu_validate so
subtracting 6 will not cause an overflow.
---
 src/sae.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 327277eb..a17c2883 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1037,10 +1037,10 @@ static int sae_rx_authenticate(struct auth_proto *a=
p,
 	switch (L_LE16_TO_CPU(auth->transaction_sequence)) {
 	case SAE_STATE_COMMITTED:
 		return sae_process_commit(sm, hdr->address_2, auth->ies,
-						len - 2);
+						len - 6);
 	case SAE_STATE_CONFIRMED:
 		return sae_process_confirm(sm, hdr->address_2, auth->ies,
-						len - 2);
+						len - 6);
 	default:
 		l_error("invalid transaction sequence %u",
 				L_LE16_TO_CPU(auth->transaction_sequence));
-- =

2.17.1

--===============7208973806338287091==--

