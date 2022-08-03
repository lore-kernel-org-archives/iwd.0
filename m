Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70CE4A39
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:49 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id y141so17615870pfb.7
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5dXLDzm5ZoVh/QZZLoBxLrqU78WaG8gM58pZupUtge4=;
        b=Jw57z2iDweDGJHIA9NqSc5WUAsvwEZXtddDAAZCqcg3eWwYiw1qc6XwlE68lL2R7mS
         q3CnxB+xK9LNF1vMHPFXNR6fMZB3MKzLXwCF8hecsTr1i9EbPUzgGk35/8+lMD/et6HI
         yRKKZGH9Gt0ZiMPkGpTsKRD/EtEuGa5ic5NjyxfFFhdDlQhgRRIspUAppSeHznTtxb7H
         rC6LRlYANu3bH8KJiDo9AQAJiLYKmLAOnr1tZnBBL8uqtG7gzUVCjbUlZBbIVsVQalQw
         KSSxFRLKK28KB/m2CWoG2F0WR+14LBtkUeWFCAIQ1/rHWogqkv8xdU7UNLacXM5DrLT1
         mWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5dXLDzm5ZoVh/QZZLoBxLrqU78WaG8gM58pZupUtge4=;
        b=ivdXi/d3zQzQoB15MsiY8rC+wMyv5WQyI07O2EcoCAz/YYOKXuxmi4og+6NikHvC99
         utmfNrzkXWTxEtGK8xMWsYSGifvvlhLdxG3udraFuSQvF3OPEXuyCJwP7kEP1ofkbTB/
         Y5m+uqtlVsipIod/VWKNE5AzzkZ176sPExF6V+c7VS1DK2ADzU389/HpL/lDaQWYh906
         G5L6K9F8zYOUZRnLaFdQCdAf207MJtEzfyU82/snaWDkU4qCFiIUzSZVp4B0CwzyidCg
         JI/6YgGcBWwiDukLk5qIjjTEgYP4gV3i7sn+28yIjQqeU+4OvTubTjLaiyW6kUnEzE0q
         MkPA==
X-Gm-Message-State: ACgBeo0+t5A362B3ihfHCarmGDNRL/oSnuuQ8ypDE/T50xVn3Ww31Qcs
	Jqjn1/F5d0URFUyS+NiqcuhK0BFKRmQ=
X-Google-Smtp-Source: AA6agR4uvMK1vZ1i9ZOJHQad7ByH7K/bfG3Pzk0ydWJdE4PFlHtmEWWRHrRa3b1Bcm9/wtwUwyTufA==
X-Received: by 2002:a63:484:0:b0:41c:cb1f:a60f with SMTP id 126-20020a630484000000b0041ccb1fa60fmr885777pge.546.1659562608921;
        Wed, 03 Aug 2022 14:36:48 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/13] wiphy: track self-managed flag
Date: Wed,  3 Aug 2022 14:36:35 -0700
Message-Id: <20220803213644.277534-4-prestwoj@gmail.com>
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

Check if the SELF_MANAGED_REG flag is set and set into wiphy.
---
 src/wiphy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 2514c95a..4a778699 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -133,6 +133,7 @@ struct wiphy {
 	bool offchannel_tx_ok : 1;
 	bool blacklisted : 1;
 	bool registered : 1;
+	bool self_managed : 1;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -1647,6 +1648,9 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 		case NL80211_ATTR_ROAM_SUPPORT:
 			wiphy->support_fw_roam = true;
 			break;
+		case NL80211_ATTR_WIPHY_SELF_MANAGED_REG:
+			wiphy->self_managed = true;
+			break;
 		}
 	}
 }
-- 
2.34.3

