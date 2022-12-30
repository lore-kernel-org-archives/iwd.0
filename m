Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD653A7
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 22:12:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id jl4so16860883plb.8
        for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS94VCVRl/ADcj2j5sCYXhMC74ZR647N7uYbLzjxxoQ=;
        b=C6BuK7XZti79ccBnIDnYESwhJQRjer9posQr+yecgRzed8EQenHNsiZtmLlzXRNswD
         qs11B/L1GoIBbkVDU31+G2QcD/nNtBJ7kP3iADRFz4FJhP2LLFw+fbz+kzhv3LiPjpMp
         vstsDvxM7nVMYUPSOtGltLxPIZ9EL6Sa5Nfd6muHxPAgfW9zoXMT2iS0Ay7T9sL5KcRh
         wfP84Isszd7H3+e7alKvIexxeDrRrqd3yxYV6Yj/tWLFnBZODNe0Um+kmiOahjefEw0H
         U55ct3OPf1YXGaZFHu+ZgfFWDK05l82OmAABa9GTHNjKtY35/UbeEt3vtjvuDrRVIr3z
         fyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qS94VCVRl/ADcj2j5sCYXhMC74ZR647N7uYbLzjxxoQ=;
        b=YBWERV0ZlOY0iXJUTFxYc41VMqA9vAAaHUp/whuw22VyVvjyeKsQBhpdq1+jD3VS67
         oeNFACGitJbffHHMmxGPAX6rGfokv6oMthCXHFmjZoxHhT+L4Bjnw5kxAlaT65TJ4yIe
         g1tvAxadhQqTseFIFOwB/JqQKlYl2L0DZ0mN4Ojb3xfaZlApSIDSONXOJa+lTqyjFXt/
         u3XcIWtO3gifAdbJQFuXx6qAo4NwGqcwNopR38jkIiIQSVrjE4cerwvyz0eNQ26at/jf
         AFsK/f+IG7P/7xWzBABRxtzq6iPWOkYZglmwYvBplsv2mU2ZMhn6JihDfHEO3TvFsuLf
         98ZQ==
X-Gm-Message-State: AFqh2kpgomiDI/MFQkR3wZ99nV3EMm4fk3o19NDEoiEmiSNN7Kfn17ir
	S7xfGuUlTAaENX5LoJ3wAsLTtemSs9M=
X-Google-Smtp-Source: AMrXdXtfwxUjKWqW6geQwdcYcCavTW8L78HlS3DMpgVoET5ldaGSTS2A7tqjSZH973KpGtO9jrP53Q==
X-Received: by 2002:a05:6a20:65a9:b0:a5:df86:f0e1 with SMTP id p41-20020a056a2065a900b000a5df86f0e1mr51452495pzh.16.1672438344218;
        Fri, 30 Dec 2022 14:12:24 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00528a097aeffsm14187833pfy.118.2022.12.30.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 14:12:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] nl80211util: parse TX power in frequency attributes
Date: Fri, 30 Dec 2022 14:12:15 -0800
Message-Id: <20221230221216.2985011-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221230221216.2985011-1-prestwoj@gmail.com>
References: <20221230221216.2985011-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 400871fd..8cc3ea39 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -548,6 +548,9 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 			case NL80211_FREQUENCY_ATTR_NO_HE:
 				freq_attr.no_he = true;
 				break;
+			case NL80211_FREQUENCY_ATTR_MAX_TX_POWER:
+				freq_attr.tx_power = *((uint32_t *) data) / 100;
+				break;
 			}
 		}
 
-- 
2.34.3

