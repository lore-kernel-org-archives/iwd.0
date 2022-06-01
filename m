Content-Type: multipart/mixed; boundary="===============4531266194534402899=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: allow wildcard phase1 for EAP tests
Date: Wed, 01 Jun 2022 09:05:48 -0700
Message-ID: <20220601160548.262018-2-prestwoj@gmail.com>
In-Reply-To: 20220601160548.262018-1-prestwoj@gmail.com

--===============4531266194534402899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows the EAP tests to pass, but the fix really needs to be in
hostapd itself. Hostapd currently tries to lookup the EAP session
immediately after receiving EAPOL_REAUTH. This uses the identity
it has stored which, in the case of PEAP/TTLS, will always be a phase2
identity. During this initial lookup hostapd hard codes the identity
to be phase1 which is not true for PEAP/TTLS, and the lookup fails.
---
 autotests/misc/secrets/eap-user.text | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/autotests/misc/secrets/eap-user.text b/autotests/misc/secrets/=
eap-user.text
index 6f64b2f8..a34726d4 100644
--- a/autotests/misc/secrets/eap-user.text
+++ b/autotests/misc/secrets/eap-user.text
@@ -20,3 +20,8 @@
 "ttls-mschapv2-phase2(a)example.com"	TTLS-MSCHAPV2	"Password" [2]
 "ttls-pap-phase2(a)example.com"		TTLS-PAP	"Password" [2]
 "112345678(a)phonesim.org"		SIM [2]
+
+# TODO: Hostapd is broken with phase1 lookups for reauthentication.
+# Allowing a wildcard phase1 for PEAP/TTLS is a stop gap until
+# hostapd is actually fixed.
+*					PEAP,TTLS
-- =

2.34.1

--===============4531266194534402899==--

