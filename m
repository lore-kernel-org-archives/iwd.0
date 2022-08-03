Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9E4A3A
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:52 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so3512311pjk.1
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OKM/i59AxLw4jUqSZ1blGJ5DGAxjKGQqs0QvO7SAGJw=;
        b=nDF/0crAW6BFeOe94akk+LqoDL2oL5/Z5BX5jnMnUolcExdO16ywOh/0rD2M89XXej
         a17uix59OxJRcqaITafCOvPQN7GL/ifoLK7UAYaJDpTuuGMCv12sf6xf4UnfMWEPwcgl
         wP0Jj3+VjYHoHlm2AYzXf8p2D+sq/gVDwx2fzphPTwVy90VnqDsW4/QBrAAAqtYyHFE1
         z58cBk9wHc23tqpBVcLx0nZH93fh+WJN5msYcHvndrdxnIDi3c57jauTYhPPHngPBnR1
         3guPdnxE2tXIVMTGio7E2wbtnDgrD1vW1DJFCGhqvEYCEkPGdUzuIgsehDkPVMA/3JHX
         fWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OKM/i59AxLw4jUqSZ1blGJ5DGAxjKGQqs0QvO7SAGJw=;
        b=KzSuWxo5MATAv08qIWaaQmkB8Ly6rsTqi46j+Funm89B9AvqZy6rEUcpG4yaCb5WkL
         d0aNQ5AjWKz0FPgXfIJQ9mZ73e9afnWlOFrRBEnPOZeF8D8XBt/n/SeKi1SkaSYZO9z4
         uShUkYLtC3bQLNE4etjbpb3yxthgcyujwT7f5/xpSLpjJeeNTm8t8wSlcStHopJxZSdf
         DN7mBuP6CqVGAjNSU3Rhh5MkcSmo01tUc42YiQ2ze2t+l48YlxV9W8O6O31gwKv4zMIs
         n6bOnCUUFx1KquxLkEwXlG3lLQ+8z5tEvdT5T+d4WPSV8av8iaQqNRpv1l9CnSFPT8nK
         7g1Q==
X-Gm-Message-State: ACgBeo1Flbc9BpkMxcYECo8gK3OIdU3nvb4QDgKsG4MG+PCvOMKBc9I4
	vdJd4F80bm6W4Db5FfQkODK3AiwZsVk=
X-Google-Smtp-Source: AA6agR4sWTIgaRG8mjR4DWcAkA69WtvHcw8qEe6s+IPxzXRGdCZ8hn1EW4ATAN1nB8XUzGWe2265vQ==
X-Received: by 2002:a17:902:ce0a:b0:16d:737b:feed with SMTP id k10-20020a170902ce0a00b0016d737bfeedmr27816151plg.152.1659562611994;
        Wed, 03 Aug 2022 14:36:51 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/13] wiphy: add wiphy_country_is_unknown
Date: Wed,  3 Aug 2022 14:36:40 -0700
Message-Id: <20220803213644.277534-9-prestwoj@gmail.com>
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

A helper to check whether the country code corresponds to a
real country, or some special code indicating the country isn't
yet set. For now, the special codes are OO (world roaming) and
XX (unknown entity).
---
 src/wiphy.c | 16 ++++++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 6a109655..dec4b15e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -800,6 +800,22 @@ void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out)
 	out[1] = country[1];
 }
 
+bool wiphy_country_is_unknown(struct wiphy *wiphy)
+{
+	char cc[2];
+
+	wiphy_get_reg_domain_country(wiphy, cc);
+
+	/*
+	 * Treat OO and XX as an unknown country. Additional codes could be
+	 * added here if needed. The purpose of this is to know if we can
+	 * expect the disabled frequency list to be updated once a country is
+	 * known.
+	 */
+	return ((cc[0] == 'O' && cc[1] == 'O') ||
+			(cc[0] == 'X' && cc[1] == 'X'));
+}
+
 int wiphy_estimate_data_rate(struct wiphy *wiphy,
 				const void *ies, uint16_t ies_len,
 				const struct scan_bss *bss,
diff --git a/src/wiphy.h b/src/wiphy.h
index 1fea6c23..2159fc00 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -124,6 +124,7 @@ const uint8_t *wiphy_get_extended_capabilities(struct wiphy *wiphy,
 const uint8_t *wiphy_get_rm_enabled_capabilities(struct wiphy *wiphy);
 bool wiphy_get_rsnxe(const struct wiphy *wiphy, uint8_t *buf, size_t len);
 void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
+bool wiphy_country_is_unknown(struct wiphy *wiphy);
 
 void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[static 6]);
 void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssid,
-- 
2.34.3

