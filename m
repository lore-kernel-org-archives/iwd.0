Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC184A0D
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 19:40:14 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 129so11053289pgc.5
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFwQHPNxTIQWD5h37XE7nQD349EuDvcEBURNEJ1SRf0=;
        b=WUupk14se/5VHkQj9hJ4HDrQ9HFzr2i8jqkcf4LxLuc4oQtHuYfp4ryAqvPOYzc/8K
         ZCEsIA2Cj5LK4oIQDtZymmuEny0PFG4sNaIm0VIEDcjTJuko0npRK1aePsuqlpKqHxBu
         /6cROzKhkGXFYAW6JdmX8U2qJlUvmcqu39binDqOxrwVqi1YcOJP+kdQfsLf+sxDwS9S
         4Z1L0CMb5H47exUktW+wn2evB6GP1wXcdXXxyI8K/ZbcL3VNDWH4IFYHAKuAHVFMK9qr
         WAn8R1HAH3Mo2ouebRNWtP+UAZQLCoc9+q8orN6TyEQ+Qx32ZJqPmgcrspGxVIBjDb+z
         54TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFwQHPNxTIQWD5h37XE7nQD349EuDvcEBURNEJ1SRf0=;
        b=BydLtsG2ErxwXjKlJxFx8pYrM4OO/enj5KCp/cecHga5H2woqATOdmSunMQLh9iMr1
         aqzQ+vJZbRt7IZ35tff3l4M1eXz3lBX+EPZGI6fiYXmqYyxat6kly9xlR5LtUUjWipPA
         OgCyi+aFxUlWor/+dIjScOaKY+jv0KDswFzniqH8hPyR1BJMhYE5TJtrRy4KtAb+9UqD
         MElis3HQEqANoIPfb8ZH346fKqjJry2pIyilo5nj0+9VhZxoMv6lFV8O0i+LRL4WMOgx
         KnA+la0M2/zUFYuNfExgqzZYwDu0VJqKJLLlAY3wZawkgZQTToOWx5UfjBFDYaubLj15
         aD+g==
X-Gm-Message-State: ACrzQf0W26ZaeByi+bdYwzvxS1sDyF+GLJ9/k4hgkycY9sVL7HhJvxfp
	zj7NhNCSKKZ0JuhuKUsJ0pCbczprTSM=
X-Google-Smtp-Source: AMsMyM4KIx+bYk43x7isq8rbE7CaTSWcPIaS6Dz6dHPrSp3W5IYzXlKR/dJ2jiUVSk2zKu/J/klhag==
X-Received: by 2002:a63:4042:0:b0:43b:ddc8:235 with SMTP id n63-20020a634042000000b0043bddc80235mr18081993pga.498.1665430813862;
        Mon, 10 Oct 2022 12:40:13 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i4-20020a63bf44000000b0044046aec036sm6486995pgo.81.2022.10.10.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:40:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] station: skip disabled frequencies in neighbor report
Date: Mon, 10 Oct 2022 12:40:10 -0700
Message-Id: <20221010194011.55962-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the disabled frequency list to check if the neighbor report is
including a frequency which IWD cannot use.
---
 src/station.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 19cba680..f138846d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1813,6 +1813,8 @@ static void parse_neighbor_report(struct station *station,
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	const struct scan_freq_set *supported =
 				wiphy_get_supported_freqs(station->wiphy);
+	const struct scan_freq_set *disabled =
+				wiphy_get_disabled_freqs(station->wiphy);
 
 	freq_set_md = scan_freq_set_new();
 	freq_set_no_md = scan_freq_set_new();
@@ -1849,8 +1851,9 @@ static void parse_neighbor_report(struct station *station,
 		if (!(band & wiphy_get_supported_bands(station->wiphy)))
 			continue;
 
-		/* Skip if frequency is not supported */
-		if (!scan_freq_set_contains(supported, freq))
+		/* Skip if frequency is not supported or disabled */
+		if (!scan_freq_set_contains(supported, freq) ||
+				scan_freq_set_contains(disabled, freq))
 			continue;
 
 		if (!memcmp(info.addr,
-- 
2.34.3

