Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE23EAE6
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:35 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6093294f8f.0
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857073; x=1689449073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yCJ7vWHrnEqowV/OY8D3jMzm+pfTH9J9oDFxER61Uo=;
        b=NOyFs9n0IzADM+nTW449gvawkbm/K/wMWhzGckMstL5a4Igp1s+J1cVKMJhGJrRITt
         N+HZjnDDn5AkEANaKhC0bZLFo9sd0JMRKuo8p+wnSYaBclPmv6xu9h7sRlKgd+Fsl+E8
         dspyMTaQlJuczFckFapH9qqXcnTsGhjOWTeTqh9NpiOtrvU7uYaFzYfy4RRal0kReUy4
         AuwTUJJ43LTYjiI9jXsOlR1cgVlbNCq4Ug9MQgbZS1mBfjZ0ZtWvsIv8bUryaCFpMmp5
         JHwVPj5DlIusXDeXIsGT1NbHWlHFLkFQDE6/7H7pZNK5/lYtYcWqZHSCIRM8qmB4RkEr
         dAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857073; x=1689449073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yCJ7vWHrnEqowV/OY8D3jMzm+pfTH9J9oDFxER61Uo=;
        b=Ty/5yo3hzdZ4gHnsLrUBfu4qa+nQ16Y6oMaYU3mK5Y8NKsOsFCUbkmYTuqVsYboC/6
         BF9z5ChZUWAYNk9j8mGnDzG+X/fM/jJjpRNvSeYwpfoQJlkyPHWTesrPLp9WjR83SnQi
         5905EeiKzXHbe4lKSu83IlVarK693WA23JFOJFf1Nz/bV73Rpig6sfM/7CeLIJf0CgoA
         sAAA+tyKTZQqdg2zQiW3yG/HQ0WfREbMSNwyzP3YoVrhsS75oNXp3OLEhtk8oJr3E4Go
         xXfn1aO4DS9uOl9PuFxIDdPCyPMW6hwGPLOY1cqxn0fTvBJV3I8UsbzFUTPYchsGl7oD
         eo5Q==
X-Gm-Message-State: AC+VfDzXqA27sySq0y+TwNZvFUR0Mx58AMR5+jrWAjcrHZ1U6toi6fMT
	iFP2ppE+SMHznzwEILs/Kgsw6wohFQQEQg==
X-Google-Smtp-Source: ACHHUZ4mtR23/B4bhWRIPdCSw8zHqjf++M9ZMlsWq+n2txVNI+23LtWbaFu0cKeE7FxNsZZ8zRn2Pw==
X-Received: by 2002:a5d:5257:0:b0:309:3a1e:fc54 with SMTP id k23-20020a5d5257000000b003093a1efc54mr10980814wrc.7.1686857073250;
        Thu, 15 Jun 2023 12:24:33 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] doc: Document [DriverFlags].PowerSaveDisable
Date: Thu, 15 Jun 2023 12:24:15 -0700
Message-Id: <20230615192415.1718516-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615192415.1718516-1-prestwoj@gmail.com>
References: <20230615192415.1718516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 190f2c69..6b52b040 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -403,6 +403,10 @@ are buggy or just don't behave similar enough to the majority of other drivers.
        not be used, and PAE will be used instead. Some drivers do not properly
        support ControlPortOverNL80211 even though they advertise support for it.
 
+   * - PowerSaveDisable
+     - Values: comma-separated list of drivers or glob matches
+
+       If a driver in user matches one in this list power save will be disabled.
 
 SEE ALSO
 ========
-- 
2.25.1

