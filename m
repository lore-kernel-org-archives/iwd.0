Content-Type: multipart/mixed; boundary="===============2515919619661027882=="
MIME-Version: 1.0
From: VAUTRIN Emmanuel (Canal Plus Prestataire) <Emmanuel.VAUTRIN at
 cpexterne.org>
To: iwd at lists.01.org
Subject: [PATCH v2] network: Hide hidden networks on connection error
Date: Mon, 04 Apr 2022 09:16:33 +0000
Message-ID: <
 <MRZP264MB1544AF0B829E1139AF42680393E59@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>>
In-Reply-To: 20220404090152.378284-1-Emmanuel.VAUTRIN@cpexterne.org

--===============2515919619661027882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a user connection fails on a freshly scanned psk hidden network,
during passphrase request or after, it shall be removed from the network li=
st.
Otherwise, it would be possible to directly connect to that known
network, which will appear as not hidden.

Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")
---
 src/dbus.c    |  6 ------
 src/dbus.h    |  2 --
 src/network.c | 10 ++++++++++
 src/station.c | 30 ------------------------------
 4 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index 32de1e1a60d8..433dfcf53e45 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -128,12 +128,6 @@ struct l_dbus_message *dbus_error_already_provisioned(
                                        "Already provisioned");
 }

-struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg)
-{
-       return l_dbus_message_new_error(msg, IWD_SERVICE ".NotHidden",
-                                       "Not hidden");
-}
-
 struct l_dbus_message *dbus_error_from_errno(int err,
                                                struct l_dbus_message *msg)
 {
diff --git a/src/dbus.h b/src/dbus.h
index bbc7660866a1..8fe37576a33a 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -76,8 +76,6 @@ struct l_dbus_message *dbus_error_service_set_overlap(
                                                struct l_dbus_message *msg);
 struct l_dbus_message *dbus_error_already_provisioned(
                                                struct l_dbus_message *msg);
-struct l_dbus_message *dbus_error_not_hidden(struct l_dbus_message *msg);
-
 struct l_dbus_message *dbus_error_from_errno(int err,
                                                struct l_dbus_message *msg);

diff --git a/src/network.c b/src/network.c
index d7f472be97d2..7c596ac31606 100644
--- a/src/network.c
+++ b/src/network.c
@@ -85,6 +85,7 @@ struct network {
        bool is_hs20:1;
        bool anqp_pending:1;    /* Set if there is a pending ANQP request */
        bool owe_hidden_pending:1;
+       bool provisioning_hidden:1;
        uint8_t transition_disable; /* Temporary cache until info is set */
        bool have_transition_disable:1;
        int rank;
@@ -188,6 +189,8 @@ void network_connected(struct network *network)
                                network_secret_check_cacheable, network);

        l_queue_clear(network->blacklist, NULL);
+
+       network->provisioning_hidden =3D false;
 }

 void network_disconnected(struct network *network)
@@ -980,6 +983,9 @@ void network_connect_failed(struct network *network, bo=
ol in_handshake)

        l_queue_destroy(network->secrets, eap_secret_info_free);
        network->secrets =3D NULL;
