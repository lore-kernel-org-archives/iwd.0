Content-Type: multipart/mixed; boundary="===============3021191293869023914=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] ft: netdev: add return value to tx_associate
Date: Thu, 15 Apr 2021 15:45:08 -0700
Message-ID: <20210415224508.1823614-8-prestwoj@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3021191293869023914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prior to this, an error sending the FT Reassociation was treated
as fatal, which is correct for FT-over-Air but not for FT-over-DS.
If the actual l_genl_family_send call fails for FT-over-DS the
existing connection can be maintained and there is no need to
call netdev_connect_failed.

Adding a return to the tx_associate function works for both FT
types. In the FT-over-Air case this return will ultimately get
sent back up to auth_proto_rx_authenticate in which case will
call netdev_connect_failed. For FT-over-DS tx_associate is
actually called from the 'start' operation which can fail and
still maintain the existing connection.
---
 src/ft.c     | 4 +---
 src/ft.h     | 2 +-
 src/netdev.c | 8 ++++----
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index d1aaada7..793e3724 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -290,9 +290,7 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		iov_elems +=3D 1;
 	}
 =

-	ft->tx_assoc(iov, iov_elems, ft->user_data);
-
-	return 0;
+	return ft->tx_assoc(iov, iov_elems, ft->user_data);
 =

 error:
 	return -EINVAL;
diff --git a/src/ft.h b/src/ft.h
index 2dd806f2..72237a4e 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -26,7 +26,7 @@ struct handshake_state;
 =

 typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_le=
n,
 					void *user_data);
-typedef void (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_le=
n,
+typedef int (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_len,
 					void *user_data);
 =

 bool ft_build_authenticate_ies(struct handshake_state *hs,
diff --git a/src/netdev.c b/src/netdev.c
index 95fa6909..6495451f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3524,7 +3524,7 @@ restore_snonce:
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 =

-static void netdev_ft_tx_associate(struct iovec *ie_iov, size_t iov_len,
+static int netdev_ft_tx_associate(struct iovec *ie_iov, size_t iov_len,
 					void *user_data)
 {
 	struct netdev *netdev =3D user_data;
@@ -3542,10 +3542,10 @@ static void netdev_ft_tx_associate(struct iovec *ie=
_iov, size_t iov_len,
 	if (!netdev->connect_cmd_id) {
 		l_genl_msg_unref(msg);
 =

-		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-		return;
+		return -EIO;
 	}
+
+	return 0;
 }
 =

 static void prepare_ft(struct netdev *netdev, struct scan_bss *target_bss)
-- =

2.26.2

--===============3021191293869023914==--

