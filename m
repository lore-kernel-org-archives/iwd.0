Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5C1E9919
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771504457; cv=none; b=H+OrE75yFw8iYoVJSwY4tCSJk998yNfGvR4YvIWwysXTVSVP0WF3UFtcRfEMacKr7MzcdOqv4fXCFeuhcsDyhpDEQvu1GfDS3v1AAN+xSydlnmQnLdnbJFJwkS2MF913mm1LM1KTUM035DPcfNAlUgcRMyNguqrM1nWX/yHOISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771504457; c=relaxed/simple;
	bh=2SR7/0Te0Tkbt51RaV0UIHn2VgaTDVcgsn7j09qlWdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NS4GUTJuM4tza6HGUe3blWCN2O+g4DNRejJieH2KsdQ3PmUeTqVIEW/HnMkz/QiMNYo+s3Jf0bix8HDBu5pvlNegMPqjkDS1iw7GiLFlKn+RMhxfx2ugFbq/J54LiBezIjx8pn9DhyiWPEXsx0XeSoClXXi1o+FP3//K7NNZb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id D64C0582937
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 12:29:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41A89441D3;
	Thu, 19 Feb 2026 12:29:02 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: iwd@lists.linux.dev
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v3] unit: Add better check for pkcs8_key_parser availability
Date: Thu, 19 Feb 2026 13:28:23 +0100
Message-ID: <20260219122853.2234017-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgeduteekleeggeduffefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth

Check whether the pkcs8_key_parser kernel module is available (whether
built-in or as a module) before announcing that we support PKCS#8.
---
Changes since v2:
- Fix comment formatting

Changes since v1:
- Fix missing #include

 unit/test-eapol.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 58f3e054a5ae..89cad8e2920f 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -27,6 +27,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <assert.h>
+#include <sys/stat.h>
 #include <linux/if_ether.h>
 #include <ell/ell.h>
 
@@ -3923,6 +3924,18 @@ static bool aes_precheck(const void *data)
 
 static bool pkcs8_precheck(const void *data)
 {
+	struct stat s;
+
+	/*
+	 * Despite the path, this directory exists whether the module
+	 * is external or built-in.
+	 */
+	if (stat ("/sys/module/pkcs8_key_parser", &s) != 0)
+		return false;
+
+	if (!S_ISDIR (s.st_mode))
+		return false;
+
 	return (IS_ENABLED(HAVE_PKCS8_SUPPORT) &&
 		l_cipher_is_supported(L_CIPHER_AES) &&
 		l_cipher_is_supported(L_CIPHER_AES_CBC) &&
-- 
2.53.0

