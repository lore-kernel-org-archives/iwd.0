Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAED6A8D2
	for <iwd@lists.linux.dev>; Thu, 19 Feb 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771495953; cv=none; b=Jol1hDiAYylntj7rcEXEqJNmHmz467+1baTyBt71qS5HGv3cyYJ9vlIDFJUCAHP97OK/cQyHbTBTf35bhcOM0tUn6i59NqL574u1XCm1AAmUQC5VQRLL08osx7HjP9xNxSL+VEBbl6vvtu6LGFLcAT551835wedzSW2RgXPxl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771495953; c=relaxed/simple;
	bh=acj24mm9WPzvATwq2mEN65hs8SgSAMmvNnNDi7m+MwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYDgjEaUBoMODMyzQnlYVa6kfAT7NBh0Pz4P/4ecyTjpzjRjZlEjDAG4yIZN1BRhr6UHz8LwyRL6rCRUIC2GnXrpv3UQTwlLymLPAJlR2RGSB3+PIbqcuImudlK7qlvbg49XWn0mNYv9JAUR5cTKKZR2tivYSRU8N6qbbpfaTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66F1C4326A;
	Thu, 19 Feb 2026 10:12:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: iwd@lists.linux.dev
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] unit: Add better check for pkcs8_key_parser availability
Date: Thu, 19 Feb 2026 11:12:03 +0100
Message-ID: <20260219101221.2180374-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepieeihfduveegfedvieetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth
X-GND-State: clean

Check whether the pkcs8_key_parser kernel module is available (whether
built-in or as a module) before announcing that we support PKCS#8.
---
Note, this is an untested patch.

 unit/test-eapol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 58f3e054a5ae..144c2d56adf2 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3923,6 +3923,16 @@ static bool aes_precheck(const void *data)
 
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

