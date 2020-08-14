Content-Type: multipart/mixed; boundary="===============0002781317151614131=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH v2 2/2] treewide: guard compare functions against signed
 integer overflow
Date: Fri, 14 Aug 2020 15:40:33 +0200
Message-ID: <20200814134033.322752-3-alsi@bang-olufsen.dk>
In-Reply-To: <20200814134033.322752-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0002781317151614131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Besides being undefined behaviour, signed integer overflow can cause
unexpected comparison results. In the case of network_rank_compare(),
a connected network with rank INT_MAX would cause newly inserted
networks with negative rank to be inserted earlier in the ordered
network list. This is reflected in the GetOrderedMethods() DBus method
as can be seen in the following iwctl output:

  [iwd]# station wlan0 get-networks
    Network name                    Security  Signal
  ----------------------------------------------------
    BEOLAN                          8021x     **** }
    BeoBlue                         psk       ***  } all unknown,
    UI_Test_Network                 psk       ***  } hence assigned
    deneb_2G                        psk       ***  } negative rank
    BEOGUEST                        open      **** }
  > titan                           psk       ****
    Linksys05274_5GHz_dmt           psk       ****
    Lyngby-4G-4 5GHz                psk       ****
---
 src/network.c | 2 +-
 src/scan.c    | 2 +-
 src/station.c | 4 ++--
 tools/hwsim.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/network.c b/src/network.c
index 70541b59..a7d59ca0 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1380,7 +1380,7 @@ int network_rank_compare(const void *a, const void *b=
, void *user)
 	const struct network *new_network =3D a;
 	const struct network *network =3D b;
 =

-	return network->rank - new_network->rank;
+	return (network->rank > new_network->rank) ? 1 : -1;
 }
 =

 void network_rank_update(struct network *network, bool connected)
diff --git a/src/scan.c b/src/scan.c
index c93beabd..69e3e975 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1436,7 +1436,7 @@ int scan_bss_rank_compare(const void *a, const void *=
b, void *user_data)
 {
 	const struct scan_bss *new_bss =3D a, *bss =3D b;
 =

-	return bss->rank - new_bss->rank;
+	return (bss->rank > new_bss->rank) ? 1 : -1;
 }
 =

 static void get_scan_callback(struct l_genl_msg *msg, void *user_data)
diff --git a/src/station.c b/src/station.c
index a0ec4038..e44dc145 100644
--- a/src/station.c
+++ b/src/station.c
@@ -196,7 +196,7 @@ static int autoconnect_rank_compare(const void *a, cons=
t void *b, void *user)
 	const struct autoconnect_entry *new_ae =3D a;
 	const struct autoconnect_entry *ae =3D b;
 =

-	return ae->rank - new_ae->rank;
+	return (ae->rank > new_ae->rank) ? 1 : -1;
 }
 =

 static void station_add_autoconnect_bss(struct station *station,
@@ -290,7 +290,7 @@ static int bss_signal_strength_compare(const void *a, c=
onst void *b, void *user)
 	const struct scan_bss *new_bss =3D a;
 	const struct scan_bss *bss =3D b;
 =

-	return bss->signal_strength - new_bss->signal_strength;
+	return (bss->signal_strength > new_bss->signal_strength) ? 1 : -1;
 }
 =

 /*
diff --git a/tools/hwsim.c b/tools/hwsim.c
index 3ccc936e..02053fa1 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1867,7 +1867,7 @@ static int rule_compare_priority(const void *a, const=
 void *b, void *user)
 	const struct hwsim_rule *rule_a =3D a;
 	const struct hwsim_rule *rule_b =3D b;
 =

-	return rule_a->priority - rule_b->priority;
+	return (rule_a->priority > rule_b->priority) ? 1 : -1;
 }
 =

 static struct l_dbus_message *rule_add(struct l_dbus *dbus,
-- =

2.28.0

--===============0002781317151614131==--

