Content-Type: multipart/mixed; boundary="===============6385725677909576201=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] monitor: Print WFD IE contents
Date: Fri, 20 Mar 2020 17:09:05 +0100
Message-ID: <20200320160905.12675-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6385725677909576201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only print the WFD version 2.1.0 spec subelements which removed all the
low level video format details from the IEs so this code is much
shorter.
---
 monitor/nlmon.c | 317 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 303 insertions(+), 14 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 087b374f..0aeaea31 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -325,6 +325,18 @@ static void print_hexdump(unsigned int level,
 	}
 }
 =

+static void print_address(unsigned int level, const char *label,
+					const unsigned char address[6])
+{
+	char addr[18];
+
+	snprintf(addr, sizeof(addr), "%02X:%02X:%02X:%02X:%02X:%02X",
+					address[0], address[1], address[2],
+					address[3], address[4], address[5]);
+
+	print_attr(level, "%s %s", label, addr);
+}
+
 static const struct {
 	const uint8_t oui[3];
 	const char *str;
@@ -3097,7 +3109,6 @@ static void print_p2p_capability(unsigned int level, =
const char *label,
 	CHECK_CAPS_BIT(P2P_GROUP_CAP_IP_ALLOCATION,
 			"IP Address Allocation");
 }
-#undef CHECK_CAPS_BIT
 =

 static void print_p2p_go_intent(unsigned int level, const char *label,
 				const void *data, uint16_t size)
@@ -3658,11 +3669,294 @@ static void print_p2p_attributes(unsigned int leve=
l, const char *label,
 	}
 }
 =

