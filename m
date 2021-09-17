Content-Type: multipart/mixed; boundary="===============0727148978852057052=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 2/5] network: add network_get_station
Date: Fri, 17 Sep 2021 15:58:37 -0700
Message-ID: <20210917225840.26848-2-prestwoj@gmail.com>
In-Reply-To: 20210917225840.26848-1-prestwoj@gmail.com

--===============0727148978852057052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 5 +++++
 src/network.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/network.c b/src/network.c
index 4768b872..f7172c78 100644
--- a/src/network.c
+++ b/src/network.c
@@ -392,6 +392,11 @@ struct l_settings *network_get_settings(const struct n=
etwork *network)
 	return network->settings;
 }
 =

+struct station *network_get_station(const struct network *network)
+{
+	return network->station;
+}
+
 static bool network_set_8021x_secrets(struct network *network)
 {
 	const struct l_queue_entry *entry;
diff --git a/src/network.h b/src/network.h
index 5451815b..d69d63b0 100644
--- a/src/network.h
+++ b/src/network.h
@@ -44,6 +44,7 @@ enum security network_get_security(const struct network *=
network);
 bool network_set_passphrase(struct network *network, const char *passphras=
e);
 int network_get_signal_strength(const struct network *network);
 struct l_settings *network_get_settings(const struct network *network);
+struct station *network_get_station(const struct network *network);
 =

 bool network_set_psk(struct network *network, const uint8_t *psk);
 =

-- =

2.31.1

--===============0727148978852057052==--

