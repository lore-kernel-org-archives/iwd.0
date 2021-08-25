Content-Type: multipart/mixed; boundary="===============3486406471606125371=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/5] sae: add sae_sm_set_force_group_19
Date: Wed, 25 Aug 2021 10:12:56 -0700
Message-ID: <20210825171258.764596-3-prestwoj@gmail.com>
In-Reply-To: <20210825171258.764596-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3486406471606125371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setter which forces the use of group 19 rather than the group order
that ELL provides. Certain APs have been found to have buggy group
negotiation and only work if group 19 is tried first, and only. When
an AP like this this is found (based on vendor OUI match) SAE will
use group 19 unconditionally, and fail if group 19 does not work.
Other groups could be tried upon failure but per the spec group 19
must be supported so there isn't much use in trying other, optional
groups.
---
 src/sae.c | 29 +++++++++++++++++++++++++++++
 src/sae.h |  2 ++
 2 files changed, 31 insertions(+)

v3:
 * Use a setter rather than passing in scan_bss

diff --git a/src/sae.c b/src/sae.c
index 5099473c..6b282e8e 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -83,6 +83,8 @@ struct sae_sm {
 	sae_tx_associate_func_t tx_assoc;
 	void *user_data;
 	enum crypto_sae sae_type;
+
+	bool force_default_group : 1;
 };
 =

 static enum mmpdu_status_code sae_status_code(struct sae_sm *sm)
@@ -139,6 +141,24 @@ static int sae_choose_next_group(struct sae_sm *sm)
 	const unsigned int *ecc_groups =3D l_ecc_supported_ike_groups();
 	bool reset =3D sm->group_retry >=3D 0;
 =

+	/*
+	 * If this is a buggy AP in which group negotiation is broken use the
+	 * default group 19 and fail if this is a retry.
+	 */
+	if (sm->sae_type =3D=3D CRYPTO_SAE_LOOPING && sm->force_default_group) {
+		if (sm->group_retry !=3D -1) {
+			l_warn("Forced default group but was rejected!");
+			return -ENOENT;
+		}
+
+		l_debug("Forcing default SAE group 19");
+
+		sm->group_retry++;
+		sm->group =3D 19;
+
+		goto get_curve;
+	}
+
 	do {
 		sm->group_retry++;
 =

@@ -151,6 +171,8 @@ static int sae_choose_next_group(struct sae_sm *sm)
 		sae_reset_state(sm);
 =

 	sm->group =3D ecc_groups[sm->group_retry];
+
+get_curve:
 	sm->curve =3D l_ecc_curve_from_ike_group(sm->group);
 =

 	return 0;
@@ -1298,6 +1320,13 @@ bool sae_sm_is_h2e(struct auth_proto *ap)
 	return sm->sae_type !=3D CRYPTO_SAE_LOOPING;
 }
 =

+void sae_sm_set_force_group_19(struct auth_proto *ap)
+{
+	struct sae_sm *sm =3D l_container_of(ap, struct sae_sm, ap);
+
+	sm->force_default_group =3D true;
+}
+
 static void sae_free(struct auth_proto *ap)
 {
 	struct sae_sm *sm =3D l_container_of(ap, struct sae_sm, ap);
diff --git a/src/sae.h b/src/sae.h
index 668d084f..ec29e624 100644
--- a/src/sae.h
+++ b/src/sae.h
@@ -30,6 +30,8 @@ typedef void (*sae_tx_associate_func_t)(void *user_data);
 =

 bool sae_sm_is_h2e(struct auth_proto *ap);
 =

+void sae_sm_set_force_group_19(struct auth_proto *ap);
+
 struct auth_proto *sae_sm_new(struct handshake_state *hs,
 				sae_tx_authenticate_func_t tx_auth,
 				sae_tx_associate_func_t tx_assoc,
-- =

2.31.1

--===============3486406471606125371==--

