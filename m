Content-Type: multipart/mixed; boundary="===============4647705309667807251=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] knownnetworks: copy network_config on update
Date: Thu, 29 Jul 2021 15:21:46 -0700
Message-ID: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4647705309667807251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The network_config was not being copied to network_info when
updated. This caused any new settings to be lost if the network
configuration file was updated during runtime.
---
 src/knownnetworks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 09acdd3c..85648ead 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -464,6 +464,8 @@ void known_network_update(struct network_info *network,
 	}
 =

 	known_network_set_autoconnect(network, new->is_autoconnectable);
+
+	memcpy(&network->config, new, sizeof(struct network_config));
 }
 =

 bool known_networks_foreach(known_networks_foreach_func_t function,
-- =

2.31.1

--===============4647705309667807251==--

