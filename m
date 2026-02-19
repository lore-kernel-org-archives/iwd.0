Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093233DEC2
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500033; cv=none; b=QcClziZgsOtbF9VjsltbsomMMvSaclGNMFC6JUoya8/W0tXq3wxrJjz9aadMSfKCKz0pbHrU7t7UEh0H+dNr311X6Z2UT88inQrOjMLMEVVdHivlqhmFxzUOOY1nkFbBAkA6zes5aJdS1cu0flgHdpTpFfCMegSlK6HvQb4j3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500033; c=relaxed/simple;
	bh=5/PX8YzFKIzLbNsgQo3VszGrZDHeA5mVq58kMQCLF0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGSA8JX93NeV/b0/XzdIkbBsqksldbTROUUFE6BtjHkreorPrCE9ZRlLUnRH9svuC9cKBxqOJ1sz+Wjb7Avu93ApxgeEqjbA8z8vGMEZA3pyLYDttu0X+w2p9D6SZiXbAudrHf0gDfSnT8WWAexyCYpw1wK8plwbq8ifbLLmlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 105021F747;
	Thu, 19 Feb 2026 11:20:22 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: iwd@lists.linux.dev
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2] unit: Add better check for pkcs8_key_parser availability
Date: Thu, 19 Feb 2026 12:20:01 +0100
Message-ID: <20260219112014.2206170-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepuddthedtvdduhfejgeejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth
X-GND-State: clean

Check whether the pkcs8_key_parser kernel module is available (whether
built-in or as a module) before announcing that we support PKCS#8.
---
Changes since v1:
- Fix missing #include

 unit/test-eapol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 58f3e054a5ae..2ffc3e700108 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -27,6 +27,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <assert.h>
+#include <sys/stat.h>
 #include <linux/if_ether.h>
 #include <ell/ell.h>
 
@@ -3923,6 +3924,16 @@ static bool aes_precheck(const void *data)
 
 static bool pkcs8_precheck(const void *data)
 {
+	struct stat s;
+
+	/* Despite the path, this directory exists whether the module
+	 * is external or built-in. */
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

