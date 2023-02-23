Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013532F2A
	for <iwd@lists.linux.dev>; Thu, 23 Feb 2023 18:14:21 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id z2so14164363plf.12
        for <iwd@lists.linux.dev>; Thu, 23 Feb 2023 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqQLC+YqVjBTf+SVPVv08aG43iKbqZtKviJGYQ/UurY=;
        b=iewkOZAt950OIbJtyAQJaSbSYCiDx5SpFp7OcWiLX8Ag1a25ePuGfvVQISKGhnJzhc
         qYDAEyN0lLAm6JqNJw1MGgJLd6Z1SnNO61ZHs27WJgurfbgwi/xSXmLvwL1QPmtf7rQY
         5wmJ8lfTwUbbC7pFUZJp4g8pI5knncJUEkPVoMRc5qQNfjalZU0pmvzk1dFvsGz6bLCO
         j4LWDi/iq9TGou+J2wlYdN7Z5C+U4QmoLREImJihMCEUQvD0f6Wnz2tC+RoSPPQEBHsZ
         u9EJLYnsHClz5KGRvV0d/6qJTtfQtFev1tleX/kO5do6703NvMnIFjRguS5zWw0dr1nz
         uP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqQLC+YqVjBTf+SVPVv08aG43iKbqZtKviJGYQ/UurY=;
        b=TPIRLxf6pwfwfAPGQXT6yMCgvUg46pp9ZvsEhiLf/0r+Xo2dRVx20C+4aqmRzn1ezY
         XEoo8Q4TbouwPq7aETa0nA+nwLoipqo9as3TqLVPaoCnMZbZgDpOkz5gB9YD9EX7md7W
         U4OYFXxdnxL9KvPEnLzLI85eH3NuoxqLCEYnj9RTJo3Mt3kG1yL6VewUnZL1+O9b3uxh
         Pdl/5Xad3izOguzi/vvXCxYEF/r82CAamEqmUaHOhc2eBHgaehyegYHrlCpG+9TCuSzM
         irL1DFR+bU6mKMsIVhLcE7jDxTvuaEgrKoWhDMutAD4FMpUomwArSevjUkyxqHzZmfQv
         cl5g==
X-Gm-Message-State: AO0yUKX7wUZv3ztYyD9KkkCFy4TT9a/zK9xoDmtp0gy/qXdS2DHWd5Ia
	fDRzYAbTEjR6wPiPUtlWmQOCOm2HPj8=
X-Google-Smtp-Source: AK7set+9chpf/42mveEF4imqsY1e4t1DNi5eW/VL1QE0l9KxpCsWs96dnuPfqTO3O1GZCgsY+R2pcw==
X-Received: by 2002:a05:6a20:50f:b0:cb:7958:7071 with SMTP id 15-20020a056a20050f00b000cb79587071mr7922339pzp.19.1677176061099;
        Thu, 23 Feb 2023 10:14:21 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x9-20020a63aa49000000b004fc2582aedbsm6070173pgo.17.2023.02.23.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:14:20 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] monitor: print contents of beacon head/tail, and probe attributes
Date: Thu, 23 Feb 2023 10:14:16 -0800
Message-Id: <20230223181417.1384624-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 25a15154..a7ce2412 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5068,6 +5068,16 @@ static void print_probe_response(unsigned int level,
 			(const uint8_t *) mmpdu + len - resp->ies);
 }
 
+static void print_beacon(unsigned int level,
+				const struct mmpdu_header *mmpdu, size_t len)
+{
+	const struct mmpdu_beacon *beacon = mmpdu_body(mmpdu);
+
+	print_attr(level, "Subtype: Beacon");
+	print_ie(level + 1, "Beacon IEs", beacon->ies,
+			(const uint8_t *) mmpdu + len - beacon->ies);
+}
+
 static void print_frame_type(unsigned int level, const char *label,
 					const void *data, uint16_t size)
 {
@@ -5122,7 +5132,10 @@ static void print_frame_type(unsigned int level, const char *label,
 		str = "Timing Advertisement";
 		break;
 	case 0x08:
-		str = "Beacon";
+		if (mpdu)
+			print_beacon(level + 1, mpdu, size);
+		else
+			str = "Beacon";
 		break;
 	case 0x09:
 		str = "ATIM";
@@ -6240,9 +6253,10 @@ static const struct attr_entry attr_table[] = {
 	{ NL80211_ATTR_DTIM_PERIOD,
 			"DTIM Period", ATTR_U32 },
 	{ NL80211_ATTR_BEACON_HEAD,
-			"Beacon Head", ATTR_BINARY },
+			"Beacon Head",  ATTR_CUSTOM, { .function = print_frame } },
 	{ NL80211_ATTR_BEACON_TAIL,
-			"Beacon Tail", ATTR_BINARY },
+			"Beacon Tail", ATTR_CUSTOM,
+				{ .function = print_management_ies } },
 	{ NL80211_ATTR_STA_AID,
 			"Station AID", ATTR_U16 },
 	{ NL80211_ATTR_STA_FLAGS,
@@ -6520,7 +6534,8 @@ static const struct attr_entry attr_table[] = {
 	{ NL80211_ATTR_PROBE_RESP_OFFLOAD,
 			"Probe Response Offload" },
 	{ NL80211_ATTR_PROBE_RESP,
-			"Probe Response" },
+			"Probe Response", ATTR_CUSTOM,
+					{ .function = print_frame} },
 	{ NL80211_ATTR_DFS_REGION,
 			"DFS Region", ATTR_U8 },
 	{ NL80211_ATTR_DISABLE_HT,
-- 
2.34.3

