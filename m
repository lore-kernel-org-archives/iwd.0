Content-Type: multipart/mixed; boundary="===============8839134108652711959=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] netdev: move prepare_ft call which broke FT
Date: Thu, 22 Apr 2021 10:37:46 -0700
Message-ID: <20210422173746.2324850-7-prestwoj@gmail.com>
In-Reply-To: <20210422173746.2324850-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8839134108652711959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The prepare_ft patch was an intermediate to a full patch
set and was not fully tested stand alone. Its placement
actually broke FT due to handshake->aa getting overwritten
prior to netdev->prev_bssid being copied out. This caused
FT to fail with "transport endpoint not connected (-107)"
---
 src/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 28076244..1190399d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3789,6 +3789,8 @@ static int fast_transition(struct netdev *netdev, str=
uct scan_bss *target_bss,
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 =

+	prepare_ft(netdev, target_bss);
+
 	/*
 	 * We reuse the handshake_state object and reset what's needed.
 	 * Could also create a new object and copy most of the state but
@@ -3805,8 +3807,6 @@ static int fast_transition(struct netdev *netdev, str=
uct scan_bss *target_bss,
 							target_bss->rsne);
 	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
 =

-	prepare_ft(netdev, target_bss);
-
 	netdev->connect_cb =3D cb;
 =

 	if (over_air)
-- =

2.26.2

--===============8839134108652711959==--

