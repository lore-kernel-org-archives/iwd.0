Content-Type: multipart/mixed; boundary="===============3320747631869132611=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] eapol: notify with EAP complete handshake event
Date: Thu, 08 Apr 2021 08:46:43 -0700
Message-ID: <20210408154646.1182833-2-prestwoj@gmail.com>
In-Reply-To: <20210408154646.1182833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3320747631869132611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eapol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/eapol.c b/src/eapol.c
index 23aaf530..c4a73282 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2162,7 +2162,8 @@ static void eapol_eap_complete_cb(enum eap_result res=
ult, void *user_data)
 		sm->eap =3D NULL;
 		handshake_failed(sm, MMPDU_REASON_CODE_IEEE8021X_FAILED);
 		return;
-	}
+	} else
+		handshake_event(sm->handshake, HANDSHAKE_EVENT_EAP_COMPLETE);
 =

 	eap_reset(sm->eap);
 =

-- =

2.26.2

--===============3320747631869132611==--

