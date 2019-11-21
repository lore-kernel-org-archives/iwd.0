Content-Type: multipart/mixed; boundary="===============7918758018291312683=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] p2putil: Replace free with clear in function names
Date: Thu, 21 Nov 2019 21:15:54 +0100
Message-ID: <20191121201557.16506-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7918758018291312683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All these functions free up the resources used by the struct but don't
free the struct itself (allowing it to be static) so rename the
functions to avoid confusion.
---
The patch probably would be easier to read without -n / -u
---
 src/p2putil.c | 132 +++++++++++++++++++++++++-------------------------
 src/p2putil.h |  30 ++++++------
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index ce53b2a2..02c02b4d 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -321,7 +321,7 @@ static bool extract_p2p_device_info(const uint8_t *attr=
, size_t len,
 	return true;
 }
 =

-static void p2p_free_client_info_descriptor(void *data)
+static void p2p_clear_client_info_descriptor(void *data)
 {
 	struct p2p_client_info_descriptor *desc =3D data;
 =

@@ -397,7 +397,7 @@ static bool extract_p2p_group_info(const uint8_t *attr,=
 size_t len,
 	return true;
 =

 error:
-	l_queue_destroy(*out, p2p_free_client_info_descriptor);
+	l_queue_destroy(*out, p2p_clear_client_info_descriptor);
 	*out =3D NULL;
 =

 	return false;
@@ -502,7 +502,7 @@ static bool extract_p2p_advertisement_id(const uint8_t =
*attr, size_t len,
 	return true;
 }
 =

-static void p2p_free_advertised_service_descriptor(void *data)
+static void p2p_clear_advertised_service_descriptor(void *data)
 {
 	struct p2p_advertised_service_descriptor *desc =3D data;
 =

@@ -548,7 +548,7 @@ static bool extract_p2p_advertised_service_info(const u=
int8_t *attr, size_t len,
 	return true;
 =

 error:
-	l_queue_destroy(*out, p2p_free_advertised_service_descriptor);
+	l_queue_destroy(*out, p2p_clear_advertised_service_descriptor);
 	return false;
 }
 =

@@ -758,7 +758,7 @@ int p2p_parse_beacon(const uint8_t *pdu, size_t len, st=
ruct p2p_beacon *out)
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_beacon(&d);
+		p2p_clear_beacon(&d);
 =

 	return r;
 }
@@ -784,7 +784,7 @@ int p2p_parse_probe_req(const uint8_t *pdu, size_t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_probe_req(&d);
+		p2p_clear_probe_req(&d);
 =

 	/*
 	 * The additional WSC IE attributes are already covered by
@@ -814,7 +814,7 @@ int p2p_parse_probe_resp(const uint8_t *pdu, size_t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_probe_resp(&d);
+		p2p_clear_probe_resp(&d);
 =

 	return r;
 }
@@ -837,7 +837,7 @@ int p2p_parse_association_req(const uint8_t *pdu, size_=
t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_association_req(&d);
+		p2p_clear_association_req(&d);
 =

 	return r;
 }
@@ -961,7 +961,7 @@ int p2p_parse_go_negotiation_req(const uint8_t *pdu, si=
ze_t len,
 	return 0;
 =

 error:
-	p2p_free_go_negotiation_req(&d);
+	p2p_clear_go_negotiation_req(&d);
 	return r;
 }
 =

@@ -1020,7 +1020,7 @@ int p2p_parse_go_negotiation_resp(const uint8_t *pdu,=
 size_t len,
 	return 0;
 =

 error:
-	p2p_free_go_negotiation_resp(&d);
+	p2p_clear_go_negotiation_resp(&d);
 	return r;
 }
 =

@@ -1049,7 +1049,7 @@ int p2p_parse_go_negotiation_confirmation(const uint8=
_t *pdu, size_t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_go_negotiation_confirmation(&d);
+		p2p_clear_go_negotiation_confirmation(&d);
 =

 	return r;
 }
@@ -1101,7 +1101,7 @@ done:
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_invitation_req(&d);
+		p2p_clear_invitation_req(&d);
 =

 	return r;
 }
@@ -1131,7 +1131,7 @@ int p2p_parse_invitation_resp(const uint8_t *pdu, siz=
e_t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_invitation_resp(&d);
+		p2p_clear_invitation_resp(&d);
 =

 	return r;
 }
@@ -1254,7 +1254,7 @@ int p2p_parse_provision_disc_req(const uint8_t *pdu, =
size_t len,
 	return 0;
 =

 error:
-	p2p_free_provision_disc_req(&d);
+	p2p_clear_provision_disc_req(&d);
 	return r;
 }
 =

@@ -1332,7 +1332,7 @@ int p2p_parse_provision_disc_resp(const uint8_t *pdu,=
 size_t len,
 	return 0;
 =

 error:
-	p2p_free_provision_disc_resp(&d);
+	p2p_clear_provision_disc_resp(&d);
 	return r;
 }
 =

@@ -1353,7 +1353,7 @@ int p2p_parse_notice_of_absence(const uint8_t *pdu, s=
ize_t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_notice_of_absence(&d);
+		p2p_clear_notice_of_absence(&d);
 =

 	return r;
 }
@@ -1379,7 +1379,7 @@ int p2p_parse_presence_req(const uint8_t *pdu, size_t=
 len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_presence_req(&d);
+		p2p_clear_presence_req(&d);
 =

 	return r;
 }
@@ -1406,7 +1406,7 @@ int p2p_parse_presence_resp(const uint8_t *pdu, size_=
t len,
 	if (r >=3D 0)
 		memcpy(out, &d, sizeof(d));
 	else
-		p2p_free_presence_resp(&d);
+		p2p_clear_presence_resp(&d);
 =

 	return r;
 }
@@ -1420,132 +1420,132 @@ int p2p_parse_go_disc_req(const uint8_t *pdu, siz=
e_t len)
 	return 0;
 }
 =

-static void p2p_free_channel_list_attr(struct p2p_channel_list_attr *attr)
+static void p2p_clear_channel_list_attr(struct p2p_channel_list_attr *attr)
 {
 	l_queue_destroy(attr->channel_entries, l_free);
 	attr->channel_entries =3D NULL;
 }
 =

-static void p2p_free_notice_of_absence_attr(
+static void p2p_clear_notice_of_absence_attr(
 					struct p2p_notice_of_absence_attr *attr)
 {
 	l_queue_destroy(attr->descriptors, l_free);
 	attr->descriptors =3D NULL;
 }
 =

-static void p2p_free_device_info_attr(struct p2p_device_info_attr *attr)
+static void p2p_clear_device_info_attr(struct p2p_device_info_attr *attr)
 {
 	l_queue_destroy(attr->secondary_device_types, l_free);
 	attr->secondary_device_types =3D NULL;
 }
 =

-static void p2p_free_group_info_attr(struct l_queue **group_clients)
+static void p2p_clear_group_info_attr(struct l_queue **group_clients)
 {
-	l_queue_destroy(*group_clients, p2p_free_client_info_descriptor);
+	l_queue_destroy(*group_clients, p2p_clear_client_info_descriptor);
 	*group_clients =3D NULL;
 }
 =

-static void p2p_free_interface_attr(struct p2p_interface_attr *attr)
+static void p2p_clear_interface_attr(struct p2p_interface_attr *attr)
 {
 	l_queue_destroy(attr->interface_addrs, l_free);
 	attr->interface_addrs =3D NULL;
 }
 =

-static void p2p_free_svc_hash_attr(struct l_queue **hashes)
+static void p2p_clear_svc_hash_attr(struct l_queue **hashes)
 {
 	l_queue_destroy(*hashes, l_free);
 	*hashes =3D NULL;
 }
 =

-static void p2p_free_advertised_service_info_attr(struct l_queue **descrip=
tors)
+static void p2p_clear_advertised_service_info_attr(struct l_queue **descri=
ptors)
 {
-	l_queue_destroy(*descriptors, p2p_free_advertised_service_descriptor);
+	l_queue_destroy(*descriptors, p2p_clear_advertised_service_descriptor);
 	*descriptors =3D NULL;
 }
 =

-void p2p_free_beacon(struct p2p_beacon *data)
+void p2p_clear_beacon(struct p2p_beacon *data)
 {
-	p2p_free_notice_of_absence_attr(&data->notice_of_absence);
+	p2p_clear_notice_of_absence_attr(&data->notice_of_absence);
 }
 =

-void p2p_free_probe_req(struct p2p_probe_req *data)
+void p2p_clear_probe_req(struct p2p_probe_req *data)
 {
-	p2p_free_device_info_attr(&data->device_info);
-	p2p_free_svc_hash_attr(&data->service_hashes);
+	p2p_clear_device_info_attr(&data->device_info);
+	p2p_clear_svc_hash_attr(&data->service_hashes);
 }
 =

-void p2p_free_probe_resp(struct p2p_probe_resp *data)
+void p2p_clear_probe_resp(struct p2p_probe_resp *data)
 {
-	p2p_free_notice_of_absence_attr(&data->notice_of_absence);
-	p2p_free_device_info_attr(&data->device_info);
-	p2p_free_group_info_attr(&data->group_clients);
-	p2p_free_advertised_service_info_attr(&data->advertised_svcs);
+	p2p_clear_notice_of_absence_attr(&data->notice_of_absence);
+	p2p_clear_device_info_attr(&data->device_info);
+	p2p_clear_group_info_attr(&data->group_clients);
+	p2p_clear_advertised_service_info_attr(&data->advertised_svcs);
 }
 =

-void p2p_free_association_req(struct p2p_association_req *data)
+void p2p_clear_association_req(struct p2p_association_req *data)
 {
-	p2p_free_device_info_attr(&data->device_info);
-	p2p_free_interface_attr(&data->interface);
+	p2p_clear_device_info_attr(&data->device_info);
+	p2p_clear_interface_attr(&data->interface);
 }
 =

-void p2p_free_association_resp(struct p2p_association_resp *data)
+void p2p_clear_association_resp(struct p2p_association_resp *data)
 {
 }
 =

-void p2p_free_go_negotiation_req(struct p2p_go_negotiation_req *data)
+void p2p_clear_go_negotiation_req(struct p2p_go_negotiation_req *data)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
-	p2p_free_device_info_attr(&data->device_info);
+	p2p_clear_channel_list_attr(&data->channel_list);
+	p2p_clear_device_info_attr(&data->device_info);
 }
 =

-void p2p_free_go_negotiation_resp(struct p2p_go_negotiation_resp *data)
+void p2p_clear_go_negotiation_resp(struct p2p_go_negotiation_resp *data)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
-	p2p_free_device_info_attr(&data->device_info);
+	p2p_clear_channel_list_attr(&data->channel_list);
+	p2p_clear_device_info_attr(&data->device_info);
 }
 =

-void p2p_free_go_negotiation_confirmation(
+void p2p_clear_go_negotiation_confirmation(
 				struct p2p_go_negotiation_confirmation *data)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
+	p2p_clear_channel_list_attr(&data->channel_list);
 }
 =

-void p2p_free_invitation_req(struct p2p_invitation_req *data)
+void p2p_clear_invitation_req(struct p2p_invitation_req *data)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
-	p2p_free_device_info_attr(&data->device_info);
+	p2p_clear_channel_list_attr(&data->channel_list);
+	p2p_clear_device_info_attr(&data->device_info);
 }
 =

-void p2p_free_invitation_resp(struct p2p_invitation_resp *data)
+void p2p_clear_invitation_resp(struct p2p_invitation_resp *data)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
+	p2p_clear_channel_list_attr(&data->channel_list);
 }
 =

-void p2p_free_provision_disc_req(struct p2p_provision_discovery_req *data)
+void p2p_clear_provision_disc_req(struct p2p_provision_discovery_req *data)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
-	p2p_free_device_info_attr(&data->device_info);
+	p2p_clear_channel_list_attr(&data->channel_list);
+	p2p_clear_device_info_attr(&data->device_info);
 }
 =

-void p2p_free_provision_disc_resp(struct p2p_provision_discovery_resp *dat=
a)
+void p2p_clear_provision_disc_resp(struct p2p_provision_discovery_resp *da=
ta)
 {
-	p2p_free_channel_list_attr(&data->channel_list);
-	p2p_free_device_info_attr(&data->device_info);
+	p2p_clear_channel_list_attr(&data->channel_list);
+	p2p_clear_device_info_attr(&data->device_info);
 }
 =

-void p2p_free_notice_of_absence(struct p2p_notice_of_absence *data)
+void p2p_clear_notice_of_absence(struct p2p_notice_of_absence *data)
 {
-	p2p_free_notice_of_absence_attr(&data->notice_of_absence);
+	p2p_clear_notice_of_absence_attr(&data->notice_of_absence);
 }
 =

-void p2p_free_presence_req(struct p2p_presence_req *data)
+void p2p_clear_presence_req(struct p2p_presence_req *data)
 {
-	p2p_free_notice_of_absence_attr(&data->notice_of_absence);
+	p2p_clear_notice_of_absence_attr(&data->notice_of_absence);
 }
 =

-void p2p_free_presence_resp(struct p2p_presence_resp *data)
+void p2p_clear_presence_resp(struct p2p_presence_resp *data)
 {
-	p2p_free_notice_of_absence_attr(&data->notice_of_absence);
+	p2p_clear_notice_of_absence_attr(&data->notice_of_absence);
 }
 =

 struct p2p_attr_builder {
diff --git a/src/p2putil.h b/src/p2putil.h
index 681d9e33..09c72c74 100644
--- a/src/p2putil.h
+++ b/src/p2putil.h
@@ -462,22 +462,22 @@ int p2p_parse_presence_resp(const uint8_t *pdu, size_=
t len,
 				struct p2p_presence_resp *out);
 int p2p_parse_go_disc_req(const uint8_t *pdu, size_t len);
 =

-void p2p_free_beacon(struct p2p_beacon *data);
-void p2p_free_probe_req(struct p2p_probe_req *data);
-void p2p_free_probe_resp(struct p2p_probe_resp *data);
-void p2p_free_association_req(struct p2p_association_req *data);
-void p2p_free_association_resp(struct p2p_association_resp *data);
-void p2p_free_go_negotiation_req(struct p2p_go_negotiation_req *data);
-void p2p_free_go_negotiation_resp(struct p2p_go_negotiation_resp *data);
-void p2p_free_go_negotiation_confirmation(
+void p2p_clear_beacon(struct p2p_beacon *data);
+void p2p_clear_probe_req(struct p2p_probe_req *data);
+void p2p_clear_probe_resp(struct p2p_probe_resp *data);
+void p2p_clear_association_req(struct p2p_association_req *data);
+void p2p_clear_association_resp(struct p2p_association_resp *data);
+void p2p_clear_go_negotiation_req(struct p2p_go_negotiation_req *data);
+void p2p_clear_go_negotiation_resp(struct p2p_go_negotiation_resp *data);
+void p2p_clear_go_negotiation_confirmation(
 				struct p2p_go_negotiation_confirmation *data);
-void p2p_free_invitation_req(struct p2p_invitation_req *data);
-void p2p_free_invitation_resp(struct p2p_invitation_resp *data);
-void p2p_free_provision_disc_req(struct p2p_provision_discovery_req *data);
-void p2p_free_provision_disc_resp(struct p2p_provision_discovery_resp *dat=
a);
-void p2p_free_notice_of_absence(struct p2p_notice_of_absence *data);
-void p2p_free_presence_req(struct p2p_presence_req *data);
-void p2p_free_presence_resp(struct p2p_presence_resp *data);
+void p2p_clear_invitation_req(struct p2p_invitation_req *data);
+void p2p_clear_invitation_resp(struct p2p_invitation_resp *data);
+void p2p_clear_provision_disc_req(struct p2p_provision_discovery_req *data=
);
+void p2p_clear_provision_disc_resp(struct p2p_provision_discovery_resp *da=
ta);
+void p2p_clear_notice_of_absence(struct p2p_notice_of_absence *data);
+void p2p_clear_presence_req(struct p2p_presence_req *data);
+void p2p_clear_presence_resp(struct p2p_presence_resp *data);
 =

 uint8_t *p2p_build_beacon(const struct p2p_beacon *data, size_t *out_len);
 uint8_t *p2p_build_probe_req(const struct p2p_probe_req *data, size_t *out=
_len);
-- =

2.20.1

--===============7918758018291312683==--

