Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D14C81
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:54 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id f65so16232229pgc.12
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NMN4ENhg0USTSbcYp8In7w4M752ZysXh+ylnFB8Hq2I=;
        b=jPB9qQzSsR8f4i2ZV89YeyEq+gmpp/YVpazHhLNPDsMjZlWMEBkcHIIc3l0Vm5Iidp
         Kc9aCoHHmvxsgSQ5V5xge09D4WSrBBknuEZaa4TxBdVvjQ8wp8z6dGVmbogJKcs1kfWH
         bANtyTzKpjcbFQ2jokZsKI9dYCQ694MhSf6Hw1NWfzeVT+HkmqEkcxEW70R6aRkXL90P
         a6uyqyrxPWWGaXakOjeBv2D6VN9kq31DRlQSgyRJW7V6whpHVEMQwny7K+y8uYhTvl+V
         id/soM7L9gbf7NaAUWXfz8rXcJDQEvgAkGAGpbWFCXdeAtnjA83pYMhlrCY6pHNsVmq+
         iBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NMN4ENhg0USTSbcYp8In7w4M752ZysXh+ylnFB8Hq2I=;
        b=FEFPiiXJydOthbP0tGssWj3z8SbW8w8VsiR1SwdvkbvDHjQBJHqV23mVIJ03NGNG8e
         +nJHR2l7CTd7fKMh9FyksnHoA65WWl3D+Q4bipZYfCjcKJxMXNhghRsQUQnavzSpijVW
         hCs8M2lCeOQ3njBnobyCGiMpy50SVkjGZcQfZZgWgEZBHzIFau7zNFjTM4C0Vwsrx+Cr
         b24DctJ4m8/g2HTUkHQ6qZwvSPVJJAUpISS2pPpXU2IeWHpo5vT1qS4vIDYERYngfoTZ
         OE2dxh7X7HjVAEqDzVapxeMnQF9XHcR/okgwwhgca9AXlfpFHCkTory2n4KkjPakHiGW
         KbPA==
X-Gm-Message-State: AJIora+Qz/enZM0thbrLSz7y7pkTB+Fob02GO4LxetO8OsXzp8ZaPcmr
	jTpCCuNyiMp76PfJpSB0g91i6PCuxDg=
X-Google-Smtp-Source: AGRyM1vAhTxhqXLIy2teJcoQUr1vEo8KLNL1qn57xhVGHExG0vjwXIkhXIm4vKVqyuw/xMzJwQFuSQ==
X-Received: by 2002:a05:6a00:aca:b0:52b:bd66:8c94 with SMTP id c10-20020a056a000aca00b0052bbd668c94mr27993815pfl.3.1659562614180;
        Wed, 03 Aug 2022 14:36:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 13/13] wiphy: don't re-dump wiphy if the regdom didn't change
Date: Wed,  3 Aug 2022 14:36:44 -0700
Message-Id: <20220803213644.277534-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For whatever reason the kernel will send regdom updates even if
the regdom didn't change. This ends up causing wiphy to dump
which isn't needed since there should be no changes in disabled
frequencies.

Now the previous country is checked against the new one, and if
they match the wiphy is not dumped again.
---
 src/wiphy.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index dec4b15e..cf7bd9bd 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2029,7 +2029,20 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
 					struct l_genl_msg *msg)
 {
-	char *out_country;
+	char out_country[2];
+	char *orig;
+
+	/*
+	 * Write the new country code or XX if the reg domain is not a
+	 * country domain.
+	 */
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_REG_ALPHA2, out_country,
+				NL80211_ATTR_UNSPEC) < 0)
+		out_country[0] = out_country[1] = 'X';
+
+	l_debug("New reg domain country code for %s is %c%c",
+		global ? "(global)" : wiphy->name,
+		out_country[0], out_country[1]);
 
 	if (global)
 		/*
@@ -2043,21 +2056,24 @@ static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
 		 * wiphy created (that is not self-managed anyway) and we
 		 * haven't received any REG_CHANGE events yet.
 		 */
-		out_country = regdom_country;
+		orig = regdom_country;
+
 	else
-		out_country = wiphy->regdom_country;
+		orig = wiphy->regdom_country;
 
 	/*
-	 * Write the new country code or XX if the reg domain is not a
-	 * country domain.
+	 * The kernel seems to send regdom updates even if the country didn't
+	 * change. Skip these as there is no reason to re-dump.
 	 */
-	if (nl80211_parse_attrs(msg, NL80211_ATTR_REG_ALPHA2, out_country,
-				NL80211_ATTR_UNSPEC) < 0)
-		out_country[0] = out_country[1] = 'X';
+	if (orig[0] == out_country[0] && orig[1] == out_country[1]) {
+		if (wiphy && wiphy->get_reg_id)
+			wiphy->get_reg_id = 0;
 
-	l_debug("New reg domain country code for %s is %c%c",
-		global ? "(global)" : wiphy->name,
-		out_country[0], out_country[1]);
+		return;
+	}
+
+	orig[0] = out_country[0];
+	orig[1] = out_country[1];
 
 	/* Don't dump wiphy from a GET_REG call */
 	if (wiphy && wiphy->get_reg_id) {
-- 
2.34.3

