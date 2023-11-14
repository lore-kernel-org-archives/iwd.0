Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619F41233
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw/+1MEG"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f256362bb5so3496844fac.0
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982145; x=1700586945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLJ4CbftyEwGDpwZnUaAvHEO/ek/+V6kucfAC1ivfHU=;
        b=Hw/+1MEGpS9cUCXEyjCJLMzzNNx/3uIIB6KZQ9749pEnPt32yZzckhW11iXKqLt+2t
         BcgEg65eMn/TZstWotvVwYSYuttjWXJV2zRidSM99CcxZ78ZP/hAYdU383qJug0nmZrH
         mO0ZkQXQL6Ojw3xszXLk0wfDL7TXpmAiUmoZP3UKz/hBdRL+7zFPC8ZJhatLUKMxslRd
         B2ZrF0w29CFwdRLHfTsBsP7qYg2B7kqcwKITWt2KTghFj8YTcaUo74wKak6WU4NsHMxY
         bDET7Q210yMF4AJlmPOKOUS8ecwrN3TSZhZBJeOF6Rmrw+cBPzerOPLtV6CiDs105Qnk
         e+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982145; x=1700586945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLJ4CbftyEwGDpwZnUaAvHEO/ek/+V6kucfAC1ivfHU=;
        b=FCPMSRYVP5TYk3r3/AifUEIkWzOueLxEodC3DPsDbTDVu1U5EFyMN/IRWrOtYQUMS4
         A0VzfwmBEwdbPZZkqGESc1fLjcX9+aT4m41hV8GNIli08bBZq3e341r6zrEdRhcbruYm
         vvBkDVfL2folV9WDKwPdZ5jrDKUxtGVo6qOEObIyeGmb+iHeH4vJOw0AFHsSPmk/pPzM
         iNW8YReUowUtzIeq9hHVv/FHdZDu66pkqAEaWzz0TS7y4TBFZgwy6O44sVzkU92Hz3gu
         eCQUkEt4SRF+lcKmaWtQ3t6M/aNnsVW9WSC/EHZGg1mhdQ/YcWaOuvO5UjE82ayAUk8a
         DT5w==
X-Gm-Message-State: AOJu0YwLQcSdhTLrEtxUHq5OFMutp7bQ5zE/MjCIrD/Oge6uwC7Asl6U
	iBVGTjSCkxBhtnBvIb1ZAf3WPOL102A=
X-Google-Smtp-Source: AGHT+IFQeRAfsAyZq1RUcSa1Tu9y5LvTFea0AG2kay/tSOe9GGAmZ9xwonHKW7s/cVpsEqZMF7YVQw==
X-Received: by 2002:a05:6870:f813:b0:1f0:630c:a589 with SMTP id fr19-20020a056870f81300b001f0630ca589mr14034958oab.46.1699982144991;
        Tue, 14 Nov 2023 09:15:44 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:44 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/11] netdev: sa_query: Fix reason code handling
Date: Tue, 14 Nov 2023 11:14:25 -0600
Message-ID: <20231114171455.1108856-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
References: <20231114171455.1108856-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason code field was being obtained as a uint8_t value, while it is
actually a uint16_t in little-endian byte order.

Fixes: f3cc96499c44 ("netdev: added support for SA Query")
---
 src/netdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 49854b16d846..72876f3a39a1 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4956,8 +4956,7 @@ static void netdev_unprot_disconnect_event(struct l_genl_msg *msg,
 	if (!hdr)
 		return;
 
-	/* get reason code, first byte of frame */
-	reason_code = l_get_u8(mmpdu_body(hdr));
+	reason_code = l_get_le16(mmpdu_body(hdr));
 
 	l_info("disconnect event, src="MAC" dest="MAC" bssid="MAC" reason=%u",
 			MAC_STR(hdr->address_2), MAC_STR(hdr->address_1),
-- 
2.42.0

