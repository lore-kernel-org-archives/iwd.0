Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6204A0F
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 18:47:40 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id c24so12989799pgg.11
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JmingVSDa6aIkhua9EWpczKHECzAoIMQ6GHEYWePYuA=;
        b=aWT2ABj3oi2vScxzJqDuBb0dSUawioZmdLRcThDjEm+O6dHxgc+SX8LIAyC1m1PFuk
         RwS6x/3G/dfBR2hefycGlapJKY203PO76trcAOcJXCTOk5VlJPdLNJK6ZvXge9i2ERTm
         CuirPNSq1nZXkzckGZcViKAUpB9EEbBdybwDqYOFxQX7e7BwDWKje6R5elrvXMj9zhOm
         rjHkBiPZZPVJaqhUHQBz+2eM+rDAAbfJyycbmCXFpk5kwztxqoaNlmcbM2DtYdfLgKAr
         6klxOZUuqzRzAsi8fscs9p3ax8wjZ2gCY524fWSjA0bv08XfWXbOcFq7wBi2lYeHRQ23
         /QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JmingVSDa6aIkhua9EWpczKHECzAoIMQ6GHEYWePYuA=;
        b=PVA+4AdspC6Gmz12Z/BD675maqc2hpO8nfNfuBXm8urJ7EqKH6xHaxyGSUa5rDquc7
         0nj4TYea8V5Cak+bT9yomWdhSy/EruBSR8mi4A0kbYUxRanrD4XeZXYw411+suRPlqjc
         JAL43RdbA8x3uLbOBqdvdsi48dz7jstUilo0Qa5tPefSXL6WwIWk0sy3cLuBrsDuinyk
         5KNSs5wAqK1tATJ/C2C4OT1EY3TaGuxgj1Zv1RjyF8DGPxsO/UzldJKFsImolPH0gsbz
         i5+YPNdsiNnC2RDcG+368gOU/xDVirF0ULk8DNK7UlICRDNWywWVhXL9RhKOlWykO4Wn
         ZKfQ==
X-Gm-Message-State: ACgBeo1EmlTuxjyitHQLqyjsQH/xGSH03bKULsjYOZuNAbS5dLdaWTv1
	c2kEqf6rUFjyeS2MDTiXTkCXutzB8B8=
X-Google-Smtp-Source: AA6agR6Kx8R2CdvStdbR9Lp7hR33OL0VYaYwEpWcDbQ85zgrvcl/dnjmMt1ULVptlb0KLDAOto0Wlg==
X-Received: by 2002:a05:6a02:185:b0:41c:30f7:1fea with SMTP id bj5-20020a056a02018500b0041c30f71feamr279880pgb.487.1660243660181;
        Thu, 11 Aug 2022 11:47:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0052b84ca900csm24986pfh.62.2022.08.11.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:47:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/6] client: fix station autocomplete with multiple phys
Date: Thu, 11 Aug 2022 11:47:34 -0700
Message-Id: <20220811184735.465951-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811184735.465951-1-prestwoj@gmail.com>
References: <20220811184735.465951-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limitations of readline required that the autocompletion choose
a 'default' device. With multiple phys this doesn't work. Now the
readline limitation has been worked around and station can look up
the device for the command completion.
---
 client/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/station.c b/client/station.c
index 90291c88..b070807b 100644
--- a/client/station.c
+++ b/client/station.c
@@ -280,7 +280,8 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 static char *connect_cmd_arg_completion(const char *text, int state,
 					const char *device_name)
 {
-	const struct proxy_interface *device = device_get_default();
+	const struct proxy_interface *device = device_proxy_find(device_name,
+							IWD_STATION_INTERFACE);
 
 	if (!device)
 		return NULL;
-- 
2.34.3

