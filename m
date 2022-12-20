Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD48F75
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:28 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso104952pjp.4
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nGSpjR6nowXT9sI9DlmK6l5AWvbe028EgZZi0Itg7w=;
        b=KhkdqasfRhfWI6Efe3HoyfTTt5FW0acksJzsqUwa9BdsU2QWz3ImpaFcfyby4AQHsd
         dg4SN8oD6tEgghRcN6MwX8+6HW0i7ro2IbQctUQH7EbxtnZ84Uh5xtKG/eaDKtke27Xn
         6Bm2nPKaMPi9Rircce3OH95cEGFBTL2n5RrPGpL5WwWxCzTKLOBqnAmT1EkFgTYyYp3b
         EIoMB0670TZvjStox/hlQVDjxhVOXh7L0Ihz6HPtxcYvrWnrOSySHB7MxBTjXCzzJwH3
         Q1Z3E7k6auc/y81o4uKZiIQZN2dOVtBn3w/My+0131r/y951dH8blqUEotwBMCrLy1S+
         LaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nGSpjR6nowXT9sI9DlmK6l5AWvbe028EgZZi0Itg7w=;
        b=1A8NnL4swSs6fKRihjldTJ/ctG8m0rt4qYLIKQwG4OY9kNbPeevIHLsb8kjYiELIel
         PXFeqrXULLM3cGMZezbQ+TzxVvomUMKRFExydX//YQqVhdxFUKDJcKpuSbL2SNTpSgZL
         aijS6DleGPzoN4PkESR4mjmFBtb5ECAWpv9OjbXdLsOLj2+YjteBO8/kDsqH9GmDfrd9
         O0pYlb4r/ZDiQTfM2UunQnEtjg283HpomWxK+wrL6v4dRIriNoTDrK3mhsX1QwtfXh4y
         gjHHSTtrXaBApMJWSpbESGdYOuOr5/LYkajFS8qpsvMQWdp9DPSYrtKnUAeiOpJvXNwp
         bSjw==
X-Gm-Message-State: AFqh2kqFTN1/STHPqDh5+y4MTbUKSOSmLrDj+5jHogAAwiHogA4oBne1
	fdw8KUQy2hKpfkXYkuxAIViB+qVu+qI=
X-Google-Smtp-Source: AMrXdXsmqmjzGt86jB0uI1JwA2rGOTPYy0Kj9cEAZowM/oTf3+4OUw+QnVfGGAhRGKsaVMwdZqT0kA==
X-Received: by 2002:a17:90b:2492:b0:223:88c6:f831 with SMTP id nt18-20020a17090b249200b0022388c6f831mr15158075pjb.12.1671572608012;
        Tue, 20 Dec 2022 13:43:28 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:27 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/10] wiphy: add wiphy_supports_uapsd
Date: Tue, 20 Dec 2022 13:43:15 -0800
Message-Id: <20221220214318.2041986-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/wiphy.c | 9 +++++++++
 src/wiphy.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index ab8aa6c0..021b5e38 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -137,6 +137,7 @@ struct wiphy {
 	bool registered : 1;
 	bool self_managed : 1;
 	bool ap_probe_resp_offload : 1;
+	bool supports_uapsd : 1;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -910,6 +911,11 @@ bool wiphy_country_is_unknown(struct wiphy *wiphy)
 			(cc[0] == 'X' && cc[1] == 'X'));
 }
 
+bool wiphy_supports_uapsd(const struct wiphy *wiphy)
+{
+	return wiphy->supports_uapsd;
+}
+
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size)
@@ -1830,6 +1836,9 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 		case NL80211_ATTR_PROBE_RESP_OFFLOAD:
 			wiphy->ap_probe_resp_offload = true;
 			break;
+		case NL80211_ATTR_SUPPORT_AP_UAPSD:
+			wiphy->supports_uapsd = true;
+			break;
 		}
 	}
 }
diff --git a/src/wiphy.h b/src/wiphy.h
index 5cf22537..1056ac0c 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -137,6 +137,7 @@ const uint8_t *wiphy_get_rm_enabled_capabilities(struct wiphy *wiphy);
 bool wiphy_get_rsnxe(const struct wiphy *wiphy, uint8_t *buf, size_t len);
 void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 bool wiphy_country_is_unknown(struct wiphy *wiphy);
+bool wiphy_supports_uapsd(const struct wiphy *wiphy);
 
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
-- 
2.34.3

