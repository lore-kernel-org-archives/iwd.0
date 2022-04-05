Content-Type: multipart/mixed; boundary="===============2004608183966122381=="
MIME-Version: 1.0
From: VAUTRIN Emmanuel (Canal Plus Prestataire) <Emmanuel.VAUTRIN at
 cpexterne.org>
To: iwd at lists.01.org
Subject: RE: [PATCH v3] network: Hide hidden networks on connection error
Date: Tue, 05 Apr 2022 11:19:50 +0000
Message-ID: <
 <MRZP264MB1544FC552250631C5868B22793E49@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>>
In-Reply-To: 20220405111100.512840-1-Emmanuel.VAUTRIN@cpexterne.org

--===============2004608183966122381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a user connection fails on a freshly scanned psk or open hidden network,
during passphrase request or after, it shall be removed from the network li=
st.
Otherwise, it would be possible to directly connect to that known
network, which will appear as not hidden.

Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")
---
 src/network.c | 11 +++++++++++
 src/station.c |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/src/network.c b/src/network.c
index d7f472be97d2..3f20ada765fd 100644
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

@@ -1661,8 +1670,10 @@ struct l_dbus_message *network_connect_new_hidden_ne=
twork(

        switch (network_get_security(network)) {
        case SECURITY_PSK:
+               network->provisioning_hidden =3D true;
                return network_connect_psk(network, bss, message);
        case SECURITY_NONE:
+               network->provisioning_hidden =3D true;
                station_connect_network(station, network, bss, message);
                return NULL;
        default:
diff --git a/src/station.c b/src/station.c
index f6f0adacd2ad..b83e6372ba2f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3198,6 +3198,8 @@ next:
        }

        if (network_psk && network_open) {
+               station_hide_network(station, network_psk);
+               station_hide_network(station, network_open);
                dbus_pending_reply(&msg, dbus_error_service_set_overlap(msg=
));
                return true;
        }
--
2.25.1

Hello Denis, I think I have followed your proposals.
 =

Please find the initial formatted patch in attachment.
 =

Best Regards,
 =

Emmanuel


--===============2004608183966122381==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="v3-0001-network-Hide-hidden-networks-on-connection-error.patch"

RnJvbSAwYmM0NzI1YzA3NTliMTFkNmM5NDVkNDU2NTI5MDk2NTY1YTI5ZDZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBWQVVUUklOIDxFbW1hbnVlbC5WQVVUUklOQGNw
ZXh0ZXJuZS5vcmc+CkRhdGU6IFR1ZSwgNSBBcHIgMjAyMiAxMDoyMTozMyArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggdjNdIG5ldHdvcms6IEhpZGUgaGlkZGVuIG5ldHdvcmtzIG9uIGNvbm5lY3Rpb24g
ZXJyb3IKCklmIGEgdXNlciBjb25uZWN0aW9uIGZhaWxzIG9uIGEgZnJlc2hseSBzY2FubmVkIHBz
ayBvciBvcGVuIGhpZGRlbiBuZXR3b3JrLApkdXJpbmcgcGFzc3BocmFzZSByZXF1ZXN0IG9yIGFm
dGVyLCBpdCBzaGFsbCBiZSByZW1vdmVkIGZyb20gdGhlIG5ldHdvcmsgbGlzdC4KT3RoZXJ3aXNl
LCBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBkaXJlY3RseSBjb25uZWN0IHRvIHRoYXQga25vd24K
bmV0d29yaywgd2hpY2ggd2lsbCBhcHBlYXIgYXMgbm90IGhpZGRlbi4KCkNvbW1pdCAwNmNhOGUy
MGE5YjAgKCJzdGF0aW9uOiBIaWRlIGZvcmdvdHRlbiBoaWRkZW4gbmV0d29ya3MiKQotLS0KIHNy
Yy9uZXR3b3JrLmMgfCAxMSArKysrKysrKysrKwogc3JjL3N0YXRpb24uYyB8ICAyICsrCiAyIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvbmV0d29yay5j
IGIvc3JjL25ldHdvcmsuYwppbmRleCBkN2Y0NzJiZTk3ZDIuLjNmMjBhZGE3NjVmZCAxMDA2NDQK
LS0tIGEvc3JjL25ldHdvcmsuYworKysgYi9zcmMvbmV0d29yay5jCkBAIC04NSw2ICs4NSw3IEBA
IHN0cnVjdCBuZXR3b3JrIHsKIAlib29sIGlzX2hzMjA6MTsKIAlib29sIGFucXBfcGVuZGluZzox
OwkvKiBTZXQgaWYgdGhlcmUgaXMgYSBwZW5kaW5nIEFOUVAgcmVxdWVzdCAqLwogCWJvb2wgb3dl
X2hpZGRlbl9wZW5kaW5nOjE7CisJYm9vbCBwcm92aXNpb25pbmdfaGlkZGVuOjE7CiAJdWludDhf
dCB0cmFuc2l0aW9uX2Rpc2FibGU7IC8qIFRlbXBvcmFyeSBjYWNoZSB1bnRpbCBpbmZvIGlzIHNl
dCAqLwogCWJvb2wgaGF2ZV90cmFuc2l0aW9uX2Rpc2FibGU6MTsKIAlpbnQgcmFuazsKQEAgLTE4
OCw2ICsxODksOCBAQCB2b2lkIG5ldHdvcmtfY29ubmVjdGVkKHN0cnVjdCBuZXR3b3JrICpuZXR3
b3JrKQogCQkJCW5ldHdvcmtfc2VjcmV0X2NoZWNrX2NhY2hlYWJsZSwgbmV0d29yayk7CiAKIAls
X3F1ZXVlX2NsZWFyKG5ldHdvcmstPmJsYWNrbGlzdCwgTlVMTCk7CisKKwluZXR3b3JrLT5wcm92
aXNpb25pbmdfaGlkZGVuID0gZmFsc2U7CiB9CiAKIHZvaWQgbmV0d29ya19kaXNjb25uZWN0ZWQo
c3RydWN0IG5ldHdvcmsgKm5ldHdvcmspCkBAIC05ODAsNiArOTgzLDkgQEAgdm9pZCBuZXR3b3Jr
X2Nvbm5lY3RfZmFpbGVkKHN0cnVjdCBuZXR3b3JrICpuZXR3b3JrLCBib29sIGluX2hhbmRzaGFr
ZSkKIAogCWxfcXVldWVfZGVzdHJveShuZXR3b3JrLT5zZWNyZXRzLCBlYXBfc2VjcmV0X2luZm9f
ZnJlZSk7CiAJbmV0d29yay0+c2VjcmV0cyA9IE5VTEw7CisKKwlpZiAobmV0d29yay0+cHJvdmlz
aW9uaW5nX2hpZGRlbikKKwkJc3RhdGlvbl9oaWRlX25ldHdvcmsobmV0d29yay0+c3RhdGlvbiwg
bmV0d29yayk7CiB9CiAKIHN0YXRpYyBib29sIGhvdHNwb3RfaW5mb19tYXRjaGVzKHN0cnVjdCBu
ZXR3b3JrICpuZXR3b3JrLApAQCAtMTI0Miw2ICsxMjQ4LDkgQEAgc3RhdGljIHZvaWQgcGFzc3Bo
cmFzZV9jYWxsYmFjayhlbnVtIGFnZW50X3Jlc3VsdCByZXN1bHQsCiAJcmV0dXJuOwogCiBlcnI6
CisJaWYgKG5ldHdvcmstPnByb3Zpc2lvbmluZ19oaWRkZW4pCisJCXN0YXRpb25faGlkZV9uZXR3
b3JrKHN0YXRpb24sIG5ldHdvcmspOworCiAJbmV0d29ya19zZXR0aW5nc19jbG9zZShuZXR3b3Jr
KTsKIH0KIApAQCAtMTY2MSw4ICsxNjcwLDEwIEBAIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbmV0
d29ya19jb25uZWN0X25ld19oaWRkZW5fbmV0d29yaygKIAogCXN3aXRjaCAobmV0d29ya19nZXRf
c2VjdXJpdHkobmV0d29yaykpIHsKIAljYXNlIFNFQ1VSSVRZX1BTSzoKKwkJbmV0d29yay0+cHJv
dmlzaW9uaW5nX2hpZGRlbiA9IHRydWU7CiAJCXJldHVybiBuZXR3b3JrX2Nvbm5lY3RfcHNrKG5l
dHdvcmssIGJzcywgbWVzc2FnZSk7CiAJY2FzZSBTRUNVUklUWV9OT05FOgorCQluZXR3b3JrLT5w
cm92aXNpb25pbmdfaGlkZGVuID0gdHJ1ZTsKIAkJc3RhdGlvbl9jb25uZWN0X25ldHdvcmsoc3Rh
dGlvbiwgbmV0d29yaywgYnNzLCBtZXNzYWdlKTsKIAkJcmV0dXJuIE5VTEw7CiAJZGVmYXVsdDoK
ZGlmZiAtLWdpdCBhL3NyYy9zdGF0aW9uLmMgYi9zcmMvc3RhdGlvbi5jCmluZGV4IGY2ZjBhZGFj
ZDJhZC4uYjgzZTYzNzJiYTJmIDEwMDY0NAotLS0gYS9zcmMvc3RhdGlvbi5jCisrKyBiL3NyYy9z
dGF0aW9uLmMKQEAgLTMxOTgsNiArMzE5OCw4IEBAIG5leHQ6CiAJfQogCiAJaWYgKG5ldHdvcmtf
cHNrICYmIG5ldHdvcmtfb3BlbikgeworCQlzdGF0aW9uX2hpZGVfbmV0d29yayhzdGF0aW9uLCBu
ZXR3b3JrX3Bzayk7CisJCXN0YXRpb25faGlkZV9uZXR3b3JrKHN0YXRpb24sIG5ldHdvcmtfb3Bl
bik7CiAJCWRidXNfcGVuZGluZ19yZXBseSgmbXNnLCBkYnVzX2Vycm9yX3NlcnZpY2Vfc2V0X292
ZXJsYXAobXNnKSk7CiAJCXJldHVybiB0cnVlOwogCX0KLS0gCjIuMjUuMQoK

--===============2004608183966122381==--

