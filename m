Content-Type: multipart/mixed; boundary="===============5936666631800012563=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/8] dpp: set new_freq when configuring as initiator
Date: Tue, 22 Mar 2022 15:51:12 -0700
Message-ID: <20220322225113.1023688-7-prestwoj@gmail.com>
In-Reply-To: 20220322225113.1023688-1-prestwoj@gmail.com

--===============5936666631800012563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is used to hold the current BSS frequency which will be
used after IWD receives a presence announcement. Since this was
not being set, the logic was always thinking there was a channel
mismatch (0 !=3D current_freq) and attempting to go offchannel to
'0' which resulted in -EINVAL, and ultimately protocol termination.
---
 src/dpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index de8e6e14..1719a89d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -2436,6 +2436,8 @@ static struct l_dbus_message *dpp_start_configurator_=
common(
 =

 		if (!dpp->mcast_support)
 			dpp->state =3D DPP_STATE_AUTHENTICATING;
+
+		dpp->new_freq =3D bss->frequency;
 	} else
 		dpp->current_freq =3D bss->frequency;
 =

-- =

2.34.1

--===============5936666631800012563==--

