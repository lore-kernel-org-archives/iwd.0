Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B437147
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlHdwIm/"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-677f974b72bso4167156d6.3
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 11:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700250481; x=1700855281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlnQaSgcVtzF3mkDr2A2TmW+UcHDdm67QrWrT0kOyGE=;
        b=mlHdwIm/hF7l/Lkmc43ea1qLHUK/5pfLe+pcgVUHvYG4ZQajPI21JpzjYH6yMf/MOQ
         4z17a8rDU7D5K9+yVnuLldfXPWw774MBGf4vSxhxkiMU3lRMKoomXuMYoTHLlq5eHqez
         c1GhGdWxmNRsWwRWZYQcPXDNt9E6IMdEtwD9WEfOOg/i65SYaD0+quZWQ8Rx08n4oc1L
         ga+wJXbuRxrRN5TtzHLwKC/uSQL8IGYtoPWuSQSEfofO9AnKUroX7tJC7KclwCRJ7miS
         kV79KG1YTzIlGMRuzmkNZKEK0zbs9w759KLEpELDmPEhFhYMiPvhFXAPdA6tptw7UHB3
         eiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700250481; x=1700855281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlnQaSgcVtzF3mkDr2A2TmW+UcHDdm67QrWrT0kOyGE=;
        b=Hn5WraWZKUH6/JZjURYvvoV833kww/kFX16kTLUQKR9C6AgnaF3PrmGq4Ahx3Jbxkm
         w0ZN8x9ZcCfu+Y0j0+NX2+I/FJhm6pTzz7cmQHOz+zIeRjGjxVVPOYY5hw03VT9Zquor
         CQsidEaQWxAYDZMSqBuvPWom59DMFtZXnwCgc7ZaFdx8YVaLmdaIR2V3rk1nAu4eV/m9
         swpCpMJ4YdGE9tiPRVjX31NNzOgatPxUzBc0oMkqTwE0k3xPMoHdF8w/RNwy5K1VNED3
         vj9zeUqiYWGxjGbUS8gJRrRNgkBeNRb7pK5TdN5htfdcqP5Qj7p4LWp68gQ2sHIsWJWA
         KL0g==
X-Gm-Message-State: AOJu0YyBCfzqqfS3qoRPYvLJEZzdufkRqyKIr/DoEgEK7PEwMGjX/tj9
	QaAuQE2fEM3+eK/+DlgXHCEkJZUetBo=
X-Google-Smtp-Source: AGHT+IETih+KtUnQqNcgId9q7M2jK6CPtwaLkMBRCo2kK+hoiriO4CYE95BxbwSVG4dLx1AMi0A+cw==
X-Received: by 2002:a05:6214:5016:b0:66d:10fd:4abb with SMTP id jo22-20020a056214501600b0066d10fd4abbmr139746qvb.16.1700250481476;
        Fri, 17 Nov 2023 11:48:01 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kh5-20020a056214514500b0064906cfe430sm862154qvb.135.2023.11.17.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:48:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] dbus: add SharedCodeAgent interface to iwd-dbus.conf
Date: Fri, 17 Nov 2023 11:47:50 -0800
Message-Id: <20231117194750.90786-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd-dbus.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/iwd-dbus.conf b/src/iwd-dbus.conf
index 7fc2e68c..f2509ebc 100644
--- a/src/iwd-dbus.conf
+++ b/src/iwd-dbus.conf
@@ -12,6 +12,7 @@
     <allow send_destination="net.connman.iwd"/>
     <allow send_interface="net.connman.iwd.Agent"/>
     <allow send_interface="net.connman.iwd.SignalLevelAgent"/>
+    <allow send_interface="net.connman.iwd.SharedCodeAgent"/>
   </policy>
 
   <policy group="wheel">
-- 
2.34.1

