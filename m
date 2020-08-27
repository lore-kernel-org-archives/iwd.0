Content-Type: multipart/mixed; boundary="===============2791989196639640088=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/11] eap-wsc: In WSC-R read UUID-E from settings
Date: Thu, 27 Aug 2020 20:14:45 +0200
Message-ID: <20200827181453.61823-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2791989196639640088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The intent was to read the UUID-E from the settings rather than generate
it from the enrollee's MAC because it needs to match the UUID-E from
enrolee's Probe Requests, fix this.  The UUID-E supplied in the unit
test was being ignored but the test still passed because the supplied
UUID-E was generated the same way we generated it in eap-wsc.c.
---
 src/eap-wsc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index bfab9e25..5b87924a 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -1871,9 +1871,6 @@ static struct eap_wsc_state *eap_wsc_new_common(struc=
t l_settings *settings,
 	if (!util_string_to_address(v, wsc->m1->addr))
 		goto err;
 =

-	if (!wsc_uuid_from_addr(wsc->m1->addr, wsc->m1->uuid_e))
-		goto err;
-
 	if (!l_settings_get_uint(settings, "WSC", "ConfigurationMethods", &u32))
 		u32 =3D WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN;
 =

@@ -1988,6 +1985,9 @@ static bool eap_wsc_load_settings(struct eap_state *e=
ap,
 						WSC_ENCRYPTION_TYPE_AES_TKIP;
 	wsc->m1->connection_type_flags =3D WSC_CONNECTION_TYPE_ESS;
 =

+	if (!wsc_uuid_from_addr(wsc->m1->addr, wsc->m1->uuid_e))
+		goto err;
+
 	if (!load_device_data(settings,
 				wsc->m1->manufacturer,
 				wsc->m1->model_name,
@@ -2041,6 +2041,9 @@ static bool eap_wsc_r_load_settings(struct eap_state =
*eap,
 	if (!wsc)
 		return false;
 =

+	if (!load_hexencoded(settings, "UUID-E", wsc->m1->uuid_e, 16))
+		goto err;
+
 	if (!load_hexencoded(settings, "UUID-R", wsc->m2->uuid_r, 16))
 		goto err;
 =

-- =

2.25.1

--===============2791989196639640088==--

