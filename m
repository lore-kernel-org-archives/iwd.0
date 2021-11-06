Content-Type: multipart/mixed; boundary="===============4836667895715555517=="
MIME-Version: 1.0
From: Torsten Schmitz <noreply.torsten at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: Prevent a NULL pointer access
Date: Sat, 06 Nov 2021 03:36:51 +0100
Message-ID: <20211106023651.15224-1-noreply.torsten@gmail.com>

--===============4836667895715555517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is an unchecked NULL pointer access in network_has_open_pair.
open_info can definitely be NULL, I have the coredumps to prove it.
Let's check owe_info too though.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index 19f2aaeb..75ec36df 100644
--- a/src/station.c
+++ b/src/station.c
@@ -693,11 +693,17 @@ static bool network_has_open_pair(struct network *net=
work, struct scan_bss *owe)
 	const struct l_queue_entry *entry;
 	struct ie_owe_transition_info *owe_info =3D owe->owe_trans;
 =

+	if (!owe_info)
+		return false;
+
 	for (entry =3D network_bss_list_get_entries(network); entry;
 				entry =3D entry->next) {
 		struct scan_bss *open =3D entry->data;
 		struct ie_owe_transition_info *open_info =3D open->owe_trans;
 =

+		if (!open_info)
+			continue;
+
 		/*
 		 * Check if this is an Open/Hidden pair:
 		 *
-- =

2.33.1

--===============4836667895715555517==--