+static void print_wfd_device_info_flags(unsigned int level, const char *la=
bel,
+					uint16_t caps)
+{
+	static const char *dev_type[] =3D {
+		[WFD_DEV_INFO_TYPE_SOURCE] =3D "Source",
+		[WFD_DEV_INFO_TYPE_PRIMARY_SINK] =3D "Primary sink",
+		[WFD_DEV_INFO_TYPE_SECONDARY_SINK] =3D "Secondary sink",
+		[WFD_DEV_INFO_TYPE_DUAL_ROLE] =3D "Dual-role possible",
+	};
+	static const char *session_avail[] =3D {
+		[0] =3D "Not available for WFD Session",
+		[1] =3D "Available for WFD Session",
+		[2] =3D "Reserved (0b10)",
+		[3] =3D "Reserved (0b11)",
+	};
+
+	print_attr(level, "%s:", label);
+
+	print_attr(level + 1, "Device Type: %s",
+			dev_type[caps & WFD_DEV_INFO_DEVICE_TYPE]);
+	CHECK_CAPS_BIT(WFD_DEV_INFO_COUPLED_SINK_AT_SOURCE_OK,
+			"Coupled Sink Operation supported by WFD Source");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_COUPLED_SINK_AT_SINK_OK,
+			"Coupled Sink Operation supported by WFD Sink");
+	print_attr(level + 1, "Session Availability: %s",
+			session_avail[(caps &
+				WFD_DEV_INFO_SESSION_AVAILABILITY) >> 4]);
+	CHECK_CAPS_BIT(WFD_DEV_INFO_SERVICE_DISCOVERY_SUPPORT,
+			"WFD Service Discovery (WSD) supported");
+	print_attr(level + 1, "Preferred Connectivity (PC): %s",
+			(caps & WFD_DEV_INFO_PREFER_TDLS_CONNECTIVITY) ?
+			"TLDS" : "P2P");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_CONTENT_PROTECTION_SUPPORT,
+			"Content Protection using HDCP system 2.x supported");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_8021AS_TIME_SYNC_SUPPORT,
+			"Time Synchronization using 802.1AS supported");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_NO_AUDIO_AT_PRIMARY_SINK,
+			"WFD Primary Sink does not support audio rendering");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_AUDIO_ONLY_AT_SOURCE,
+			"WFD Source supports audio-only element stream");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_TDLS_PERSISTENT_GROUP,
+			"TDLS persistent group intended");
+	CHECK_CAPS_BIT(WFD_DEV_INFO_REINVOKE_TDLS_GROUP,
+			"Request for re-invocation of TDLS persistent group");
+
+	caps &=3D ~0x00ff;
+	if (caps)
+		print_attr(level + 1, "Reserved: 0x%04x", caps);
+}
+
+static void print_wfd_device_info(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *bytes =3D data;
+
+	if (size !=3D 6) {
+		printf("malformed WFD %s\n", label);
+		return;
+	}
+
+	print_wfd_device_info_flags(level, label, l_get_be16(bytes + 0));
+
+	print_attr(level, "%s: Session Management Control port %i",
+			label, l_get_be16(bytes + 2));
+	print_attr(level, "%s: Maximum Throughput %i Mbps",
+			label, l_get_be16(bytes + 4));
+}
+
+static void print_wfd_coupled_sink_info(unsigned int level, const char *la=
bel,
+					const void *data, uint16_t size)
+{
+	const uint8_t *bytes =3D data;
+	static const char *status[4] =3D {
+		[0] =3D "Not couple/Available for Coupling",
+		[1] =3D "Coupled",
+		[2] =3D "Teardown Coupling",
+		[3] =3D "Reserved (0b11)",
+	};
+
+	if (size !=3D 7) {
+		printf("malformed WFD %s\n", label);
+		return;
+	}
+
+	print_attr(level, "%s:", label);
+
+	print_attr(level + 1, "Status: %s", status[bytes[0] & 3]);
+
+	if (bytes[0] & ~3)
+		print_attr(level + 1, "Reserved: 0x%02x", bytes[0] & ~3);
+
+	print_address(level + 1, "Coupled Sink MAC Address", bytes + 1);
+}
+
+static void print_wfd_extended_caps(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *bytes =3D data;
+	uint16_t caps;
+
+	if (size !=3D 2) {
+		printf("malformed WFD %s\n", label);
+		return;
+	}
+
+	print_attr(level, "%s:", label);
+
+	caps =3D l_get_be16(bytes + 0);
+	CHECK_CAPS_BIT(0x0001, "UIBC support");
+	CHECK_CAPS_BIT(0x0002, "I2C Read/Write support");
+	CHECK_CAPS_BIT(0x0004, "Preferred Display mode support");
+	CHECK_CAPS_BIT(0x0008, "Standby and Resume Control support");
+	CHECK_CAPS_BIT(0x0010, "TDLS Persistent support");
+	CHECK_CAPS_BIT(0x0020, "TDLS Persistent BSSID support");
+
+	if (caps)
+		print_attr(level + 1, "Reserved: 0x%04x", caps);
+}
+
+static void print_wfd_local_ip(unsigned int level, const char *label,
+				const void *data, uint16_t size)
+{
+	const uint8_t *bytes =3D data;
+
+	if (size !=3D 5) {
+		printf("malformed WFD %s\n", label);
+		return;
+	}
+
+	if (bytes[0] !=3D 1) {
+		print_attr(level, "%s: Unknown version", label);
+		return;
+	}
+
+	print_attr(level, "%s: %i.%i.%i.%i", label,
+			bytes[1], bytes[2], bytes[3], bytes[4]);
+}
+
+static void print_wfd_session_info(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	int i =3D 1;
+
+	if (size % 24 !=3D 0) {
+		printf("malformed WFD %s\n", label);
+		return;
+	}
+
+	print_attr(level, "%s:", label);
+
+	while (size) {
+		const uint8_t *bytes =3D data;
+
+		if (bytes[0] !=3D 23) {
+			print_attr(level + 1,
+					"malformed WFD Device Info Descriptor");
+			continue;
+		}
+
+		print_attr(level + 1, "Device Info for client %i:", i++);
+
+		if (bytes[0] !=3D 1) {
+			print_attr(level, "%s: Unknown version", label);
+			return;
+		}
+
+		print_address(level + 2, "Device address", bytes + 1);
+
+		if (util_mem_is_zero(bytes + 7, 6))
+			print_attr(level+ + 2, "Not associated to an "
+					"infrastructure AP");
+		else
+			print_address(level + 2, "Associated BSSID", bytes + 7);
+
+		print_wfd_device_info_flags(level + 2, "WFD Device Information",
+						l_get_be16(bytes + 13));
+		print_attr(level + 2, "WFD Device Maximum Throughput %i Mbps",
+						l_get_be16(bytes + 15));
+		print_wfd_coupled_sink_info(level + 2,
+						"Coupled Sink Information",
+						bytes + 17, 7);
+
+		data +=3D 24;
+		size -=3D 24;
+	}
+}
+
+static void print_wfd_r2_device_info(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	static const char *dev_type[4] =3D {
+		[0] =3D "WFD R2 Source",
+		[1] =3D "WFD R2 Primary sink",
+		[2] =3D "Reserved (0b10)",
+		[3] =3D "Dual-role possible",
+	};
+	const uint8_t *bytes =3D data;
+	uint16_t caps;
+
+	if (size < 2) {
+		printf("malformed WFD %s\n", label);
+		return;
+	}
+
+	print_attr(level, "%s:", label);
+
+	caps =3D l_get_be16(bytes + 0);
+	print_attr(level + 1, "WFD R2 Device Type: %s", dev_type[caps & 3]);
+
+	if (caps & ~3)
+		print_attr(level + 1, "Reserved: 0x%04x", caps & ~3);
+}
+
+static struct attr_entry wfd_subelem_entry[] =3D {
+	{ WFD_SUBELEM_WFD_DEVICE_INFORMATION,	"WFD Device Information",
+		ATTR_CUSTOM,	{ .function =3D print_wfd_device_info } },
+	{ WFD_SUBELEM_ASSOCIATED_BSSID, 	"Associated BSSID",
+		ATTR_ADDRESS },
+	{ WFD_SUBELEM_COUPLED_SINK_INFORMATION,	"Coupled Sink Information",
+		ATTR_CUSTOM,	{ .function =3D print_wfd_coupled_sink_info } },
+	{ WFD_SUBELEM_EXTENDED_CAPABILITY,	"WFD Extended Capability",
+		ATTR_CUSTOM,	{ .function =3D print_wfd_extended_caps } },
+	{ WFD_SUBELEM_LOCAL_IP_ADDRESS,		"Local IP Address",
+		ATTR_CUSTOM,	{ .function =3D print_wfd_local_ip } },
+	{ WFD_SUBELEM_SESION_INFORMATION,	"WFD Session Information",
+		ATTR_CUSTOM,	{ .function =3D print_wfd_session_info } },
+	{ WFD_SUBELEM_ALTERNATIVE_MAC_ADDRESS,	"Alternative MAC Address",
+		ATTR_ADDRESS },
+	{ WFD_SUBELEM_R2_DEVICE_INFORMATION,	"WFD R2 Device Information",
+		ATTR_CUSTOM,	{ .function =3D print_wfd_r2_device_info } },
+	{ },
+};
+
+static void print_wfd_subelements(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	struct wfd_subelem_iter iter;
+	int i;
+
+	print_attr(level, "%s: len %u", label, size);
+
+	wfd_subelem_iter_init(&iter, data, size);
+
+	while (wfd_subelem_iter_next(&iter)) {
+		uint16_t type =3D wfd_subelem_iter_get_type(&iter);
+		uint16_t len =3D wfd_subelem_iter_get_length(&iter);
+		const void *attr =3D wfd_subelem_iter_get_data(&iter);
+		struct attr_entry *entry =3D NULL;
+
+		for (i =3D 0; wfd_subelem_entry[i].str; i++) {
+			if (wfd_subelem_entry[i].attr =3D=3D type) {
+				entry =3D &wfd_subelem_entry[i];
+				break;
+			}
+		}
+
+		if (!entry)
+			continue;
+
+		switch (entry->type) {
+		case ATTR_ADDRESS:
+			if (len !=3D 6) {
+				print_attr(level + 1, "malformed %s",
+						entry->str);
+				break;
+			}
+
+			print_address(level + 1, entry->str, attr);
+			break;
+		default:
+			if (entry->function)
+				entry->function(level + 1, entry->str, attr,
+						len);
+			else {
+				print_attr(level + 1, "Type: 0x%02x: len %u",
+						type, len);
+				print_hexdump(level + 2, attr, len);
+			}
+			break;
+		}
+	}
+}
+
 static void print_management_ies(unsigned int level, const char *label,
 					const void *data, uint16_t size)
 {
-	void *wsc_data, *p2p_data;
-	ssize_t wsc_len, p2p_len;
+	void *wsc_data, *p2p_data, *wfd_data;
+	ssize_t wsc_len, p2p_len, wfd_len;
 =

 	print_ie(level, label, data, size);
 =

@@ -3679,18 +3973,13 @@ static void print_management_ies(unsigned int level=
, const char *label,
 					p2p_data, p2p_len);
 		l_free(p2p_data);
 	}
-}
-
-static void print_address(unsigned int level, const char *label,
-					const unsigned char address[6])
-{
-	char addr[18];
 =

-	snprintf(addr, sizeof(addr), "%02X:%02X:%02X:%02X:%02X:%02X",
-					address[0], address[1], address[2],
-					address[3], address[4], address[5]);
-
-	print_attr(level, "%s %s", label, addr);
+	wfd_data =3D ie_tlv_extract_wfd_payload(data, size, &wfd_len);
+	if (wfd_data) {
+		print_wfd_subelements(level + 1, "WFD Payload",
+					wfd_data, wfd_len);
+		l_free(wfd_data);
+	}
 }
 =

 static void print_reason_code(unsigned int level, const char *label,
-- =

2.20.1

--===============6385725677909576201==--