+
+       if (network->provisioning_hidden)
+               station_hide_network(network->station, network);
 }

 static bool hotspot_info_matches(struct network *network,
@@ -1242,6 +1248,9 @@ static void passphrase_callback(enum agent_result res=
ult,
        return;

 err:
+       if (network->provisioning_hidden)
+               station_hide_network(station, network);
+
        network_settings_close(network);
 }

@@ -1661,6 +1670,7 @@ struct l_dbus_message *network_connect_new_hidden_net=
work(

        switch (network_get_security(network)) {
        case SECURITY_PSK:
+               network->provisioning_hidden =3D true;
                return network_connect_psk(network, bss, message);
        case SECURITY_NONE:
                station_connect_network(station, network, bss, message);
diff --git a/src/station.c b/src/station.c
index f6f0adacd2ad..f3c21a4b48c3 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3253,36 +3253,6 @@ static struct l_dbus_message *station_dbus_connect_h=
idden_network(
        if (!network)
                network =3D station_network_find(station, ssid, SECURITY_NO=
NE);

-       /*
-        * This checks for a corner case where the hidden network was alrea=
dy
-        * found and is in our scan results, but the initial connection fai=
led.
-        * For example, the password was given incorrectly.  In this case t=
he
-        * entry will also be found on the hidden bss list.
-        */
-       if (network) {
-               const struct l_queue_entry *entry =3D
-                       l_queue_get_entries(station->hidden_bss_list_sorted=
);
-               struct scan_bss *target =3D network_bss_select(network, tru=
e);
-
-               /* Treat OWE transition networks special */
-               if (target->owe_trans)
-                       goto not_hidden;
-
-               for (; entry; entry =3D entry->next) {
-                       struct scan_bss *bss =3D entry->data;
-
-                       if (!scan_bss_addr_eq(target, bss))
-                               continue;
-
-                       /* We can skip the scan and try to connect right aw=
ay */
-                       return network_connect_new_hidden_network(network,
-                                                               message);
-               }
-
-not_hidden:
-               return dbus_error_not_hidden(message);
-       }
-
        params.ssid =3D (const uint8_t *)ssid;
        params.ssid_len =3D strlen(ssid);

--
2.25.1

Hello Denis, I have followed my proposal (1. On a passphrase failure,
or connect failure wipe it from the scan result cache), which I find cleane=
r.

Please find the initial formatted patch in attachment.

Best Regards,

Emmanuel


--===============2515919619661027882==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="v2-0001-network-Hide-hidden-networks-on-connection-error.patch"

RnJvbSA0MzI4ZDkyNmQzODhhOTNjZWM1MjFjMDU1NzgzNTE0MWM1Y2EwNDJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IEZyaSwgMSBBcHIgMjAyMiAxNzozMjo0MSArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggdjJdIG5ldHdvcms6IEhpZGUgaGlkZGVuIG5ldHdvcmtzIG9uIGNvbm5lY3Rpb24g
ZXJyb3IKCklmIGEgdXNlciBjb25uZWN0aW9uIGZhaWxzIG9uIGEgZnJlc2hseSBzY2FubmVkIHBz
ayBoaWRkZW4gbmV0d29yaywKZHVyaW5nIHBhc3NwaHJhc2UgcmVxdWVzdCBvciBhZnRlciwgaXQg
c2hhbGwgYmUgcmVtb3ZlZCBmcm9tIHRoZSBuZXR3b3JrIGxpc3QuCk90aGVyd2lzZSwgaXQgd291
bGQgYmUgcG9zc2libGUgdG8gZGlyZWN0bHkgY29ubmVjdCB0byB0aGF0IGtub3duCm5ldHdvcmss
IHdoaWNoIHdpbGwgYXBwZWFyIGFzIG5vdCBoaWRkZW4uCgpDb21taXQgMDZjYThlMjBhOWIwICgi
c3RhdGlvbjogSGlkZSBmb3Jnb3R0ZW4gaGlkZGVuIG5ldHdvcmtzIikKLS0tCiBzcmMvZGJ1cy5j
ICAgIHwgIDYgLS0tLS0tCiBzcmMvZGJ1cy5oICAgIHwgIDIgLS0KIHNyYy9uZXR3b3JrLmMgfCAx
MCArKysrKysrKysrCiBzcmMvc3RhdGlvbi5jIHwgMzAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3NyYy9kYnVzLmMgYi9zcmMvZGJ1cy5jCmluZGV4IDMyZGUxZTFhNjBk
OC4uNDMzZGZjZjUzZTQ1IDEwMDY0NAotLS0gYS9zcmMvZGJ1cy5jCisrKyBiL3NyYy9kYnVzLmMK
QEAgLTEyOCwxMiArMTI4LDYgQEAgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpkYnVzX2Vycm9yX2Fs
cmVhZHlfcHJvdmlzaW9uZWQoCiAJCQkJCSJBbHJlYWR5IHByb3Zpc2lvbmVkIik7CiB9CiAKLXN0
cnVjdCBsX2RidXNfbWVzc2FnZSAqZGJ1c19lcnJvcl9ub3RfaGlkZGVuKHN0cnVjdCBsX2RidXNf
bWVzc2FnZSAqbXNnKQotewotCXJldHVybiBsX2RidXNfbWVzc2FnZV9uZXdfZXJyb3IobXNnLCBJ
V0RfU0VSVklDRSAiLk5vdEhpZGRlbiIsCi0JCQkJCSJOb3QgaGlkZGVuIik7Ci19Ci0KIHN0cnVj
dCBsX2RidXNfbWVzc2FnZSAqZGJ1c19lcnJvcl9mcm9tX2Vycm5vKGludCBlcnIsCiAJCQkJCQlz
dHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZykKIHsKZGlmZiAtLWdpdCBhL3NyYy9kYnVzLmggYi9z
cmMvZGJ1cy5oCmluZGV4IGJiYzc2NjA4NjZhMS4uOGZlMzc1NzZhMzNhIDEwMDY0NAotLS0gYS9z
cmMvZGJ1cy5oCisrKyBiL3NyYy9kYnVzLmgKQEAgLTc2LDggKzc2LDYgQEAgc3RydWN0IGxfZGJ1
c19tZXNzYWdlICpkYnVzX2Vycm9yX3NlcnZpY2Vfc2V0X292ZXJsYXAoCiAJCQkJCQlzdHJ1Y3Qg
bF9kYnVzX21lc3NhZ2UgKm1zZyk7CiBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKmRidXNfZXJyb3Jf
YWxyZWFkeV9wcm92aXNpb25lZCgKIAkJCQkJCXN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbXNnKTsK
LXN0cnVjdCBsX2RidXNfbWVzc2FnZSAqZGJ1c19lcnJvcl9ub3RfaGlkZGVuKHN0cnVjdCBsX2Ri
dXNfbWVzc2FnZSAqbXNnKTsKLQogc3RydWN0IGxfZGJ1c19tZXNzYWdlICpkYnVzX2Vycm9yX2Zy
b21fZXJybm8oaW50IGVyciwKIAkJCQkJCXN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbXNnKTsKIApk
aWZmIC0tZ2l0IGEvc3JjL25ldHdvcmsuYyBiL3NyYy9uZXR3b3JrLmMKaW5kZXggZDdmNDcyYmU5
N2QyLi43YzU5NmFjMzE2MDYgMTAwNjQ0Ci0tLSBhL3NyYy9uZXR3b3JrLmMKKysrIGIvc3JjL25l
dHdvcmsuYwpAQCAtODUsNiArODUsNyBAQCBzdHJ1Y3QgbmV0d29yayB7CiAJYm9vbCBpc19oczIw
OjE7CiAJYm9vbCBhbnFwX3BlbmRpbmc6MTsJLyogU2V0IGlmIHRoZXJlIGlzIGEgcGVuZGluZyBB
TlFQIHJlcXVlc3QgKi8KIAlib29sIG93ZV9oaWRkZW5fcGVuZGluZzoxOworCWJvb2wgcHJvdmlz
aW9uaW5nX2hpZGRlbjoxOwogCXVpbnQ4X3QgdHJhbnNpdGlvbl9kaXNhYmxlOyAvKiBUZW1wb3Jh
cnkgY2FjaGUgdW50aWwgaW5mbyBpcyBzZXQgKi8KIAlib29sIGhhdmVfdHJhbnNpdGlvbl9kaXNh
YmxlOjE7CiAJaW50IHJhbms7CkBAIC0xODgsNiArMTg5LDggQEAgdm9pZCBuZXR3b3JrX2Nvbm5l
Y3RlZChzdHJ1Y3QgbmV0d29yayAqbmV0d29yaykKIAkJCQluZXR3b3JrX3NlY3JldF9jaGVja19j
YWNoZWFibGUsIG5ldHdvcmspOwogCiAJbF9xdWV1ZV9jbGVhcihuZXR3b3JrLT5ibGFja2xpc3Qs
IE5VTEwpOworCisJbmV0d29yay0+cHJvdmlzaW9uaW5nX2hpZGRlbiA9IGZhbHNlOwogfQogCiB2
b2lkIG5ldHdvcmtfZGlzY29ubmVjdGVkKHN0cnVjdCBuZXR3b3JrICpuZXR3b3JrKQpAQCAtOTgw
LDYgKzk4Myw5IEBAIHZvaWQgbmV0d29ya19jb25uZWN0X2ZhaWxlZChzdHJ1Y3QgbmV0d29yayAq
bmV0d29yaywgYm9vbCBpbl9oYW5kc2hha2UpCiAKIAlsX3F1ZXVlX2Rlc3Ryb3kobmV0d29yay0+
c2VjcmV0cywgZWFwX3NlY3JldF9pbmZvX2ZyZWUpOwogCW5ldHdvcmstPnNlY3JldHMgPSBOVUxM
OworCisJaWYgKG5ldHdvcmstPnByb3Zpc2lvbmluZ19oaWRkZW4pCisJCXN0YXRpb25faGlkZV9u
ZXR3b3JrKG5ldHdvcmstPnN0YXRpb24sIG5ldHdvcmspOwogfQogCiBzdGF0aWMgYm9vbCBob3Rz
cG90X2luZm9fbWF0Y2hlcyhzdHJ1Y3QgbmV0d29yayAqbmV0d29yaywKQEAgLTEyNDIsNiArMTI0
OCw5IEBAIHN0YXRpYyB2b2lkIHBhc3NwaHJhc2VfY2FsbGJhY2soZW51bSBhZ2VudF9yZXN1bHQg
cmVzdWx0LAogCXJldHVybjsKIAogZXJyOgorCWlmIChuZXR3b3JrLT5wcm92aXNpb25pbmdfaGlk
ZGVuKQorCQlzdGF0aW9uX2hpZGVfbmV0d29yayhzdGF0aW9uLCBuZXR3b3JrKTsKKwogCW5ldHdv
cmtfc2V0dGluZ3NfY2xvc2UobmV0d29yayk7CiB9CiAKQEAgLTE2NjEsNiArMTY3MCw3IEBAIHN0
cnVjdCBsX2RidXNfbWVzc2FnZSAqbmV0d29ya19jb25uZWN0X25ld19oaWRkZW5fbmV0d29yaygK
IAogCXN3aXRjaCAobmV0d29ya19nZXRfc2VjdXJpdHkobmV0d29yaykpIHsKIAljYXNlIFNFQ1VS
SVRZX1BTSzoKKwkJbmV0d29yay0+cHJvdmlzaW9uaW5nX2hpZGRlbiA9IHRydWU7CiAJCXJldHVy
biBuZXR3b3JrX2Nvbm5lY3RfcHNrKG5ldHdvcmssIGJzcywgbWVzc2FnZSk7CiAJY2FzZSBTRUNV
UklUWV9OT05FOgogCQlzdGF0aW9uX2Nvbm5lY3RfbmV0d29yayhzdGF0aW9uLCBuZXR3b3JrLCBi
c3MsIG1lc3NhZ2UpOwpkaWZmIC0tZ2l0IGEvc3JjL3N0YXRpb24uYyBiL3NyYy9zdGF0aW9uLmMK
aW5kZXggZjZmMGFkYWNkMmFkLi5mM2MyMWE0YjQ4YzMgMTAwNjQ0Ci0tLSBhL3NyYy9zdGF0aW9u
LmMKKysrIGIvc3JjL3N0YXRpb24uYwpAQCAtMzI1MywzNiArMzI1Myw2IEBAIHN0YXRpYyBzdHJ1
Y3QgbF9kYnVzX21lc3NhZ2UgKnN0YXRpb25fZGJ1c19jb25uZWN0X2hpZGRlbl9uZXR3b3JrKAog
CWlmICghbmV0d29yaykKIAkJbmV0d29yayA9IHN0YXRpb25fbmV0d29ya19maW5kKHN0YXRpb24s
IHNzaWQsIFNFQ1VSSVRZX05PTkUpOwogCi0JLyoKLQkgKiBUaGlzIGNoZWNrcyBmb3IgYSBjb3Ju
ZXIgY2FzZSB3aGVyZSB0aGUgaGlkZGVuIG5ldHdvcmsgd2FzIGFscmVhZHkKLQkgKiBmb3VuZCBh
bmQgaXMgaW4gb3VyIHNjYW4gcmVzdWx0cywgYnV0IHRoZSBpbml0aWFsIGNvbm5lY3Rpb24gZmFp
bGVkLgotCSAqIEZvciBleGFtcGxlLCB0aGUgcGFzc3dvcmQgd2FzIGdpdmVuIGluY29ycmVjdGx5
LiAgSW4gdGhpcyBjYXNlIHRoZQotCSAqIGVudHJ5IHdpbGwgYWxzbyBiZSBmb3VuZCBvbiB0aGUg
aGlkZGVuIGJzcyBsaXN0LgotCSAqLwotCWlmIChuZXR3b3JrKSB7Ci0JCWNvbnN0IHN0cnVjdCBs
X3F1ZXVlX2VudHJ5ICplbnRyeSA9Ci0JCQlsX3F1ZXVlX2dldF9lbnRyaWVzKHN0YXRpb24tPmhp
ZGRlbl9ic3NfbGlzdF9zb3J0ZWQpOwotCQlzdHJ1Y3Qgc2Nhbl9ic3MgKnRhcmdldCA9IG5ldHdv
cmtfYnNzX3NlbGVjdChuZXR3b3JrLCB0cnVlKTsKLQotCQkvKiBUcmVhdCBPV0UgdHJhbnNpdGlv
biBuZXR3b3JrcyBzcGVjaWFsICovCi0JCWlmICh0YXJnZXQtPm93ZV90cmFucykKLQkJCWdvdG8g
bm90X2hpZGRlbjsKLQotCQlmb3IgKDsgZW50cnk7IGVudHJ5ID0gZW50cnktPm5leHQpIHsKLQkJ
CXN0cnVjdCBzY2FuX2JzcyAqYnNzID0gZW50cnktPmRhdGE7Ci0KLQkJCWlmICghc2Nhbl9ic3Nf
YWRkcl9lcSh0YXJnZXQsIGJzcykpCi0JCQkJY29udGludWU7Ci0KLQkJCS8qIFdlIGNhbiBza2lw
IHRoZSBzY2FuIGFuZCB0cnkgdG8gY29ubmVjdCByaWdodCBhd2F5ICovCi0JCQlyZXR1cm4gbmV0
d29ya19jb25uZWN0X25ld19oaWRkZW5fbmV0d29yayhuZXR3b3JrLAotCQkJCQkJCQltZXNzYWdl
KTsKLQkJfQotCi1ub3RfaGlkZGVuOgotCQlyZXR1cm4gZGJ1c19lcnJvcl9ub3RfaGlkZGVuKG1l
c3NhZ2UpOwotCX0KLQogCXBhcmFtcy5zc2lkID0gKGNvbnN0IHVpbnQ4X3QgKilzc2lkOwogCXBh
cmFtcy5zc2lkX2xlbiA9IHN0cmxlbihzc2lkKTsKIAotLSAKMi4yNS4xCgo=

--===============2515919619661027882==--

