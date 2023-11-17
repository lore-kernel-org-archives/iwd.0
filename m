Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AD328CB
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHkQW7+m"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1875399b3a.0
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700230351; x=1700835151; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOd+VfNw2Gn2g/y6YZ1nP1jtX18jztzEBXbLWPoDRFY=;
        b=OHkQW7+mDfHTFe4CVa8EqgEUTH/Vms8Ecp+IEogHajnWq6WLfI4JEDMoK3yEJVs8uB
         WUl1EsY7YwEnyDVRAOrd9sz8XbqfRCgrc4x5PyHs6HGk6AzrgVBD0ts5QY8BADWX8xgy
         C1OURgTh9bfn3o9ecI3hqMItTIus3LekFuss3xLu2WwQ2UUBpG7ER8TB5X1O3dNZa0dc
         liRK6Kam9dXqDDEN9EeF1Bynlq6JiA0Zxvr2OfWgu5cTkwelqIr6jh6Ln4U5r4LisrDy
         /joRXTmd3/j88upCPztfbfEF3XsSX/MCAEqJQs5qAqgvZ7nACddHGWlfe70b/RcHuJal
         0M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230351; x=1700835151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOd+VfNw2Gn2g/y6YZ1nP1jtX18jztzEBXbLWPoDRFY=;
        b=aNepOQLtI+U3kjYHlcZoHqtfhLOu4Fgg0UFS9NBb4yepgURRXBON/oOpmOif+3zGXV
         OJZBN6KeOiSueSVMzGDL0lhIGPSclE9TSXl2U3lT4m76z5yRUy9R7jd6KKhNweuevsJd
         Sj2QlJXM7AGvVO5AjduMTSj9INzAX/GP34Lc8lvL4kfqmrQH3i/L6AOVgFqwrdAsGB3c
         zT2AkkOJjv2M2x3gF5i8zc4/YoCIBplePkqsy2lCgYy2CSdzXDWQ+ii/HjPn0YvclXs4
         1ob6NfTewBzYNNTGUYWITN9MVVQRETos9HIiXY7IshDAvBNmqaa0DlXmYQ3HLusKv6X/
         E2TQ==
X-Gm-Message-State: AOJu0Yzxow+a+URGCJZAQGjIhoxzwYkOUhXf/5x/Vpb0aImRykNljCKp
	PhsTn8KsRZetLQvqoflCensW0WH8r4VZZw==
X-Google-Smtp-Source: AGHT+IFl5cbS20n7GrU2K1sbCnYImBXFTcQjhyF2Os6lbCCs6WAu0gHGwLmK/OGPj15yu0rglsn2kg==
X-Received: by 2002:a05:6a00:bef:b0:6be:2e07:5c5c with SMTP id x47-20020a056a000bef00b006be2e075c5cmr15695703pfu.20.1700230351505;
        Fri, 17 Nov 2023 06:12:31 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79398000000b006c4db182074sm1447897pfe.196.2023.11.17.06.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 06:12:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] dpp: include 3rd party settings in network profile
Date: Fri, 17 Nov 2023 06:12:25 -0800
Message-Id: <20231117141227.60722-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141227.60722-1-prestwoj@gmail.com>
References: <20231117141227.60722-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the configuration object contained IWD's 3rd party settings set
those into the network profile.
---
 src/dpp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index f8d76805..0064187b 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -837,6 +837,12 @@ static void dpp_write_config(struct dpp_configuration *config,
 			network_set_psk(network, psk);
 	}
 
+	if (config->send_hostname)
+		l_settings_set_bool(settings, "IPv4", "SendHostname", true);
+
+	if (config->hidden)
+		l_settings_set_bool(settings, "Settings", "Hidden", true);
+
 	l_debug("Storing credential for '%s(%s)'", config->ssid,
 						security_to_str(SECURITY_PSK));
 	storage_network_sync(SECURITY_PSK, config->ssid, settings);
-- 
2.34.1

