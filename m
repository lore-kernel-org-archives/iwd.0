Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6321C6A3
	for <iwd@lists.linux.dev>; Sat,  5 Oct 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728094807; cv=none; b=crywnT+UMImH/UfmWiSOxNGDA5iVHOxNdIKCuqbjABGOdoyRlsI2BbUnxKKHJNS3opnrx7RvVW+nAZvMyaO9pkZJ0vIGDONdlxtg91aOPk1EiDst+j3h9b9+Mu4Ca9izoicak0kHupgxtdt397vrTOVewCy0a8lLDGlSCZXLTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728094807; c=relaxed/simple;
	bh=Wt64LKPFJv4ICsL2TSIOLn760PWd21An+nH0gm5gLh8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FL4nztOmALI+BLuiQh4MVMFH6cL2dRg2YeD7NHTl8Af14RBSshzx6MRq2+GrYfcmZwc1Zuevkdk1oL2iVnDNkoLEx988bMsYA+24OuXa9uDVmLBxKNM2FaUpkwdeKgPWl/6MHyPzEuxzNMfGL0nNBfcz411rZ7BiFeUSiLWH0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qBZL5KIz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qBZL5KIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728094803;
	bh=Wt64LKPFJv4ICsL2TSIOLn760PWd21An+nH0gm5gLh8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qBZL5KIzFXyfZKWRf3pZr6OdytgCuPRRiTRwXuMVyu5PDrFB5U92ytECmfFHzOrgq
	 VJCu9s60jpt8j791NwKE3Y9egWcq8J1rDfqd9Pi7c2tN0S7KzjeloWuLPkJwwW7F+9
	 LPEConjMTHCq2QVgTjw3g5epUctLitLXuzsSqtaSHnW9HIKhCc3z9c20mj25oppa+Z
	 L/JNS182m6BH4xk5sQt75H9bwS+/EzmTbEV7ZNWnyuxknotWe0xA4H/3RdD3Hn7aEo
	 AY18U1A6VaGUzf2C9riU+YjsaYWaw2FW+EWx3DwhN51N66HK5E0/NXIz8tvtzScIEC
	 HU1aGFIM01GHQ==
Received: from noise.lan (unknown [IPv6:2001:4d48:ad5d:8e00::197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vivek)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EC3317E0F88
	for <iwd@lists.linux.dev>; Sat,  5 Oct 2024 04:20:03 +0200 (CEST)
From: =?UTF-8?q?Vivek=20Das=C2=A0Mohapatra?= <vivek@collabora.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/2] unit: add a test for harmless IE clones
Date: Sat,  5 Oct 2024 03:19:28 +0100
Message-Id: <20241005021929.2075817-2-vivek@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241005021929.2075817-1-vivek@collabora.com>
References: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
 <20241005021929.2075817-1-vivek@collabora.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test handling of technically illegal but harmless cloned IEs.
Based on real traffic captured from retail APs.

As cloned IEs are now allowed the

  "/IE order/Bad (Duplicate + Out of Order IE) 1"

test payload has been altered to be more-wrong so it still fails
verification as expected.
---
 unit/test-mpdu.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/unit/test-mpdu.c b/unit/test-mpdu.c
index 89b5bb0a..416756e9 100644
--- a/unit/test-mpdu.c
+++ b/unit/test-mpdu.c
@@ -145,7 +145,7 @@ static const uint8_t probe_req_ie_duplicate1[] = {
 	0x00, 0x00, 0x03, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x50, 0x64,
 	/* SSID, SSID, Supported Rates, Extended Supported Rates */
 	0x00, 0x05, 0x74, 0x65, 0x73, 0x74, 0x31, 0x00, 0x05, 0x74, 0x65, 0x73,
-	0x74, 0x31, 0x01, 0x08, 0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18, 0x24,
+	0x74, 0x32, 0x01, 0x08, 0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18, 0x24,
 	0x32, 0x04, 0x30, 0x48, 0x60, 0x6c,
 };
 
@@ -168,6 +168,85 @@ static const struct test_frame_data probe_req_ie_out_of_order2_data = {
 	probe_req_ie_out_of_order2, sizeof(probe_req_ie_out_of_order2), true
 };
 
