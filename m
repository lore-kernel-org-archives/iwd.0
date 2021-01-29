Content-Type: multipart/mixed; boundary="===============4189129192274437433=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] knownnetworks: sanitize known_network.freq on load
Date: Fri, 29 Jan 2021 15:07:57 -0800
Message-ID: <20210129230757.126357-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4189129192274437433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An invalid known_network.freq file containing several UUID
groups which have the same 'name' key results in memory leaks
in IWD. This is because the file is loaded and the group's
are iterated without detecting duplicates. This leads to the
same network_info's known_frequencies being set/overridden
multiple times.

To fix this we just check if the network_info already has a
UUID set. If so remove the stale entry.
---
 src/knownnetworks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 53cfc30f..32beae84 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -916,6 +916,11 @@ static int known_network_frequencies_load(void)
 		if (!info)
 			continue;
 =

+		if (info->has_uuid) {
+			l_settings_remove_group(known_freqs, groups[i]);
+			continue;
+		}
+
 		freq_list =3D l_settings_get_string(known_freqs, groups[i],
 							"list");
 		if (!freq_list)
-- =

2.26.2

--===============4189129192274437433==--

