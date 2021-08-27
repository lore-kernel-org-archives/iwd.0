Content-Type: multipart/mixed; boundary="===============1907748697274967603=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] station, netdev: Enable FILS IP Address Assignment
Date: Fri, 27 Aug 2021 05:02:05 +0200
Message-ID: <20210827030207.353705-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210827030207.353705-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1907748697274967603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send and receive the FILS IP Address Assignment IEs during association.
As implemented this would work independently of FILS although the only
AP software handling this mechanism without FILS is likely IWD itself.

No support is added for handling the IP assignment information sent from
the server after the initial Association Request/Response frames, i.e.
the information is only used if it is received directly in the
Association Response without the "response pending" bit, otherwise the
DHCP client will be started.
---
 src/handshake.c |  2 ++
 src/handshake.h |  2 ++
 src/netdev.c    | 15 +++++++++++++++
 src/station.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index f36df572..146434c2 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -106,6 +106,8 @@ void handshake_state_free(struct handshake_state *s)
 	l_free(s->supplicant_rsnxe);
 	l_free(s->mde);
 	l_free(s->fte);
+	l_free(s->fils_ip_req_ie);
+	l_free(s->fils_ip_resp_ie);
 =

 	if (s->erp_cache)
 		erp_cache_put(s->erp_cache);
diff --git a/src/handshake.h b/src/handshake.h
index 31dce117..f3f6680b 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -140,6 +140,8 @@ struct handshake_state {
 	uint32_t client_ip_addr;
 	uint32_t subnet_mask;
 	uint32_t go_ip_addr;
+	uint8_t *fils_ip_req_ie;
+	uint8_t *fils_ip_resp_ie;
 	void *user_data;
 =

 	void (*free)(struct handshake_state *s);
diff --git a/src/netdev.c b/src/netdev.c
index 54856f6a..a5d1b8ed 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -292,6 +292,9 @@ static unsigned int netdev_populate_common_ies(struct n=
etdev *netdev,
 =

 	c_iov =3D iov_ie_append(iov, n_iov, c_iov, hs->vendor_ies);
 =

+	if (hs->fils_ip_req_ie)
+		c_iov =3D iov_ie_append(iov, n_iov, c_iov, hs->fils_ip_req_ie);
+
 	return c_iov;
 }
 =

@@ -2186,6 +2189,18 @@ process_resp_ies:
 				qos_set =3D data;
 				qos_len =3D ie_tlv_iter_get_length(&iter);
 				break;
+			case IE_TYPE_FILS_IP_ADDRESS:
+				if (netdev->handshake->fils_ip_resp_ie) {
+					l_debug("Duplicate response FILS IP "
+						"Address Assignment IE");
+					l_free(netdev->handshake->
+						fils_ip_resp_ie);
+				}
+
+				netdev->handshake->fils_ip_resp_ie =3D l_memdup(
+					data - 3,
+					ie_tlv_iter_get_length(&iter) + 3);
+				break;
 			}
 		}
 =

diff --git a/src/station.c b/src/station.c
index f6237ade..9f00bfb3 100644
--- a/src/station.c
+++ b/src/station.c
@@ -924,6 +924,7 @@ static struct handshake_state *station_handshake_setup(=
struct station *station,
 	struct handshake_state *hs;
 	const struct iovec *vendor_ies;
 	size_t iov_elems =3D 0;
+	struct ie_fils_ip_addr_request_info fils_ip_req;
 =

 	hs =3D netdev_handshake_state_new(station->netdev);
 =

@@ -940,6 +941,16 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 	vendor_ies =3D network_info_get_extra_ies(info, bss, &iov_elems);
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 =

+	/*
+	 * It can't hurt to try the FILS IP Address Assigment independent of
+	 * which auth-proto is actually used.
+	 */
+	if (station->netconfig && netconfig_get_fils_ip_req(station->netconfig,
+								&fils_ip_req)) {
+		hs->fils_ip_req_ie =3D l_malloc(32);
+		ie_build_fils_ip_addr_request(&fils_ip_req, hs->fils_ip_req_ie);
+	}
+
 	return hs;
 =

 not_supported:
@@ -2444,6 +2455,35 @@ static void station_connect_ok(struct station *stati=
on)
 	network_connected(station->connected_network);
 =

 	if (station->netconfig) {
+		if (hs->fils_ip_req_ie && hs->fils_ip_resp_ie) {
+			struct ie_fils_ip_addr_response_info info;
+			struct ie_tlv_iter iter;
+			int r;
+
+			ie_tlv_iter_init(&iter, hs->fils_ip_resp_ie,
+						hs->fils_ip_resp_ie[1] + 2);
+			ie_tlv_iter_next(&iter);
+			r =3D ie_parse_fils_ip_addr_response(&iter, &info);
+
+			if (r !=3D 0)
+				l_debug("Error parsing the FILS IP Address "
+					"Assignment response: %s (%i)",
+					strerror(-r), -r);
+			else if (info.response_pending &&
+					info.response_timeout)
+				l_debug("FILS IP Address Assignment response "
+					"is pending (unsupported)");
+			else if (info.response_pending)
+				l_debug("FILS IP Address Assignment failed");
+			else {
+				l_debug("FILS IP Address Assignment response "
+					"OK");
+				netconfig_handle_fils_ip_resp(
+							station->netconfig,
+							&info);
+			}
+		}
+
 		if (L_WARN_ON(!netconfig_configure(station->netconfig,
 						station_netconfig_event_handler,
 						station)))
-- =

2.30.2

--===============1907748697274967603==--