+static const uint8_t assoc_rsp_ie_ooo_tolerated_dup[] = {
+	/* Association Response Flags (24 bytes)*/
+	0x10, 0x00, 0x24, 0x00, 0xe8, 0x8d, 0xa6, 0x77, 0xa7, 0x37, 0x0a, 0x58,
+	0x28, 0x16, 0x65, 0x42, 0x0a, 0x58, 0x28, 0x16, 0x65, 0x42, 0x40, 0x14,
+	/* Fixed Parameters (6 bytes) */
+	0x31, 0x19, 0x00, 0x00, 0x08, 0xc0,
+	/* Tagged parameters: 364 bytes */
+	/* Support Rates [1] (10 bytes) */
+	0x01, 0x08, 0x8c, 0x12, 0x98, 0x24, 0xb0, 0x48, 0x60, 0x6c,
+	/* Vendor Specific [221] (12 bytes) */
+	0xdd, 0x0a, 0x50, 0x6f, 0x9a, 0x1b, 0x06, 0x01, 0x20, 0x07, 0x01, 0x03,
+	/* RM Enabled Capabilities [70] (7 bytes) */
+	0x46, 0x05, 0x02, 0x00, 0x00, 0x00, 0x00,
+	/* Vendor Specific [221] (26 bytes) */
+	0xdd, 0x18, 0x00, 0x50, 0xf2, 0x02, 0x01, 0x01, 0x86, 0x00, 0x03, 0xa4,
+	0x00, 0x00, 0x27, 0xa4, 0x00, 0x00, 0x42, 0x43, 0x5e, 0x00, 0x62, 0x32,
+	0x2f, 0x00,
+	/* HT Capabilities [45] (28 bytes) */
+	0x2d, 0x1a, 0xef, 0x09, 0x03, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18,
+	0x04, 0x87, 0x19, 0x00,
+	/* HT Information [61] (24 bytes)*/
+	0x3d, 0x16, 0x24, 0x05, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* Vendor Specific [221] (32 bytes) */
+	0xdd, 0x1e, 0x00, 0x90, 0x4c, 0x33, 0xef, 0x09, 0x03, 0xff, 0xff, 0xff,
+	0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x18, 0x04, 0x87, 0x19, 0x00,
+	/* Vendor Specific [221] (28 bytes) */
+	0xdd, 0x1a, 0x00, 0x90, 0x4c, 0x34, 0x24, 0x05, 0x06, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	/* BSS Max Idle Period [90] (5 bytes)*/
+	0x5a, 0x03, 0xe0, 0x01, 0x00,
+	/* VHT Capabilities [191] (14 bytes)*/
+	0xbf, 0x0c, 0xf5, 0x39, 0xc3, 0x33, 0x9a, 0xff, 0x30, 0x0c, 0x9a, 0xff,
+	0x30, 0x2c,
+	/* VHT Operation [192] (7 bytes) */
+	0xc0, 0x05, 0x01, 0x2a, 0x00, 0xfc, 0xff,
+	/* Extended: HE Capabilities 80211ax/D3.0 [256 + 35] (38 bytes) */
+	0xff, 0x24, 0x23, 0x05, 0x00, 0x08, 0x1a, 0x44, 0x10, 0x0c, 0x20, 0xce,
+	0x92, 0x6f, 0x1b, 0xaf, 0xd4, 0x11, 0x0c, 0x00, 0xaa, 0xff, 0xaa, 0xff,
+	0xaa, 0xff, 0xaa, 0xff, 0x3b, 0x1c, 0xc7, 0x71, 0x1c, 0xc7, 0x71, 0x1c,
+	0xc7, 0x71,
+	/* Extended: HE Operation 80211ax/D3.0 [256 + 36] (9 bytes) */
+	0xff, 0x07, 0x24, 0xf4, 0x3f, 0x00, 0x17, 0xfc, 0xff,
+	/* Extended: Spatial Reuse Parameter Set [256 + 39] (4 bytes) */
+	0xff, 0x02, 0x27, 0x03,
+	/* Extended: MU EDCA Parameter Set [256 + 38] (16 bytes) */
+	0xff, 0x0e, 0x26, 0x06, 0x00, 0xff, 0x00, 0x20, 0xff, 0x00, 0x40, 0xff,
+	0x00, 0x60, 0xff, 0x00,
+	/* Extended Capabilities [127] (13 bytes) */
+	0x7f, 0x0b, 0x00, 0x00, 0x08, 0x80, 0x00, 0x40, 0x00, 0x40, 0x00, 0x40,
+	0x00,
+	/* Vendor Specific [221] (9 bytes) */
+	0xdd, 0x07, 0x00, 0x0c, 0x43, 0x00, 0x00, 0x00, 0x00,
+	/* Vendor Specific [221] (35 bytes) */
+	0xdd, 0x21, 0x00, 0x0c, 0xe7, 0x00, 0x00, 0x00, 0x00, 0xbf, 0x0c, 0xb1,
+	0x01, 0xc0, 0x33, 0x2a, 0xff, 0x92, 0x04, 0x2a, 0xff, 0x92, 0x04, 0xc0,
+	0x05, 0x00, 0x00, 0x00, 0x2a, 0xff, 0xc3, 0x03, 0x01, 0x02, 0x02,
+	/* Vendor Specific [221] (9 bytes) */
+	0xdd, 0x07, 0x50, 0x6f, 0x9a, 0x16, 0x01, 0x01, 0x00,
+	/* RSN Extension [244] (3 bytes) */
+	0xf4, 0x01, 0x20,
+	/* Vendor Specific [221] (9 bytes) */ /* Legal duplicate IE */
+	0xdd, 0x07, 0x50, 0x6f, 0x9a, 0x16, 0x01, 0x01, 0x00,
+	/* FILS Indication [240] (4 bytes) */
+	0xf0, 0x02, 0x00, 0x00,
+	/* RSN Extension [244] (3 bytes) */ /* TECHNICALLY ILLEGAL cloned ie */
+	0xf4, 0x01, 0x20,
+	/* Vendor Specific [221] (19 bytes) */
+	0xdd, 0x11, 0x00, 0x0c, 0xe7, 0x01, 0x00, 0x00, 0x00, 0x04, 0x08, 0x02,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct test_frame_data assoc_rsp_ie_ooo_tolerated_dup_data = {
+	assoc_rsp_ie_ooo_tolerated_dup, sizeof(assoc_rsp_ie_ooo_tolerated_dup), true
+};
+
 static void ie_order_test(const void *data)
 {
 	const struct test_frame_data *frame = data;
@@ -227,6 +306,9 @@ int main(int argc, char *argv[])
 	l_test_add("/IE order/Bad (Duplicate + Out of Order IE) 1",
 				ie_order_test,
 				&probe_req_ie_duplicate1_data);
+	l_test_add("/IE order/Ugly (Duplicate + Out of Order IE) 2",
+				ie_order_test,
+				&assoc_rsp_ie_ooo_tolerated_dup_data);
 	l_test_add("/IE order/Good (Out of Order IE) 2", ie_order_test,
 				&probe_req_ie_out_of_order2_data);
 
-- 
2.30.2

