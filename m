Content-Type: multipart/mixed; boundary="===============1774425411153741769=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] ft: netdev: add return value to tx_associate
Date: Thu, 29 Apr 2021 12:41:03 -0700
Message-ID: <20210429194103.207447-6-prestwoj@gmail.com>
In-Reply-To: <20210429194103.207447-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1774425411153741769==
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
index 56858ee1..f6ea1425 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -287,9 +287,7 @@ static int ft_tx_reassociate(struct ft_sm *ft)
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
index 7c009f16..3d1cfe30 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -24,7 +24,7 @@ struct handshake_state;
 =

 typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_le=
n,
 					void *user_data);
-typedef void (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_le=
n,
+typedef int (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_len,
 					void *user_data);
 =

 typedef void (*ft_ds_free_func_t)(void *user_data);
diff --git a/src/netdev.c b/src/netdev.c
index 69fb7174..015a5237 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3643,7 +3643,7 @@ restore_snonce:
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 =

-static void netdev_ft_tx_associate(struct iovec *ie_iov, size_t iov_len,
+static int netdev_ft_tx_associate(struct iovec *ie_iov, size_t iov_len,
 					void *user_data)
 {
 	struct netdev *netdev =3D user_data;
@@ -3661,10 +3661,10 @@ static void netdev_ft_tx_associate(struct iovec *ie=
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

--===============1774425411153741769==--

