Content-Type: multipart/mixed; boundary="===============8210196292542704409=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/9] ft: netdev: store FT-over-DS target RSNE/WPA
Date: Tue, 28 Sep 2021 14:27:39 -0700
Message-ID: <20210928212744.717276-4-prestwoj@gmail.com>
In-Reply-To: 20210928212744.717276-1-prestwoj@gmail.com

--===============8210196292542704409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Keep track of the target BSS's authenticator IE for verification.
It should not be assumed that the target BSS and original RSNE/WPA
IE matches.
---
 src/ft.c     |  3 +++
 src/ft.h     |  1 +
 src/netdev.c | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index db09aacf..fecb4c0e 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -616,6 +616,9 @@ void ft_ds_info_free(struct ft_ds_info *info)
 	if (info->fte)
 		l_free(info->fte);
 =

+	if (info->authenticator_ie)
+		l_free(info->authenticator_ie);
+
 	if (destroy)
 		destroy(info);
 }
diff --git a/src/ft.h b/src/ft.h
index a2fa8946..f90fc1b2 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -36,6 +36,7 @@ struct ft_ds_info {
 	uint8_t snonce[32];
 	uint8_t mde[3];
 	uint8_t *fte;
+	uint8_t *authenticator_ie;
 =

 	struct ie_ft_info ft_info;
 =

diff --git a/src/netdev.c b/src/netdev.c
index bedc8377..603c339d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4375,6 +4375,7 @@ int netdev_fast_transition_over_ds_action(struct netd=
ev *netdev,
 	struct iovec iovs[5];
 	uint8_t buf[512];
 	size_t len;
+	const uint8_t *ap_ie =3D NULL;
 =

 	if (!netdev->operational)
 		return -ENOTCONN;
@@ -4392,6 +4393,15 @@ int netdev_fast_transition_over_ds_action(struct net=
dev *netdev,
 	memcpy(info->super.spa, hs->spa, ETH_ALEN);
 	memcpy(info->super.aa, target_bss->addr, ETH_ALEN);
 	memcpy(info->super.mde, target_bss->mde, sizeof(info->super.mde));
+
+	if (target_bss->rsne)
+		ap_ie =3D target_bss->rsne;
+	else if (target_bss->wpa)
+		ap_ie =3D target_bss->wpa;
+
+	if (ap_ie)
+		info->super.authenticator_ie =3D l_memdup(ap_ie, ap_ie[1] + 2);
+
 	l_getrandom(info->super.snonce, 32);
 	info->super.free =3D netdev_ft_ds_info_free;
 =

-- =

2.31.1

--===============8210196292542704409==--

