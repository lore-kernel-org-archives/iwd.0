Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8A6138
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:57 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id u15so4318101oie.2
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74q1P5RcsX1FHWF2pqVTy+LDchQUI6twF0RQTqfeG28=;
        b=dc24faqGgAr9xNWY/LBy1L8FBQZEyi4aiVYJe6H1/n2R+JL+6iIu9Ticnk3hE/GNNI
         TSmpZWPwjYQ8i2tmol9n0vlWIFREq349vZGik8i8ucmy8svKnP/oa09N4lDXpRMB2FR3
         5gjWcti2ya6V1F0d3uYTwFNJ2tFduSdHQIoQvu4A6nUixRPvFAwt1bjN5zhDiJEN0DHz
         HlMmW+WRJlYhBFGC1ALdteXAA0wbeC0PBsYEMRnbLG1BOiAt2jSWXuzWMgsJO3Dbp2fj
         ZIVpzqdful9XpcMqfwaBKkhcFS+rry5CIZ1dC2lj/Fic7GopJnyJbH15SBNkZtNnfm9j
         ZoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74q1P5RcsX1FHWF2pqVTy+LDchQUI6twF0RQTqfeG28=;
        b=E1VtieK2EW5feA9A/cfBWjzWiJQYHsXr2TzvGNgLBchmf+2qz7adfCONBSxvkSMs3C
         sjt8C6/DO8CpFyRiP7RXLzEBmfB3Djz0IdYDMuJ+H/Wb41Cjr9KolhY0g9A4+okiED1w
         wgeoXH4nxmm7+reS6/ZFdniaPaNkfFc1cGBs4/m0u21S9Z2khapmO5/ccJIcdCj4XTSX
         JVoqQpFnhmvVevPol/Bijyv3oUtuEBfIgsd4IdoRsVDT/6e8IXvlB2e2qceRJq4pdobK
         hoQn23xyzNJtXuDo3SvgqahjtceTb3At0Uy+HcRXTkXHDD1IhvxTycDCLgXxZnn42x6Y
         ovmA==
X-Gm-Message-State: ACrzQf0XUyrXDDA+X+I9LqfE25r29RISQiEI3b8n6s9X4gYyPcHcaXtt
	qARAMHvN1GVVe1KmAKAJ+vkLGsQgSdw=
X-Google-Smtp-Source: AMsMyM7xF5JL49NwyOMHmTM6u88eMph+GKau/Z96QEPX2TvKLA75NCnKWs1JWz1uuA5Mg+KTLHoC5Q==
X-Received: by 2002:a05:6808:ec4:b0:354:475a:c101 with SMTP id q4-20020a0568080ec400b00354475ac101mr11100679oiv.56.1666379635787;
        Fri, 21 Oct 2022 12:13:55 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:55 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 18/26] ie: Add IE_CIPHER_IS_GCMP_CCMP inline
Date: Fri, 21 Oct 2022 14:12:59 -0500
Message-Id: <20221021191307.31492-18-denkenz@gmail.com>
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

Similar to IE_AKM_IS_* functions
---
 src/ie.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index f447a4f98d81..e69175635908 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -390,6 +390,14 @@ static inline bool IE_AKM_IS_8021X(uint32_t akm)
 			IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384);
 }
 
+static inline bool IE_CIPHER_IS_GCMP_CCMP(uint32_t cipher_suite)
+{
+	return cipher_suite & (IE_RSN_CIPHER_SUITE_CCMP |
+				IE_RSN_CIPHER_SUITE_CCMP_256 |
+				IE_RSN_CIPHER_SUITE_GCMP |
+				IE_RSN_CIPHER_SUITE_GCMP_256);
+}
+
 #define IE_LEN(ie) \
 	((ie) ? (ie)[1] + 2 : 0)
 
-- 
2.35.1

