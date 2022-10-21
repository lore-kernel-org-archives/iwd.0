Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB331612B
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:49 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso2357958oth.13
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjH3kURmk/t18sxDQeCNvexvMtP8PUFBfraBGFjCa5c=;
        b=Iekjf/j9QvnzG4ZieOmleiOFMhkQUPKnousqfThDxOujE+agur/NBQ7EIHAb2cfx3x
         dMHDwBD5zceqReB9XRAOb+kSlQL8rImTo+5P+BIS36q5KALkTEps8QHwzxzIQozZajC8
         +cgzCcDvrZviH2KIcw3QuoydWj7ggJlx7e0cSsZ77cXRfeStGG8Cap0CoijYfSo/jZFs
         IGNH9wWv+xYKoqjAzlkaeS6POV68rrGixXKGqBgWkgTzV9mhf5pK0y0xRKNVWoVXm+N8
         vy/LfP69T3iiEEJimVC1bHaLEi0OQ02gGb4RV8Ei/PDLiDtIK3NrS53skBSbJDWAZFxp
         aOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjH3kURmk/t18sxDQeCNvexvMtP8PUFBfraBGFjCa5c=;
        b=sD6Ku3gOHigxtumaOj4jZ5kxsi2jTPbtM98/hkro78Fwvbb2ij1+mmzlSH8myC3U29
         JSIn+kpoxXe91abpaT3kd6EPx2JM/AHWs+CpvUw93Yi3kKegNPE/53okOvQigRlQpscv
         1gzhJHTbYfxe2aWoHx1GTPt6uRq9/L+VaEJiTkaeF1QLL55Fo2+YgR0wAm5zQGRVyoqX
         hRKWvKMK+X0Yfnge387Io9iwtZmOFmxBRpuJYgwugAiZbyQnSTWoNO/pBGKK/O+/0XhN
         fldcu9KZunGUPW3N9B4wy1LXGoqyqUgCTECdFccNUOMQ2CA8b4IVDXgWLozwSpW/zbwA
         3Hng==
X-Gm-Message-State: ACrzQf2y4fEH5vnhyeZ1SJyzyzVIbrDSFztxSGrJTydXLCcpE9fytFQI
	poTCPsGHdmFHjVOisRBfOdXrJ82PFwg=
X-Google-Smtp-Source: AMsMyM5fv5uaIruJxSK81KwENUnTBiZ9xACDqu+UwMQYyydr1o13mSyP7Zis7LtUnq6VCnY+wihQrA==
X-Received: by 2002:a05:6830:4b5:b0:661:d8ee:b4ac with SMTP id l21-20020a05683004b500b00661d8eeb4acmr10340769otd.296.1666379628909;
        Fri, 21 Oct 2022 12:13:48 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 14/26] station: diagnostic: implement PairwiseCipher
Date: Fri, 21 Oct 2022 14:12:55 -0500
Message-Id: <20221021191307.31492-14-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/station.c b/src/station.c
index e0c163fb7e44..11e86d1f06c2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4509,6 +4509,21 @@ static void station_get_diagnostic_cb(
 				diagnostic_akm_suite_to_security(hs->akm_suite,
 								hs->wpa_ie));
 
+	if (hs->pairwise_cipher) {
+		const char *str;
+
+		if (hs->pairwise_cipher ==
+				IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER)
+			str = ie_rsn_cipher_suite_to_string(hs->group_cipher);
+		else
+			str = ie_rsn_cipher_suite_to_string(
+							hs->pairwise_cipher);
+
+		if (str)
+			dbus_append_dict_basic(builder, "PairwiseCipher",
+						's', str);
+	}
+
 	diagnostic_info_to_dict(info, builder);
 
 	l_dbus_message_builder_leave_array(builder);
-- 
2.35.1

