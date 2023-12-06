Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442E6F617
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJvJATrK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d05e4a94c3so1399935ad.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893890; x=1702498690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8htIAC9kRG6RYa6OvogGIifB3FzQt1zgdxaJBwAA+IQ=;
        b=nJvJATrKbMg09Wj7a4W2yab+rf5AEC9UQ1s+MiAxAYZGzBVZdPKWrCGfmZE2voAwsB
         vSj3oFrqCNeILo9ROw0V9KAueAxA+4d/AQvBwG18QkKCp1Cpmt1Ays/VAIsH3u/ATDn/
         1YkqH0O5ZsIQ+NhHxTh/eD1vTkqbS8sC36PvGPcbfRf8squ+4lAUbMXYBIKf7aXOFXGQ
         g7H5kxl+IGB3T1c9XBkrJavX4ZUp/26PvgaPCDTzGZSJcBuEK/ZNyz3a9jfV+k2fpUIk
         UhY9/Z1rO1ko2MckFZZ7OKLU4CjuxTfeTXC2Wh7CqnakDmHrijAZ5UtyzjqjW2XgYSTK
         92ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893890; x=1702498690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8htIAC9kRG6RYa6OvogGIifB3FzQt1zgdxaJBwAA+IQ=;
        b=phVdHL4ojC1fnEMK3VefvUj2JXnew9YZu8DYnf/QxmGUSXGoW4cuex6YGHtbQaXM/s
         6fHhY3XELIfHsGQi2INtB53Dwwu1y6WdpV0X8Cr7TOade5PXNUSpUY/CbzO7dUzD/jzR
         LlDbBT+DGEu8q60nGtESd4/XhfT56IATYsROfVYT4rrw7G4iKRsj0dRWl49Jl2ZG93bg
         3czBNl1Im35f8gxaQzDv9TcsUdXJbigOrDXcTgjsvzPW/sC6LFGjQO2MQEUEGNxf9jci
         1umNnXzWYAEntLJn0IaTlFz9cGEAi8HbG3kGnjf4hUWLlOuikD9tRwnmgzVw/RtItRjp
         KT8A==
X-Gm-Message-State: AOJu0YzZox+2XJtB4OCysILoaA8iSEYARbdPjlgIoLp8pGgTIeWyZZH7
	yYK3Jjy8vyMuPHPpGET6RoxHwJxu3kh0IQ==
X-Google-Smtp-Source: AGHT+IGk5rkDCHmqcigyePXQQVpmVMm9zgr8aeyVjZUzK62TUz9Hr4KRw5YAu1t/HpwuSjwrTuNUIg==
X-Received: by 2002:a17:902:e9c5:b0:1d0:ced9:3093 with SMTP id 5-20020a170902e9c500b001d0ced93093mr1515538plk.81.1701893890024;
        Wed, 06 Dec 2023 12:18:10 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/13] unit: use authenticator_fte
Date: Wed,  6 Dec 2023 12:17:55 -0800
Message-Id: <20231206201802.2139649-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-eapol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 563541f5..5317f9ad 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3493,7 +3493,7 @@ static void eapol_ft_handshake_test(const void *data)
 	handshake_state_set_supplicant_ie(hs, own_rsne);
 	handshake_state_set_authenticator_ie(hs, ap_rsne);
 	handshake_state_set_mde(hs, mde);
-	handshake_state_set_fte(hs, fte);
+	handshake_state_set_authenticator_fte(hs, fte);
 	handshake_state_set_kh_ids(hs, r0khid, strlen((void *) r0khid), r1khid);
 	eapol_start(sm);
 
-- 
2.34.1

